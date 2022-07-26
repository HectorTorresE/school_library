require 'json'
require_relative './person'

class Teacher < Person
  def initialize(age, specialization, name = 'Unknown', id = Random.rand(1..1000), parent_permission: true)
    @specialization = specialization
    super(age, name, id, parent_permission: parent_permission)
  end

  def can_use_services?
    true
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'data' => [@age, @specialization, @name, id]
    }.to_json(*args)
  end

  def self.json_create(object)
    age, specialization, name, id = object['data']
    new(age, specialization, name, id)
  end
end
