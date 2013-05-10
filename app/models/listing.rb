class Listing < ActiveRecord::Base
  attr_accessible :title, :description, :status, :price

  validates :title, presence: true
  validates :description, presence: true
  validates :status, presence: true
  validates :price, presence: true
end
