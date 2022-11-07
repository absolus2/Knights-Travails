class GraphNode
  attr_accessor :value, :neightbors

  def initialize(value)
    @value = value
    @neightbors = []
  end
  
end

class Graph
  attr_accessor :nodes, :list

  def initialize(list)
    @nodes = []
    @list = list.repeated_permutation(2).to_a
  end

  def add_nodes
    @list.each { |item| @nodes.push(GraphNode.new(item)) }
  end

  def find(value)
    nodes.find { |item| item.value == value }
  end

  def check_nodes
    nodes.each { |n| p n.value }
  end

  def add_edge
    nodes.each do |n|
      fila = n.value[0]
      column = n.value[1]
      valor = [[fila + 1, column + 2], [fila + 2, column + 1], [fila - 1, column - 2], [fila - 2, column - 1], [fila + 1, column -2], [fila + 2 , column -1], [fila + 2, column -1], [fila -1, column + 2]]
      valor.each do |item|
        n.neightbors.push(item) if list.include?(item)
      end
    end
  end

  def recom(tail, came_from)
    path = []

    until tail.nil?
      path.push(tail)
      tail = came_from[tail]
    end

    path.reverse
  end

  def find_edge(start, goal, queu = Queue.new,  came_from = { start => nil })
    queu.enq(start)

    until queu.empty?
      curr = queu.deq
      return show_path(recom(goal, came_from)) if curr == goal

      find(curr).neightbors.each do |n|
        unless came_from.key?(n)
          came_from[n] = curr
          queu.enq(n)
        end
      end
    end
  end

  def show_path(path)
    p "=> You made it in #{path.size - 1} moves!  Here's your path"
    path.each do |item|
      p item
    end
  end

end

new_graph = Graph.new([1,2,3,4,5,6,7,8])
new_graph.add_nodes
new_graph.add_edge
new_graph.find_edge([3, 3], [8, 8])

