class Poster < ApplicationRecord
  def self.sort_results(sort)
    if sort === 'asc'
      Poster.order(created_at: :asc)
    elsif
      sort === 'desc'
      Poster.order(created_at: :desc)
    else 
      Poster.all
    end
  end

  def self.filter_name(name)
    Poster.where("name ILIKE '%name%").order()
  end
end

