require_relative './person'
require_relative './student'
require_relative './teacher'
require_relative './book'
require_relative './capitalize_decorator'
require_relative './trimmer_decorator'
require_relative './library'

class App
  attr_reader :library

  def initialize
    @library = Library.new
    library.load_data
  end

  def number_input(text, valid_options)
    loop do
      print text
      input = gets.chomp.to_i
      return input if valid_options.include?(input)
    end
  end

  def select_book_from_list
    puts 'Select a book from the following list by number'
    library.books.each_with_index do |book, index|
      puts "#{index + 1}) Title: \"#{book.title}\" Author: #{book.author} "
    end
    number_input('Option: ', (1..library.books.length))
  end

  def select_person_from_list
    puts 'Select a person from the following list by number (not id)'
    library.people.each_with_index do |person, index|
      print "#{index + 1}) #{person.is_a?(Teacher) ? '[Teacher]' : '[Student]'} "
      puts "Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    number_input('Option: ', (1..library.people.length))
  end

  def create_person_menu
    loop do
      print 'Do you want to create a student (1) or a teacher (2)? [Input the number]:'
      option = gets.chomp.to_i
      return option.to_i if option >= 1 && option < 3
    end
  end

  def create_person
    person_type = create_person_menu
    print 'Age: '
    age = gets.chomp
    print 'Name: '
    name = gets.chomp
    if person_type == 2
      specialization = teacher_info
      library.people.push(Teacher.new(age, specialization, name))
    else
      permission = letter_input('Has parent permission? [Y/N]: ', %w[y n]) == 'y'
      library.people.push(Student.new(age, library.classroom, name, parent_permission: permission))
    end
    puts 'Person created successfully'
  end

  def letter_input(text, valid_options)
    loop do
      print text
      input = gets.chomp.downcase
      return input if valid_options.include?(input)
    end
  end

  def teacher_info
    print 'Specialization: '
    gets.chomp
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    library.books.push(Book.new(title, author))
    puts 'Book created successfully'
  end

  def can_create_rental?
    if library.books.empty?
      puts 'There are no books for rentals'
      return false
    end
    if library.people.empty?
      puts 'There are no people for rentals'
      return false
    end
    true
  end

  def valid_date(text)
    loop do
      puts text
      date = gets.chomp
      y, m, d = date.split '/'
      return date if (y.to_i > 2000) && (m.to_i > 1 || m.to_i < 12) && (d.to_i > 1 || d.to_i < 31)
    end
  end

  def create_rental
    return unless can_create_rental?

    index_book = select_book_from_list - 1
    if index_book.negative? || index_book >= library.books.length
      puts 'Invalid selection'
      return
    end
    index_person = select_person_from_list - 1
    if index_person.negative? || index_person >= library.people.length
      puts 'Invalid selection'
      return
    end
    date = valid_date('Date (yyyy/mm/dd): ')
    library.rentals.push(Rental.new(date, library.books[index_book], library.people[index_person]))
    puts 'Rental created successfully'
  end

  def valid_person(text)
    loop do
      print text
      input = gets.chomp.to_i
      found = library.rentals.find(-> {}) { |rental| rental.person.id == input }
      return input unless found.nil?
    end
  end

  def list_rentals
    if library.rentals.empty?
      puts 'No Rentals to show'
      return
    end
    person_id = valid_person('ID of person: ')
    puts 'Rentals'
    library.rentals.each do |rental|
      if rental.person.id == person_id
        puts("Date: #{rental.date} - Book \"#{rental.book.title}\" by #{rental.book.author} ")
      end
    end
  end

  def list_books
    if library.books.empty?
      puts 'There are no books to show'
      return
    end
    library.books.each { |book| puts "Title: \"#{book.title}\", Author: #{book.author}" }
  end

  def list_people
    if library.people.empty?
      puts 'There are no people to show'
      return
    end
    library.people.each do |person|
      print '[Teacher] ' if person.is_a?(Teacher)
      print '[Student] ' if person.is_a?(Student)
      puts "Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def save_data
    library.save_data
  end
end
