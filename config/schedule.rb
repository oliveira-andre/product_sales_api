# frozen_string_literal: true

set :output, "#{Rails.application.paths.path}/cron_log.log"

every 1.day, at: '4:00 am' do
  rake 'flash_briefing:insert_products'
end

