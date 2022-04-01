# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sitemaps', type: :request do
  describe 'GET /sitemap-*' do
    it 'renders xml file' do
      get '/sitemap-index.xml'
      expect(response.media_type).to eq('application/xml')
    end

    context 'with index in param' do
      it 'renders basic index', :aggregate_failures do
        get '/sitemap-index.xml'
        expect(response.body).to include('<sitemapindex xmlns=')
        expect(response.body).to include('sitemap-pins.xml')
        expect(response.body).to include('sitemap-boards.xml')
        expect(response.body).to include('sitemap-users.xml')
        expect(response.body).to include('sitemap-tags.xml')
      end
    end

    it 'renders sitemap-pins.xml file' do
      get '/sitemap-pins.xml'
      expect(response.media_type).to eq('application/xml')
    end

    it 'renders sitemap-boards.xml file' do
      get '/sitemap-boards.xml'
      expect(response.media_type).to eq('application/xml')
    end

    it 'renders sitemap-users.xml file' do
      get '/sitemap-users.xml'
      expect(response.media_type).to eq('application/xml')
    end

    it 'renders sitemap-tags.xml file' do
      get '/sitemap-tags.xml'
      expect(response.media_type).to eq('application/xml')
    end
  end
end
