 require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/pins", type: :request do
  
  # Pin. As you add validations to Pin, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      Pin.create! valid_attributes
      get pins_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      pin = Pin.create! valid_attributes
      get pin_url(pin)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_pin_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      pin = Pin.create! valid_attributes
      get edit_pin_url(pin)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Pin" do
        expect {
          post pins_url, params: { pin: valid_attributes }
        }.to change(Pin, :count).by(1)
      end

      it "redirects to the created pin" do
        post pins_url, params: { pin: valid_attributes }
        expect(response).to redirect_to(pin_url(Pin.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Pin" do
        expect {
          post pins_url, params: { pin: invalid_attributes }
        }.to change(Pin, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post pins_url, params: { pin: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested pin" do
        pin = Pin.create! valid_attributes
        patch pin_url(pin), params: { pin: new_attributes }
        pin.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the pin" do
        pin = Pin.create! valid_attributes
        patch pin_url(pin), params: { pin: new_attributes }
        pin.reload
        expect(response).to redirect_to(pin_url(pin))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        pin = Pin.create! valid_attributes
        patch pin_url(pin), params: { pin: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested pin" do
      pin = Pin.create! valid_attributes
      expect {
        delete pin_url(pin)
      }.to change(Pin, :count).by(-1)
    end

    it "redirects to the pins list" do
      pin = Pin.create! valid_attributes
      delete pin_url(pin)
      expect(response).to redirect_to(pins_url)
    end
  end
end