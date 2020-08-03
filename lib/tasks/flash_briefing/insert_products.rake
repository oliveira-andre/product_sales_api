# frozen_string_literal: true

Dir["#{Rails.application.paths.path}/app/models/*.rb"].sort.each do |file|
  require file
end
require_relative "#{Rails.application.paths.path}/app/services"\
                 "/web_crawler_service"

desc 'consulting wish list and inserting the products'

namespace :flash_briefing do
  task :insert_products do
    ActiveRecord::Base.establish_connection('development')
    product_names = %w[ssd televisão]

    product_names.each do |name|
      puts WebCrawlerService.new(query: name, deep: 1).execute
    end
  end
end
