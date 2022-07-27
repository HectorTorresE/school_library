require 'json'
require_relative './person'

class Student < Person
  def initialize(age, classroom, name = 'Unknown', id = Random.rand(1..1000), parent_permission: true)
    super(age, name, id, parent_permission: parent_permission)
    add_to_classroom(classroom)
  end

  attr_reader :classroom

  def add_to_classroom(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end

  def play_hooky
    '¯\(ツ)/¯'
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'data' => [@age, @classroom, @name, @id, @parent_permission]
    }.to_json(*args)
  end

  def self.json_create(object)
    age, classroom, name, id, parent_permission = object['data']
    new(age, classroom, name, id, parent_permission: parent_permission)
  end
end
