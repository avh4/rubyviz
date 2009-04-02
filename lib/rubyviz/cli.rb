require 'optparse'
require 'fileutils'
require 'parse_tree'
require 'graphviz'

module Rubyviz
  class CLI
    def self.execute(stdout, arguments=[])
      new().execute(stdout, arguments)
    end
    
    def initialize
      @attr_readers = []
      @attr_writers = []
    end
    
    def execute(stdout, arguments=[])

      # NOTE: the option -p/--path= is given as an example, and should be replaced in your application.

      options = {
        :path     => '~'
      }
      mandatory_options = %w(  )

      parser = OptionParser.new do |opts|
        opts.banner = <<-BANNER.gsub(/^          /,'')
          This application is wonderful because...

          Usage: #{File.basename($0)} [options]

          Options are:
        BANNER
        opts.separator ""
        opts.on("-p", "--path=PATH", String,
                "This is a sample message.",
                "For multiple lines, add more strings.",
                "Default: ~") { |arg| options[:path] = arg }
        opts.on("-h", "--help",
                "Show this help message.") { stdout.puts opts; exit }
        opts.parse!(arguments)

        if mandatory_options && mandatory_options.find { |option| options[option.to_sym].nil? }
          stdout.puts opts; exit
        end
      end

      path = options[:path]

      # do stuff
      generate_png(arguments[0])
    end
    
    def generate_png(input)
      @g = GraphViz::new( "G", "output" => "png" )

      tree = ParseTree.translate(File.read(input))
      visit_tree(tree)
      # v = g.add_node( '"@var1"' )
      #      
      #      g.add_edge( a, v )

      @g.output( :file => "#{input}.png" )
    end
    
    def visit_tree(t)
      visit_statement(t)
    end
    
    def visit_statement(n)
      if n.class == Array
        if [:ivar, :iasgn].include?(n[0])
          visit_var(n[1])
        elsif [:defn].include?(n[0])
          visit_defn(n)
        elsif [:vcall, :fcall].include?(n[0])
          graph_method_call(n[1])
          if n[1] == :attr_reader
            visit_attr_reader(n)
          elsif n[1] == :attr_writer
            visit_attr_writer(n)
          elsif n[1] == :attr_accessor
            visit_attr_reader(n)
            visit_attr_writer(n)
          end
        elsif [:call, :attrasgn].include?(n[0])
          if n[1][0] == :self
            graph_method_call(n[2])
          end
        end
        n.each do |child|
          if (child.class == Array)
            visit_statement(child)
          end
        end
      end
    end
    
    def visit_attr_reader(n)
      children = n[2].clone
      children.shift
      children.each do |child|
        mark_attr_reader(child[1])
      end
    end
    
    def visit_attr_writer(n)
      children = n[2].clone
      children.shift
      children.each do |child|
        mark_attr_writer(child[1])
      end
    end
    
    def visit_defn(d)
      name = d[1].to_s
      @m = @g.add_node( "\"#{name}\"" )
    end
    
    def visit_var(v)
      name = v.to_s
      @v = @g.add_node( "\"#{name}\"")
      @g.add_edge(@m, @v)
    end
    
    def graph_method_call(sym)
      return if @m == nil
      return if [:puts, :system, :raise, :require, :exit].include?(sym)
      name = sym.to_s
      if @attr_readers.include?(name)
        visit_var("@#{name}")
      elsif @attr_writers.include?(name.sub(/=$/, ''))
        visit_var("@#{name.sub(/=$/, '')}")
      else
        call = @g.add_node( "\"#{name}\"" )
        @g.add_edge(@m, call)
      end
    end
    
    def mark_attr_reader(sym)
      name = sym.to_s
      @attr_readers.push(name)
    end
    
    def mark_attr_writer(sym)
      name = sym.to_s
      @attr_writers.push(name)
    end
  end
end