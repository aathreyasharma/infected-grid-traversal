class Person
  attr_accessor :current_direction, :current_node, :locate, :type

  def initialize(params)
    @movements = params[:movement].downcase.gsub(/[^flr]/, '').chars
    initials = params['initialPosition'].split(' ')
    @type = params['type']
    @current_direction = initials.pop.downcase
    initials.map!(&:to_i).reverse!
    @current_node = initials
    @current_node[0] = $grid.rows - 1 - @current_node[0]
    @infected = $grid.cities[@current_node[0]][@current_node[1]].infected? && !medic?
    $grid.cities[@current_node[0]][@current_node[1]].add_visitor(self)
  end

  def turn(turn=nil)
    @current_direction = $directions[@current_direction][turn] unless turn.nil?
  end

  def medic?
    @type == 'medic'
  end

  def forward
    case @current_direction.to_s
    when 'n'
      return "Cannot move forward" if @current_node[0] == 0
      @current_node[0] -= 1
    when 's'
      return "Cannot move forward" if @current_node[0] == $grid.rows - 1
      @current_node[0] += 1
    when 'e'
      return "Cannot move forward" if @current_node[1] == $grid.cols - 1
      @current_node[1] += 1
    when 'w'
      return "Cannot move forward" if @current_node[1] == 0
      @current_node[1] -= 1
    end
    update_infection
    @current_node
  end

  def update_infection
    city = $grid.cities[@current_node[0]][@current_node[1]]
    if city.medical_centre?
      self.disinfect if infected?
    elsif city.immune?
      # Do nothing
    else
      if !city.infected?
        city.infect if infected?
      else
        if self.medic?
          city.disinfect
        else
          infect if city.infected?
        end
      end
    end
  end

  def travel
    return 'No movements' if @movements.length == 0
    @movements.each do |char|
      move(char)
    end
  end

  def infect
    @infected = true
  end

  def disinfect
    @infected = false
  end

  def infected?
    @infected
  end

  def locate
    nodes = Marshal.load(Marshal.dump($grid.cities))
    nodes = nodes.map{ |x| x.map(&:status) }
    nodes[@current_node[0]][@current_node[1]] = 'HERE'
    pp nodes
  end

  def move(char)
    case char
    when 'f'
      forward
    else
      turn(char)
    end
  end

  private

  def go
    move(@movements.shift)
  end
end
