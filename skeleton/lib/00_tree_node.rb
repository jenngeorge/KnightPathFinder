class PolyTreeNode
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent=(node=nil)
    @parent.children.delete(self) unless @parent.nil?
    @parent = node
    node.children << self unless node.nil? || node.children.include?(self)
  end

  def add_child(child_node)
    @children << child_node unless @children.include?(child_node)
    child_node.parent = self
  end

  def remove_child(child)
    if @children.include?(child)
      @children.delete(child)
      child.parent = nil
    else
      raise "Not a child!"
    end
  end

  def dfs(target_value)
    return self if @value == target_value
    @children.each do |child|
      result = child.dfs(target_value)
      return result if result
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      last = queue.shift
      return last if last.value == target_value
      last.children.each {|child| queue << child} unless last.children.empty?
    end
    nil
  end

end
#
# A= PolyTreeNode.new('A')
# B= PolyTreeNode.new('B')
# C= PolyTreeNode.new('C')
# D= PolyTreeNode.new('D')
# E= PolyTreeNode.new('E')
# F= PolyTreeNode.new('F')
# G= PolyTreeNode.new('G')
#
# A.add_child(B)
# A.add_child(C)
# B.add_child(D)
# B.add_child(E)
# C.add_child(F)
# C.add_child(G)
#
# A.dfs('E')
