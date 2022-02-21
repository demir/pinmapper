module MapServices
  module GenerateMarkers
    class Pin < ApplicationService
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
        raw_pins.select(:id, :latitude, :longitude, :name)
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
        "
          <h3>#{pin.name}<h3>
        "
      end
    end
  end
end
