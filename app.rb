require './person'
require './student'
require './teacher'
require './book'
require './capitalize_decorator'
require './trimmer_decorator'
require './classroom'

class App
  def initialize
    @people = []
    @books = []
    @rentals = []
    @classroom = Classroom.new('101')
  end

  attr_reader :rentals, :people, :books

  def number_input(text, valid_options)
    loop do
      print text
      input = gets.chomp.to_i
      return input if valid_options.include?(input)
    end
  end

  def select_book_from_list
    puts 'Select a book from the following list by number'
    @books.each_with_index do |book, index|
      puts "#{index + 1}) Title: \"#{book.title}\" Author: #{book.author} "
    end
    number_input('Option: ', (1..@books.length))
  end

  def select_person_from_list
    puts 'Select a person from the following list by number (not id)'
    @people.each_with_index do |person, index|
      print "#{index + 1}) #{person.is_a?(Teacher) ? '[Teacher]' : '[Student]'} "
      puts "Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    number_input('Option: ', (1..@people.length))
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
      @people.push(Teacher.new(age, specialization, name))
    else
      permission = letter_input('Has parent permission? [Y/N]: ', %w[y n])
      @people.push(Student.new(age, @classroom, name, parent_permission: permission))
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
    @books.push(Book.new(title, author))
    puts 'Book created successfully'
  end

  def can_create_rental?
    if @books.empty?
      puts 'There are no books for rentals'
      return false
    end
    if @people.empty?
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
    if index_book.negative? || index_book >= books.length
      puts 'Invalid selection'
      return
    end
    index_person = select_person_from_list - 1
    if index_person.negative? || index_person >= people.length
      puts 'Invalid selection'
      return
    end
    date = valid_date('Date (yyyy/mm/dd): ')
    @rentals.push(Rental.new(date, @books[index_book], @people[index_person]))
    puts 'Rental created successfully'
  end

  def valid_person(text)
    loop do
      print text
      input = gets.chomp.to_i
      return input if @people.find(-> { false }) { |per| per.id == input }
    end
  end

  def list_rentals
    if @rentals.empty?
      puts 'No Rentals to show'
      return
    end
    id = valid_person('ID of person: ')
    puts 'Rentals'
    @rentals.each do |rental|
      if rental.person.id == id.to_i
        print("Date: #{rental.date} ")
        puts("Book \"#{rental.book.title}\" by #{rental.book.author} ")
      end
    end
  end

  def list_books
    if @books.empty?
      puts 'There are no books to show'
      return
    end
    @books.each { |book| puts "Title: \"#{book.title}\", Author: #{book.author}" }
  end

  def list_people
    if @people.empty?
      puts 'There are no people to show'
      return
    end
    @people.each do |person|
      print '[Teacher] ' if person.is_a?(Teacher)
      print '[Student] ' if person.is_a?(Student)
      puts "Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end
end
