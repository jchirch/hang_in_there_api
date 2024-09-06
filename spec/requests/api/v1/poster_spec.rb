require 'rails_helper'

RSpec.describe 'Model classes' do
  before (:each) do 
    @regret_poster = Poster.create!(name: "REGRET",
               description: "Hard work rarely pays off.",
               price: 89.00,
               year: 2018,
               vintage: true,
               img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d")

    @doom_poster = Poster.create!(name: "DOOM",
               description: "We were poor, my mother and I, living in a world of doom and gloom, pessimism and bitterness, where storms raged and wolves scratched at the door.",
               price: 99.00,
               year: 2001,
               vintage: false,
               img_url:  "https://as1.ftcdn.net/v2/jpg/05/65/34/38/1000_F_565343831_FOY5uGGDcELPRcKpRf4huyrL5DVT4gz8.jpg")

    @existentialism_poster = Poster.create!(name: "EXISTENTIALISM",
               description: "You have your way. I have my way. As for the right way, the correct way, and the only way, it does not exist.",
               price: 69.00,
               year: 2020,
               vintage: true,
               img_url:  "https://wamu.org/wp-content/uploads/2016/03/29/ap_090911089838_wide-58102eebb732a70864dc08c1ff9321af5051b9f4-1500x844.jpg")

    @lonely_poster = Poster.create!(name: "LONLINESS",
               description: "To live alone is the fate of all great souls.",
               price: 33.00,
               year: 1991,
               vintage: true,
               img_url:  "https://i.kym-cdn.com/entries/icons/mobile/000/026/213/pablo.jpg")
  end

  describe 'Sort_results' do
    
    it 'can sort by created_at asc' do 
      expected = {
        data: [
            {
                id: @regret_poster.id.to_s, # Use the actual id from the created record
                type: "poster",
                attributes: {
                    name: @regret_poster.name,
                    description: @regret_poster.description,
                    price: @regret_poster.price,
                    year: @regret_poster.year,
                    vintage: @regret_poster.vintage,
                    img_url: @regret_poster.img_url
                }
            },
            {
                id: @doom_poster.id.to_s, # Same here
                type: "poster",
                attributes: {
                    name: @doom_poster.name,
                    description: @doom_poster.description,
                    price: @doom_poster.price,
                    year: @doom_poster.year,
                    vintage: @doom_poster.vintage,
                    img_url: @doom_poster.img_url
                }
            },
            {
                id: @existentialism_poster.id.to_s,
                type: "poster",
                attributes: {
                    name: @existentialism_poster.name,
                    description: @existentialism_poster.description,
                    price: @existentialism_poster.price,
                    year: @existentialism_poster.year,
                    vintage: @existentialism_poster.vintage,
                    img_url: @existentialism_poster.img_url
                }
            },
            {
                id: @lonely_poster.id.to_s,
                type: "poster",
                attributes: {
                    name: @lonely_poster.name,
                    description: @lonely_poster.description,
                    price: @lonely_poster.price,
                    year: @lonely_poster.year,
                    vintage: @lonely_poster.vintage,
                    img_url: @lonely_poster.img_url
                }
            }
        ],
        meta: {"count": 4}
      }
      
      get "/api/v1/posters?sort=asc"
      expect(response).to be_successful
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to eq(expected)
    end
  end

  describe 'meta count' do
    it 'meta value equal to record' do

      get "/api/v1/posters"
      expect(response).to be_successful
      result = JSON.parse(response.body, symbolize_names: true)

      expect(Poster.count).to eq(result[:meta][:count])
    end
  end

  describe 'filter results' do 
    it 'can filter by name' do 

      expected = {
        data: [
            {
                id: @existentialism_poster.id.to_s,
                type: "poster",
                attributes: {
                    name: @existentialism_poster.name,
                    description: @existentialism_poster.description,
                    price: @existentialism_poster.price,
                    year: @existentialism_poster.year,
                    vintage: @existentialism_poster.vintage,
                    img_url: @existentialism_poster.img_url
                }
            },
            {
                id: @lonely_poster.id.to_s,
                type: "poster",
                attributes: {
                    name: @lonely_poster.name,
                    description: @lonely_poster.description,
                    price: @lonely_poster.price,
                    year: @lonely_poster.year,
                    vintage: @lonely_poster.vintage,
                    img_url: @lonely_poster.img_url
                }
            }
        ],
        meta: {"count": 2}
      }

      get "/api/v1/posters?name=li"

      expect(response).to be_successful
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result).to eq(expected)
    end

    it 'can filter by min_price' do
      expected = {
        data: [
            {
                id: @regret_poster.id.to_s, # Use the actual id from the created record
                type: "poster",
                attributes: {
                    name: @regret_poster.name,
                    description: @regret_poster.description,
                    price: @regret_poster.price,
                    year: @regret_poster.year,
                    vintage: @regret_poster.vintage,
                    img_url: @regret_poster.img_url
                }
            },
            {
                id: @doom_poster.id.to_s, # Same here
                type: "poster",
                attributes: {
                    name: @doom_poster.name,
                    description: @doom_poster.description,
                    price: @doom_poster.price,
                    year: @doom_poster.year,
                    vintage: @doom_poster.vintage,
                    img_url: @doom_poster.img_url
                }
            }
        ],
        meta: {"count": 2}
      }
      get '/api/v1/posters?min_price=80'
      expect(response).to be_successful
  
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result).to eq(expected)
    end
    it 'can filter by max_price' do
      expected = {
        data: [
            {
                id: @existentialism_poster.id.to_s,
                type: "poster",
                attributes: {
                    name: @existentialism_poster.name,
                    description: @existentialism_poster.description,
                    price: @existentialism_poster.price,
                    year: @existentialism_poster.year,
                    vintage: @existentialism_poster.vintage,
                    img_url: @existentialism_poster.img_url
                }
            },
            {
                id: @lonely_poster.id.to_s,
                type: "poster",
                attributes: {
                    name: @lonely_poster.name,
                    description: @lonely_poster.description,
                    price: @lonely_poster.price,
                    year: @lonely_poster.year,
                    vintage: @lonely_poster.vintage,
                    img_url: @lonely_poster.img_url
                }
            }
        ],
        meta: {"count": 2}
      }
      get '/api/v1/posters?max_price=80'
      expect(response).to be_successful
  
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result).to eq(expected)
    end
  end
end