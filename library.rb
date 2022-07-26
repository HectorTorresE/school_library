require 'json'
require_relative 'classroom'

class Library
  attr_reader :books, :classroom, :people, :rentals

  def initialize
    @books = []
    @classroom = Classroom.new('101')
    @people = []
    @rentals = []
  end

  def load_objects(file_name)
    if File.exist?(file_name)
      return JSON.parse(File.read(file_name), create_additions: true)
    end
    []
  end

  def load_data
    @books = load_objects('books.json')
    @people = load_objects('people.json')
    # @rentals = load_objects('rentals.json')
  end

  def save_objects(file_name, objects)
    File.write(file_name, JSON.generate(objects)) unless objects.empty?
  end

  def save_data
    save_objects('./books.json', @books)
    save_objects('./people.json', @people)
    # save_objects('./rentals.json', @rentals)
  end
end