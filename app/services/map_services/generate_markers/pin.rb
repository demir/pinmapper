module MapServices
  module GenerateMarkers
    class Pin < ApplicationService
      include ActionView::Helpers::TextHelper
      include ActionView::Helpers::UrlHelper
      include ActionView::Context
      attr_reader :pins

      def initialize(raw_pins)
        @pins = select_pins(raw_pins)
      end

      def call
        markers = generate_markers
      rescue StandardError => e
        { success: false, error: e }
      else
        { success: true, payload: markers }
      end

      private

      def select_pins(raw_pins)
        raw_pins.select(:id, :latitude, :longitude, :name, :cover_image_description)
      end

      def generate_markers
        pins.each_with_object([]) do |pin, markers|
          markers << {
            id:        pin.id,
            latitude:  pin.latitude,
            longitude: pin.longitude,
            popup:     popup(pin)
          }
        end
      end

      def popup(pin)
        html = ''
        html << (content_tag :h3, class: 'title' do
          link_to truncate(pin.name, length: 75),
                  Rails.application.routes.url_helpers.pin_path(id: pin.id),
                  class: 'black-link',
                  title: pin.name
        end)
        html << (content_tag :p, title: pin.cover_image_description do
          truncate pin.cover_image_description, length: 300
        end)
        html << (
          content_tag :form, action: 'http://maps.google.com/maps', method: :get, target: :_blank,
class: 'direction-form' do
            tag.input(name: :daddr, value: "#{pin.latitude},#{pin.longitude}", type: :hidden) +
            (content_tag :button, type: :submit, value: I18n.t('get_directions'),
                                  class: 'btn_infobox_get_directions' do
               I18n.t('get_directions')
             end)
          end
        )
      end
    end
  end
end
