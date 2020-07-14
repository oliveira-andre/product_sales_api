# frozen_string_literal: true

# this class open sites and return product_object
class WebCrawlerService
  require 'open-uri'

  def initialize(query, deep = 0)
    @config = Rails.application.config_for(:crawler)
    @sites = @config[:sites]
    @query = query
    @deep = deep
    @products = []
  end

  def execute
    @sites.each do |site|
      (0..@deep).each do |number|
        @current_deep = number
        @current_site = site.to_sym
        set_card_and_product
        @next_page_uri = next_page_uri if valid_next_page?
      end
    end

    @products
  end

  private

  def uri
    @config.dig(@current_site, :uri) + @query
  end

  def page
    Nokogiri::HTML(URI.open(@current_deep.zero? ? uri : @next_page_uri))
  end

  def set_card_and_product
    cards.each do |card|
      @card = card
      @products << product_object unless name.blank?
    end
  end

  def cards
    page.search(@config.dig(@current_site, :cards))
  end

  def product_object
    { name: name, price: price, site: @current_site }.compact
  end

  def name
    @card.search(@config.dig(@current_site, :name)).text
  end

  def price
    @card.search(@config.dig(@current_site, :price)).text
  end

  def next_page_uri
    page.search(@config.dig(@current_site, :next_page))&.first&.attributes&.first&.last&.value
  end

  def valid_next_page?
    @current_deep != @deep && next_page_uri&.present?
  end
end
