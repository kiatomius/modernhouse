class Modernhouse::CLI

  def call
    list_houses
    menu
    goodbye
  end

  def list_houses
    puts "Houses Currently on sale:"
    @houses = Modernhouse::House.today
    @houses.each.with_index(1) do |house, i|
      #puts "#{i}. #{house.name} - #{house.price} - #{house.availability}"
      puts "#{i}. #{house.name} - #{house.price}"
    end
  end

  def menu
    input = nil
    while input != "exit"
      puts "Enter the number of the house you'd like more info on or type list to see the deals again or type exit:"
      input = gets.strip.downcase

      if input.to_i > 0
        the_house = @houses[input.to_i-1]
        puts "Building Name : #{the_house.name}"
        puts "Building Price: #{the_house.price}"
        puts "Building Location: #{the_house.location}"
        puts "#{the_house.architect}"
        puts "#{the_house.description}"
        puts "for more information, visit url: #{the_house.url}"

      elsif input == "list"
        list_houses
      else
        puts "Not sure what you want, type list or exit."
      end
    end
  end

  def goodbye
    puts "See you tomorrow for more deals!!!"
  end
end
