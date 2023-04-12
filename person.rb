require './nameable'

class Person < Nameable
  def initialize(age, name = 'Unknown', parent_permission: true)
    super()
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  attr_accessor :name, :age

  attr_reader :id

  # the next line rubocop suggests "of_age?", I added a linter disable to met the requeriments
  def is_of_age? # rubocop:disable Naming/PredicateName
    @age >= 18
  end

  def can_use_services?
    if is_of_age? || @parent_permission
      true
    else
      false
    end
  end

  def correct_name
    @name
  end

  private :is_of_age?
end

class Decorator < Nameable
  def initialize(nameable)
    super()
    @nameable = nameable
  end

  def correct_name
    @nameable.correct_name
  end
end

class CapitalizeDecorator < Decorator
  def correct_name
    @nameable.correct_name.capitalize
  end
end

class TrimmerDecorator < Decorator
  def correct_name
    name = @nameable.correct_name
    if name.length > 10
      name[0...10]
    else
      name
    end
  end
end
