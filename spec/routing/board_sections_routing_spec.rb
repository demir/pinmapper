require "rails_helper"

RSpec.describe BoardSectionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/board_sections").to route_to("board_sections#index")
    end

    it "routes to #new" do
      expect(get: "/board_sections/new").to route_to("board_sections#new")
    end

    it "routes to #show" do
      expect(get: "/board_sections/1").to route_to("board_sections#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/board_sections/1/edit").to route_to("board_sections#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/board_sections").to route_to("board_sections#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/board_sections/1").to route_to("board_sections#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/board_sections/1").to route_to("board_sections#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/board_sections/1").to route_to("board_sections#destroy", id: "1")
    end
  end
end
