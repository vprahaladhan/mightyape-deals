class MightyApe::CLI 
  # @@BASE_URL = "https://www.mightyape.com.au"
  attr_accessor :offset, :page

  def initialize
    MightyApe::Scraper.get_all_promos
    @offset = 0
    @page = 1
  end

  def call
    welcome

    list_menu
    
    loop do
      input = gets.strip
      (input == 'q' || input == 'Q') && break 
  
      if (input.to_i > 0 && input.to_i <= Promotion.all.size) then
        list_promo_products(input)
      else 
        puts "Invalid input...Please see below menu for valid choices:"
      end
      
      list_menu
    end

    sign_off
  end

  def welcome 
    puts "\n"
    puts "************************************************************************"
    puts "***                    WELCOME TO MIGHTYAPE SALE!                    ***"
    puts "************************************************************************"
  end

  def list_menu
    puts "************************************************************************"
    puts '|'.ljust(36) + '|'.rjust(36) 
    puts '| ' + 'NO.'.ljust(4) + 'TITLE'.ljust(50) + "ENDS ON".ljust(15) + '|'
    puts '|'.ljust(36) + '|'.rjust(36)
    Promotion.all.each_with_index do |p, index|
      puts '| ' + ((index + 1).to_s + '.').ljust(4) + p.title.ljust(50) + p.expiry.ljust(15) + '|'
    end
    puts "************************************************************************"
    print "\nEnter your choice between 1-#{Promotion.all.size} ('q' or 'Q' to quit): "
  end
  
  def sign_off
    puts "\nThanks for trying out the app! See you again soon!!"  
  end

  def list_promo_products(input)
    @offset = 0
    @page = 1
    promo = Promotion.find_by_id(input.to_i)
    MightyApe::Scraper.get_promo_products(promo)
    list_products(promo)

    loop do
      if (@offset > 0) then 
        puts "Press 'p' for prev 10 products"
      end
      if (@offset + 10 <= promo.num_of_products) then
        puts "Press 'n' for next 10 products"
      end
      puts "Press 'q' to return to previous menu"

      print "Enter product no (#{offset + 1}-#{offset + 10}) to get more info on: "
      input = gets.strip
      if (input == 'q') then
        break
      elsif (@offset > 0 && input == 'p')
        @offset -= 10
        list_products(promo)
      elsif (@offset + 10 <= Product.all.size && input == 'n')
        @offset += 10
        list_products(promo)
      elsif (input.to_i > @offset && input.to_i < @offset + 11)
        Product.all[input.to_i - 1].print
      else
        puts "Invalid choice! Valid choices are #{offset + 1}-#{offset + 10}!!"
      end
    end
  end

  def list_products(promo)
    puts "\n************************************************************************"
    if (@offset == Product.all.size) then
      @page += 1
      MightyApe::Scraper.get_promo_products(promo, @page)
    end  
    Product.all[@offset..(@offset + 9)].each_with_index do |p, index| 
      puts '| ' + ((@offset + index + 1).to_s << '. ').ljust(5) + "#{p.title}".ljust(64) + '|'
    end
    puts "************************************************************************"
  end
end