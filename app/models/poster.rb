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
    Poster.where("name ILIKE '%#{name}%'").order(name: :asc)
  end

  def self.filter_min_price(min_price)
    Poster.where("price >= #{min_price}")
  end

  def self.filter_max_price(max_price)
    Poster.where("price <= #{max_price}")
  end
end