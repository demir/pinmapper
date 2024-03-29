module MapServices
  module GenerateMarkers
    class Pin < ApplicationService
      include ActionView::Helpers::TextHelper
      include ActionView::Helpers::UrlHelper
      include ActionView::Context
      attr_reader :pins, :pin

      def initialize(raw_pins)
        @pin = raw_pins if raw_pins&.class&.name.eql?('Pin')
        @pins = select_pins(raw_pins)
      end

      def call
        markers = generate_markers
      rescue StandardError => e
        { success: false, error: e }
      else
        { success: markers.present?, payload: markers }
      end

      private

      def select_pins(raw_pins)
        return unless raw_pins&.is_a?(ActiveRecord::Relation)

        raw_pins.select(:id, :latitude, :longitude, :name, :cover_photo_description)
      end

      def generate_markers
        return [pin_to_hash(pin)] if pin.present?
        return Array(nil) if pins.blank?

        pins.each_with_object([]) do |pin_item, markers|
          markers << pin_to_hash(pin_item)
        end
      end

      def pin_to_hash(pin_item)
        {
          id:        pin_item.id,
          latitude:  pin_item.latitude,
          longitude: pin_item.longitude,
          popup:     popup(pin_item)
        }
      end

      def popup(pin)
        html = ''
        html << (content_tag :h3, class: 'title' do
          link_to truncate(pin.name, length: 75),
                  Rails.application.routes.url_helpers.pin_path(id: pin.id),
                  class: 'black-link',
                  title: pin.name
        end)
        html << (content_tag :p, title: pin.cover_photo_description, class: 'cover-photo-description' do
          truncate pin.cover_photo_description, length: 300
        end)
        direction_url = "https://www.google.com/maps/dir//#{pin.latitude},#{pin.longitude}"
        html << (
          link_to I18n.t('get_directions'),
                  direction_url,
                  class:  'btn_infobox_get_directions',
                  target: :_blank,
                  rel:    :noopener
        )
      end
    end
  end
end
