require './book'
require './person'
require './rental'
require './student'
require './teacher'
require './classroom'

class App
  attr_accessor :books, :people, :rentals

  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def list_all_books
    @books.each { |book| puts "Title: #{book.title}, Author: #{book.author}" }
  end

  def list_all_people
    @people.each do |person|
      puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def create_person(type, age, name, parent_permission)
    case type
    when 'student'
      print('Classroom: ')
      classroom_label = gets.chomp
      classroom = Classroom.new(classroom_label)
      person = Student.new(age, classroom, name, parent_permission: parent_permission)
    when 'teacher'
      print('Specialization: ')
      specialization = gets.chomp
      person = Teacher.new(age, specialization, name)
    else
      puts 'Invalid person type'
      return
    end

    @people << person
    puts 'Person created successfully'
  end

  def create_book(title, author)
    book = Book.new(title, author)
    @books << book
    puts 'Book created successfully'
  end

  def create_rental(person_id, book_index)
    puts 'Date: '
    date = gets.chomp

    person = @people.detect { |person| person.id == person_id }
    book = @books[book_index]

    rental = Rental.new(date, book, person)
    @rentals << rental
    puts 'Rental created successfully'
  end

  def list_rentals_for_person_id(person_id)
    rentals = @rentals.filter { |rental| rental.person.id == person_id }
    puts 'Rentals:'
    rentals.each do |rental|
      puts "Date: #{rental.date}, Book: #{rental.book.title} by #{rental.book.author}"
    end
  end
end
