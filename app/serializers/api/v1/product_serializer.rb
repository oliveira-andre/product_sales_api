# frozen_string_literal: true

module Api
  module V1
    class ProductSerializer
      def initialize(products)
        @products = products
      end

      def serialize
        { products: products.compact }
      end

      def products
        return if @products.empty?

        @products.map do |product|
          {
            id: product.id,
            name: product.name,
            price: product.price,
            site: product.site
          }.merge(timestamp(product)).compact
        end
      end

      def timestamp(product)
        return {} unless product&.created_at && product&.updated_at

        {
          created_at: product.created_at,
          updated_at: product.updated_at
        }.compact
      end
    end
  end
end
