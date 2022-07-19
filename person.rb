require './nameable'

class Person < Nameable
  # Constructor
  def initialize(age, name = 'Unknown', parent_permission: true)
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    super
  end

  attr_reader :id

  attr_accessor :name, :age

  def can_use_services?
    @age >= 18 || parent_permission
  end

  def correct_name
    name
  end

  private

  def of_age?
    @age >= 18
  end
end
