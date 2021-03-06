module ScribblerContentHelper

  def scribbler_container(container_name, options = {}, &block)
    container_name = "#{container_name}-#{options[:element].page.name}-#{options[:element].id}" if options[:element]
    q = {:name => container_name, :scaleable => (options[:scaleable].nil? ? false : options[:scaleable]), :element_id => (options[:element] ? options[:element].id : nil)}
    container = ScribblerContainer.where(:name => container_name).first || ScribblerContainer.create(q)
    container.update_attributes(:scaleable => options[:scaleable]) if options[:scaleable] && container.scaleable != options[:scaleable]
    yield(container)
  end

  def scribbler_group(container, group, &block)
    scribbler_container(container) do |c|
      c.scribbler_group(group) do |g|
        yield(g)
      end
    end
  end

  def scribbler_element(container, group, type, name, options = {}, &block)
    if block_given?
      options[:default] = capture(&block).html_safe.strip.force_encoding("UTF-8")
    end

    scribbler_group(container.to_s, group.to_s) do |g|
      v = g.send(type.to_s, name.to_s, options)
      if v.blank? && options[:default]
        options[:default]
      else
        return v
      end
    end
  end

end