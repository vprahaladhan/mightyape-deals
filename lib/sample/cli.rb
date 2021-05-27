class Sample::CLI 
  
  def initialize
    Sample::Scraper.new.get_page
  end

  def call
    welcome

    list_menu
    
    loop do
      input = gets.strip
      (input == 'q' || input == 'Q') && break 
  
      if (input.to_i > 0 && input.to_i <= Promotion.all.size) then
        ap Promotion.find_by_id(input.to_i)
      else 
        puts "Invalid input...Please see below menu for valid choices:"
        list_menu
      end
    end

    sign_off
  end

  def welcome 
    puts "Welcome to my Sample Ruby app!".upcase
  end

  def list_menu
    Promotion.all.each_with_index do |p, index|
      puts "#{index + 1}. #{p.title}"
    end
    print "Enter your choice between 1-12 ('q' or 'Q' to quit): "
  end
  
  def sign_off
    puts "Thanks for trying out the app! See you again soon!!"  
  end
end