module Pins
  module Latest
    def self.call(user:, pagy:)
      return Pin.order(created_at: :desc).offset(pagy.offset).limit(pagy.items) if user.blank?

      Pin.where(id: own_and_following_pins(user, pagy).ids | tag_pins(user, pagy).ids | board_pins(user, pagy).ids)
         .order(created_at: :desc)
    end

    def self.tag_pins(user, pagy)
      Pin.tagged_with(user.tags, any: true)
         .order(created_at: :desc)
         .offset(pagy.offset).limit(pagy.items)
    end

    def self.board_pins(user, pagy)
      Pin.joins(boards: :followers)
         .where(followers: { id: user })
         .order(created_at: :desc)
         .group(:id)
         .offset(pagy.offset).limit(pagy.items)
    end

    def self.own_and_following_pins(user, pagy)
      Pin.joins(:user)
         .where(users: { id: user.following | Array(user) })
         .order(created_at: :desc)
         .offset(pagy.offset).limit(pagy.items)
    end

    def self.nearby_pins(pin, pagy)
      return Pin.none if pin.geocode.blank?

      Pin.where(latitude: pin.latitude, longitude: pin.longitude)
         .order(created_at: :desc)
         .offset(pagy.offset).limit(pagy.items)
    end
  end
end
