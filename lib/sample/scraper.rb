class Sample::Scraper
  @@BASE_URL = "https://www.mightyape.com.au"

  def self.get_all_promos
    doc = Nokogiri::HTML(open("https://www.mightyape.com.au/sales"))
    doc.css('.sale-grid li').each do |sale|
      prom = Promotion.new do |p|
        p.title = sale.css('.title').text
        p.link = sale.css('a[href]')[1].values[0]
        p.expiry = sale.css('span').text.strip.gsub('Ends ', '')
        # p.num_of_products = sale.css('.item-count').text.gsub(',', '').to_i
      end
      Promotion.find_or_create_by(title: prom.title, link: prom.link, num_of_products: prom.num_of_products, expiry: prom.expiry)
    end
  end

  def self.get_promo_products(promo, page_no=nil)
    page_no = page_no.nil? ? page_no : "?page=#{page_no}"
    page = open("#{@@BASE_URL}#{promo.link}").base_uri.to_s + page_no.to_s
    doc = Nokogiri::HTML(open(page))
    promo.num_of_products = doc.css('.summary .results .total').text.to_i

    if (page_no.nil?) then
      Product.clear
    end
    
    doc.css('.product .details').each do |p|
      title = p.css('.title a').text.strip
      price = (p.css('.dollars').text.strip + '.' + p.css('.cents').text.strip).to_f
      element = p.css('.customer-rating span[title]')[0]
      rating = element.class != NilClass ? element['title'] : 'Nil'
      availability = p.css('.stock-status').text.strip
      delivery = p.css('.ships-by strong').text.strip
      Product.new(title, price, rating, availability, delivery)
    end
  end
end