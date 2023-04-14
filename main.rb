require './app'

def main
  app = App.new

  loop do
    display_options
    option = gets.chomp
    handle_option(app, option)
  end
end

def display_options
  puts 'Please choose an option by entering a number:'
  puts '1 - List all books'
  puts '2 - List all people'
  puts '3 - Create a person'
  puts '4 - Create a book'
  puts '5 - Create a rental'
  puts '6 - List all rentals for a given person id'
  puts '7 - Exit'
end

def handle_option(app, option)
  options = {
    '1' => -> { app.list_all_books },
    '2' => -> { app.list_all_people },
    '3' => -> { create_person(app) },
    '4' => -> { create_book(app) },
    '5' => -> { create_rental(app) },
    '6' => -> { list_rentals_for_person_id(app) },
    '7' => lambda {
             puts 'Thank you for using this app!'
             exit
           }
  }

  if options[option]
    options[option].call
  else
    handle_invalid_option
  end

  puts
end

def handle_invalid_option
  puts 'Invalid option'
end

def create_person(app)
  print('Do you want to create a student (1) or a teacher (2)? [Input the number]: ')
  type = gets.chomp == '1' ? 'student' : 'teacher'

  print('Age: ')
  age = gets.chomp.to_i

  print('Name: ')
  name = gets.chomp

  parent_permission = true
  if type == 'student'
    print('Has parent permission? [Y/N]: ')
    parent_permission = gets.chomp.downcase == 'y'
  end

  app.create_person(type, age, name, parent_permission)
end

def create_book(app)
  print('Title: ')
  title = gets.chomp

  print('Author: ')
  author = gets.chomp

  app.create_book(title, author)
end

def create_rental(app)
  print('Select a book from the following list by number:')
  puts
  app.books.each_with_index do |book, index|
    puts "#{index}) Title: #{book.title}, Author: #{book.author}"
  end
  book_index = gets.chomp.to_i

  print('Select a person from the following list by number (not ID):')
  puts
  app.people.each_with_index do |person, index|
    puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
  end
  person_index = gets.chomp.to_i

  app.create_rental(app.people[person_index].id, book_index)
end

def list_rentals_for_person_id(app)
  print('ID of person: ')
  person_id = gets.chomp.to_i

  app.list_rentals_for_person_id(person_id)
end

main
