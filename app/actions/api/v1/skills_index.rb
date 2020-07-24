# frozen_string_literal: true

module Api
  module V1
    class SkillsIndex < ApplicationAction
      attr_reader :skill_name, :product_name

      def execute
        choose_skill.constantize.new(query: product_name).execute
      end

      private

      def choose_skill
        'WebCrawlerService' if search_product?
      end

      def search_product?
        SEARCH_PRODUCT_CONSTANTS.include?(skill_name)
      end
    end
  end
end
