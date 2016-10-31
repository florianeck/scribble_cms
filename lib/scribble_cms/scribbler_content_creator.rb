class ScribblerContentCreator

  include ::ScribblerContentHelper

  attr_reader :scribbler_element_instance

  def initialize(container_name, group_name, type, name)
    scribbler_element(container_name, group_name, type, name)

    # find what the element is, by searching throug the levels of scribbler
    container = ScribblerContainer.find_by_name(container_name)
    group     = ScribblerGroup.find_by(name: group_name, container_id: container.id)
    opts      = { name: name, released: true, group_id: group.id }
    element_type = case type.to_sym
    when :link
      ScribblerLink
    when :row
      opts.merge!(plain: true)
      ScribblerText
    when :text
      opts.merge!(plain: false)
      ScribblerText
    when :image
      ScribblerImage
    when :var
      ScribblerVar
    end

    @scribbler_element_instance = element_type.find_by(opts)
  end

  def update_instance!(data = {})
    @scribbler_element_instance.update_attributes(data)
  end

end