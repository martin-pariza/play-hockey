class Status < ActiveRecord::Base

  # DB asociations -----------------
  has_many :users
  # DB asociations ----------------- (end)
end
