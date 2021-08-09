require 'singleton'

class LineItem
  attr_reader :id, :parent, :children, :depth
  attr_accessor :item

  def initialize(id)
    @id = id
    @item = nil
    @parent = nil
    @children = []
  end

  def dump
    puts "#{' ' * (depth * 2)}+ #{item}"
    children.each { |child| child.dump }
  end

  def set_root
    @depth = 0
    update_children_depth
  end

  def set_parent(parent)
    @parent = parent
    parent.add_child(self)
    update_depth
  end

  def add_child(child)
    @children << child
  end

  def update_depth
    return if parent&.depth.nil?

    @depth = parent.depth + 1
    update_children_depth
  end

  private

  def update_children_depth
    children.each { |child| child.update_depth }
  end
end

class Task
  include Singleton

  def run
    while line = gets do
      process(*line.split(',').map(&:strip))
    end

    root.dump
  end

  private

  attr_reader :root, :items

  def initialize
    @root = nil
    @items = {}
  end

  def process(item, id, parent_id)
    line_item = (items[id] ||= LineItem.new(id: id))
    line_item.item = item

    if root_item?(parent_id)
      @root = line_item
      line_item.set_root
    else
      line_item.set_parent(parent_item(parent_id))
    end
  end

  def root_item?(parent_id)
    parent_id == 'nil'
  end

  def parent_item(parent_id)
    items[parent_id] ||= LineItem.new(id: parent_id)
  end
end

Task.instance.run

