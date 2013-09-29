module Jekyll
  class Random < Liquid::Block
    def initialize(tag_name, delimeter, tokens)
      delimeter = "-" if delimeter.empty?
      @delimeter = delimeter
      super
    end

    def render(context)
      return super.split(@delimeter).sample
    end
  end
end

Liquid::Template.register_tag('random', Jekyll::Random)
