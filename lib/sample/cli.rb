class Sample::CLI 
  
  def initialize
    
  end

  def call
    puts "Welcome to my Sample Ruby app!".upcase
    list_menu
    
    input = nil

    while (input != 'q' && input != 'Q')
      case input
      when '1'
        puts "Eating..."
      when "2"
        puts "Sleeping..."
      when '3'
        puts "Running..."
      when '4'
        puts "Cleaning..."
      when '5'
        puts "Working out..."
      else 
        puts "Invalid input...Please see below menu for valid choices:"
      end

      list_menu
      input = gets.strip 
    end

    sign_off
  end

  def list_menu
    puts "1. Eat"
    puts "2. Sleep"
    puts "3. Run"
    puts "4. Clean"
    puts "5. Workout"
    print "Enter 'q' or 'Q' to quit: "
  end
  
  def sign_off
    puts "Thanks for trying out the app! See you again soon!!"  
  end
end