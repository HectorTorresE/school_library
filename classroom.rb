require_relative './student'

class Classroom
  def initialize(label)
    @label = label
    @students = []
  end

  attr_accessor :label
  attr_reader :students

  def add_student(student)
    student.classroom = self
    @students.push(student) unless @students.include?(student)
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'data' => [label]
    }.to_json(*args)
  end

  def self.json_create(object)
    new(*object['data'])
  end
end
