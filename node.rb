class Node
  attr_accessor :infected, :visitors, :disinfect, :medical_centre

  def initialize
    @infected = false
    @medical_centre = false
    @immune = false
    @visitors = []
  end

  def infect
    @infected = true if (!medical_centre? && !immune?)
  end

  def disinfect
    @infected = false
  end

  def infected?
    @infected
  end

  def status
    if medical_centre?
      'M'
    elsif immune?
      'I'
    elsif infected?
      'X'
    else
      '0'
    end
  end

  def medical_centre?
    @medical_centre
  end

  def immunize
    @immune = true
    @infected = false
  end

  def immune?
    @immune
  end

  def hospitalize
    @medical_centre = true
    @immune = true
    @infected = false
  end

  def add_visitor(visitor)
    @visitors << visitor
  end
end
