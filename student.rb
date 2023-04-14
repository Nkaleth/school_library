require './person'

class Student < Person
  attr_reader :classroom

  def initialize(classroom, age, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission:) # rubocop:disable Lint/Syntax
    @classroom = classroom

    classroom.students << self
  end

  def play_hooky
    '¯\\_(ツ)_/¯'
  end
end
