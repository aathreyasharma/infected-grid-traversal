class Grid
  attr_accessor :rows, :cols, :size, :cities, :medical_centres
  def initialize(grid, infectedCells, medical_centres)
    @infection_info = infectedCells.map(&:values).map(&:reverse!) rescue []
    @medical_centres = medical_centres.map(&:values).map(&:reverse!) rescue []
    max_size = @infection_info.flatten.max
    @cols = grid[:length].to_i rescue max_size
    @rows = grid[:breadth].to_i rescue max_size
    @cities = []
    create_nodes
    update_infection
    update_medical_centres
  end

  def create_nodes
    @rows.times{|i| @cities << Array.new(@cols) { Node.new } }
  end

  def size
    [@rows, @cols]
  end

  def cities
    @cities
  end

  def update_infection
    @infection_info.each do |arr|
      @cities[@rows - 1 - arr[0]][arr[1]].infect
    end
  end

  def update_medical_centres
    @medical_centres.each do |arr|
      x = @rows - 1 - arr[0]
      y = arr[1]
      @cities[x][y].hospitalize
      @cities[x+1][y].immunize
      @cities[x-1][y].immunize
      @cities[x][y-1].immunize
      @cities[x][y+1].immunize
    end
  end

  def medical_centres
    @cities.flatten.select{|city| city.medical_centre?}
  end

  def immune_cities
    @cities.flatten.select{|city| city.immune?}
  end

  def show
    @cities.map{ |x| x.map(&:status) }
  end
end

