require './student'

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
end
