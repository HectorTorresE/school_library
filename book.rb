require 'json'

class Book
  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
  end

  attr_accessor :title, :author, :rentals

  def add_rental(rental)
    @rentals.push(rental)
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'data' => [title, author]
    }.to_json(*args)
  end

  def self.json_create(object)
    new(*object['data'])
  end
end
