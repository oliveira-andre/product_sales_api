class WebCrawlerService
  require 'open-uri'

  def initialize(query)
    @config = Rails.application.config_for(:crawler)
    @sites = @config[:sites]
    @query = query
    @products = []
  end

  def execute
    @sites.each do |site|
      @current_site = site.to_sym

      cards.each do |card|
        @card = card
        @products << product_object unless name.blank?
      end
    end
  end

  private

  def uri
    @config.dig(@current_site, :uri) + @query
  end

  def page
    Nokogiri::HTML(URI.open(uri))
  end

  def cards
    page.search(@config.dig(@current_site, :cards))
  end

  def name 
    @card.search(@config.dig(@current_site, :name)).text
  end

  def price
    @card.search(@config.dig(@current_site, :price)).text
  end

  def product_object
    { name: name, price: price, site: @current_site }.compact
  end
end

