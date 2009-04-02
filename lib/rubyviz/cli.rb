require 'optparse'
require 'fileutils'
require 'parse_tree'
require 'graphviz'

module Rubyviz
  class CLI
    def self.execute(stdout, arguments=[])

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
    
    def self.generate_png(input)
      @g = GraphViz::new( "G", "output" => "png" )

      tree = ParseTree.translate(File.read(input))
      visit_tree(tree)
      # v = g.add_node( '"@var1"' )
      #      
      #      g.add_edge( a, v )

      @g.output( :file => "#{input}.png" )
    end
    
    def self.visit_tree(t)
      visit_statement(t)
    end
    
    def self.visit_statement(n)
      if n.class == Array
        if [:ivar, :iasgn].include?(n[0])
          visit_var(n[1])
        elsif [:defn].include?(n[0])
          visit_defn(n)
        elsif [:vcall, :fcall].include?(n[0])
          graph_method_call(n[1])
        end
        n.each do |child|
          if (child.class == Array)
            visit_statement(child)
          end
        end
      end
    end
    
    def self.visit_defn(d)
      name = d[1].to_s
      @m = @g.add_node( name )
    end
    
    def self.visit_var(v)
      name = v.to_s
      @v = @g.add_node( "\"#{name}\"")
      @g.add_edge(@m, @v)
    end
    
    def self.graph_method_call(sym)
      return if @m == nil
      return if [:puts, :system, :raise, :require, :exit].include?(sym)
      name = sym.to_s
      call = @g.add_node( name )
      @g.add_edge(@m, call)
    end
  end
end