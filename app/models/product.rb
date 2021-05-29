class Product
  @@all = []
  attr_accessor :title, :price, :rating, :availability, :delivery

  def self.all
    @@all
  end

  def self.clear
    @@all.clear
  end

  def initialize(title, price, rating, availability, delivery)
    @title = title
    @price = price
    @rating = rating
    @availability = availability
    @delivery = delivery
    @@all << self
  end

  def print
    puts "\n"
    puts "************************************************************************"
    puts "                           PRODUCT DETAILS!                             "
    puts "************************************************************************"
    puts "Name: #{@title}"
    puts "Price: $#{@price}"
    puts "Rating: #{@rating}"
    puts "Availability: #{@availability}"
    puts "Delivery: #{@delivery}"
  end

end