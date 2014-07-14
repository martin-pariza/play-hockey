class Category < ActiveRecord::Base
  has_many :matches
end
