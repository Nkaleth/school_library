require './app'

def main
  app = App.new

  loop do
    puts 'Please choose an option by entering a number:'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'

    option = gets.chomp

    case option
    when '1'
      app.list_all_books
    when '2'
      app.list_all_people
    when '3'
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
    when '4'
      print('Title: ')
      title = gets.chomp

      print('Author: ')
      author = gets.chomp

      app.create_book(title, author)
    when '5'
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
    when '6'
      print('ID of person: ')
      person_id = gets.chomp.to_i

      app.list_rentals_for_person_id(person_id)
    when '7'
      puts 'Thank you for using this app!'
      break
    else
      puts 'Invalid option'
    end

    puts
  end
end

main
