require_relative 'app'
class Main
  attr_reader :app

  def initialize
    @app = App.new
  end

  def main_menu
    loop do
      print "\n\n"
      puts 'Please choose an option by entering a number:'
      puts '1.- List all books'
      puts '2.- List all people'
      puts '3.- Create a person'
      puts '4.- Create a book'
      puts '5.- Create a rental'
      puts '6.- List all rentals for a given person id'
      puts '7.- Exit'
      option = gets.chomp.to_i
      return option if option >= 1 && option < 8
    end
  end

  def show_menu
    loop do
      case main_menu
      when 1
        app.list_books
      when 2
        app.list_people
      when 3
        app.create_person
      when 4
        app.create_book
      when 5
        app.create_rental
      when 6
        app.list_rentals
      else
        puts 'Thanks for using this app!'
        app.save_data
        return
      end
    end
  end

  def run
    print "\n\nWelcome to School Library App!\n"
    show_menu
  end
end

main = Main.new
main.run
