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
      if t[0] == :class
        visit_class(t)
      end
    end
    
    def self.visit_class(c)
      name = c[1]
      if c[3][0] == :scope
        scope = c[3]
        if scope[1][0] == :defn
          visit_defn(scope[1])
        end
        if scope[1][0] == :block
          visit_block(scope[1])
        end
      end
    end
    
    def self.visit_block(b)
      contents = b.clone
      contents.shift
      contents.each do |content|
        if content[0] == :defn
          visit_defn(content)
        end
      end
    end
    
    def self.visit_defn(d)
      name = d[1].to_s
      @m = @g.add_node( name )
    end
  end
end