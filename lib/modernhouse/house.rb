class Modernhouse::House
  attr_accessor :name, :price, :location, :url, :description, :architect

  def self.today
    # Scrape woot and meh and then return deals based on that data
    self.scrape_houses
  end

#  def self.scrape_houses
#    houses = []

#    houses << self.scrape_woot

#    houses
#  end

#  def self.scrape_woot
#    doc = Nokogiri::HTML(open("https://woot.com"))

#    house = self.new
#    house.name = doc.search("h2.main-title").text.strip
#    house.price = doc.search("#todays-deal span.price").text.strip
#    house.url = doc.search("a.wantone").first.attr("href").strip
#    house.availability = true

#    house
#  end

  def self.scrape_houses
    url = "https://www.themodernhouse.com/sales-list/"
    doc = Nokogiri::HTML(open(url))

    houses = []
    doc.css('li.cell a').each do |listing|
      house = self.new
      listing_1 = listing.css('.listing-name')
      parsed = listing_1.text.strip.split("\n")
      house.name = parsed[0]
      house.location = parsed[1..-1].collect(&:strip)

      listing_2 = listing.css('.listing-price')
      house.price = "GBP " + listing_2.text.split("\u00A3")[1].split(/["Free"|"Lease"|"Share"]/)[0]
      house.url = "https://www.themodernhouse.com" + listing.attr("href").strip

      doc_2 = Nokogiri::HTML(open(house.url))
      house.architect = doc_2.css('.property__architect').text.strip
      house.description = doc_2.css('.property__text__paragraphs').text.strip

      houses << house
    end
    houses
  end

    #doc.css('li.cell a .listing-price').each do |price|
    #  price = puts price.text.split("\u00A3")[1].split(/["Free"|"Lease"|"Share"]/)[0]
    #end
end
