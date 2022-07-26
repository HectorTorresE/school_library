require 'json'
require_relative './nameable'
require_relative './rental'

class Person < Nameable
  # Constructor
  def initialize(age, name = 'Unknown', id = Random.rand(1..1000), parent_permission: true)
    @id = id
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
    super()
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
