class Sample::Scraper

  def get_page
    doc = Nokogiri::HTML(open("https://www.mightyape.com.au/sales"))
    doc.css('.sale-grid li').each do |sale|
      prom = Promotion.new do |p|
        p.title = sale.css('.title').text
        p.link = sale.css('a[href]')[1].values[0]
        p.num_of_products = sale.css('.item-count').text
        p.expiry = sale.css('span').text.strip
      end
      Promotion.find_or_create_by(title: prom.title, link: prom.link, num_of_products: prom.num_of_products, expiry: prom.expiry)
    end
  end

end