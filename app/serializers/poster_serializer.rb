class PosterSerializer
  def self.render_poster(poster)
    {
      "data": {
          "id": poster.id,
          "type": "poster",
          "attributes": {
              "name": poster.name,
              "description": poster.description,
              "price": poster.price,
              "year": poster.year,
              "vintage": poster.vintage,
              "img_url":  poster.img_url
          }
      }
    }
  end

  def self.render_all_posters(posters)
    posters.map do |poster|
      render_poster(poster)
    end
  end
end