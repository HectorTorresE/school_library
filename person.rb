require './nameable'
require './rental'

class Person < Nameable
  # Constructor
  def initialize(age, name = 'Unknown', parent_permission: true)
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
    super
  end

  attr_reader :id

  attr_accessor :name, :age, :rentals

  def can_use_services?
    @age >= 18 || parent_permission
    correct_name
  end

  def correct_name
    name
  end

  def add_rental(rental)
    @rentals.push(rental)
  end

  private

  def of_age?
    @age >= 18
  end
end
