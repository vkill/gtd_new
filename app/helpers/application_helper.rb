module ApplicationHelper

  def translate_attribute(klass, attribute_name)
    klass.human_attribute_name(attribute_name)
  end
  alias :ta :translate_attribute

  def main_nav(name, options = {}, &block)
    if @main_nav == name
      if options[:class]
        options[:class] += " active"
      else
        options[:class] = "active"
      end
    end
    content = capture(&block)
    content_tag(:li, content, options)
  end

  def sec_nav(name, options = {}, &block)
    if @sec_nav == name
      if options[:class]
        options[:class] += " current"
      else
        options[:class] = "current"
      end
    end
    content = capture(&block)
    content_tag(:li, content, options)
  end

  def html_(s)
    s.gsub(/'/, '"').gsub(/\n/, '')
  end

end

