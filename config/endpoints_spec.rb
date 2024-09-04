require 'rails_helper'

RSpec.describe "Poster Endpoints" do 
  before (:each) do 
    Poster.create!(name: "REGRET",
               description: "Hard work rarely pays off.",
               price: 89.00,
               year: 2018,
               vintage: true,
               img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d")

    Poster.create!(name: "DOOM",
               description: "We were poor, my mother and I, living in a world of doom and gloom, pessimism and bitterness, where storms raged and wolves scratched at the door.",
               price: 99.00,
               year: 2001,
               vintage: false,
               img_url:  "https://as1.ftcdn.net/v2/jpg/05/65/34/38/1000_F_565343831_FOY5uGGDcELPRcKpRf4huyrL5DVT4gz8.jpg")

    Poster.create!(name: "EXISTENTIALISM",
               description: "You have your way. I have my way. As for the right way, the correct way, and the only way, it does not exist.",
               price: 69.00,
               year: 2020,
               vintage: true,
               img_url:  "https://wamu.org/wp-content/uploads/2016/03/29/ap_090911089838_wide-58102eebb732a70864dc08c1ff9321af5051b9f4-1500x844.jpg")

    Poster.create!(name: "LONLINESS",
               description: "To live alone is the fate of all great souls.",
               price: 33.00,
               year: 1991,
               vintage: true,
               img_url:  "https://i.kym-cdn.com/entries/icons/mobile/000/026/213/pablo.jpg")

  end

  describe 'Verbs' do 

    it 'can retrive all posters' do 

      get "/api/v1/posters"
      
      expect(response).to be_successful

      posters = JSON.parse(response.body, symbolize_names: true)
      expect(posters.count).to eq(4)
      
      posters.each do |poster| 
        expect(poster).to have_key(:id)
        expect(poster[:id]).to be_an(Integer)

        expect(poster).to have_key(:name)
        expect(poster[:name]).to be_an(String)

        expect(poster).to have_key(:description)
        expect(poster[:description]).to be_a(String)

        expect(poster).to have_key(:price)
        expect(poster[:price]).to be_a(Float)

        expect(poster).to have_key(:year)
        expect(poster[:year]).to be_an(Integer)

        expect(poster).to have_key(:vintage)
        expect(poster[:vintage]).to be_in([true, false])

        expect(poster).to have_key(:img_url)
        expect(poster[:img_url]).to be_a(String)
      end
    end

  end

end