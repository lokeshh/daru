module Daru
  class Vector
    include Enumerable

    def each(&block)
      @vector.each(&block)
    end

    attr_reader :name

    attr_reader :size

    def initialize source, name=nil

      if source.is_a?(Hash)
        initialize source.values[0], source.keys[0]
      else
        @name = name || SecureRandom.uuid

        @vector = 
        case source
        when Range, Matrix
          source.to_a.flatten
        else
          source
        end

        @size = @vector.size
      end
    end

    def [](index)
      @vector[index]
    end

    def to_json
      @vector.to_a.to_json
    end

    def to_a
      @vector.to_a
    end

    def to_html threshold=15
      html = '<table><tr><th>' + @name.to_s + '</th></tr>>'

      @vector.to_a.each_with_index do |el,i|
        next if threshold < i and i < @arr.length-1
        content = i == threshold ? '...' : el.to_s
        html.concat('<tr><td>' + content  + '</td></tr>')
      end

      html += '</table>'
    end
  end
end