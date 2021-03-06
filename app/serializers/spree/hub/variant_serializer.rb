require 'active_model/serializer'

module Spree
  module Hub
    class VariantSerializer < ActiveModel::Serializer
      attributes :sku, :price, :cost_price, :options, :product_id
      attributes :product, :name

      # has_many :images, serializer: Spree::Hub::ImageSerializer


      def parent_id
        object.is_master? ? nil : object.product.master.id
      end

      def price
        object.price.to_f
      end

      def cost_price
        object.cost_price.to_f
      end

      def available_on
        object.available_on.iso8601
      end

      def permalink
        object.product.permalink
      end

      def shipping_category
        object.shipping_category.name
      end

      def taxons
        object.product.taxons.collect {|t| t.root.self_and_descendants.collect(&:name)}
      end

      def options
        object.option_values.each_with_object({}) {|ov,h| h[ov.option_type.presentation]= ov.presentation}
      end

      def name
        object.product.name
      end

      def product
        hash = {}
        hash[:created_at] = object.product.created_at.getutc.iso8601
        hash[:updated_at] = object.product.updated_at.getutc.iso8601

        hash[:taxons] = object.product.taxons.map{|t| t.slice(:id, :name, :taxonomy_id)}
        hash
      end

    end
  end
end
