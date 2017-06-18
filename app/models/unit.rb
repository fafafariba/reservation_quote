# == Schema Information
#
# Table name: units
#
#  id          :integer          not null, primary key
#  ad_name     :string
#  tax_percent :decimal(8, 2)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  country     :string           not null
#  state       :string           not null
#  city        :string           not null
#

class Unit < ApplicationRecord
  validates :ad_name, presence: true, uniqueness: true
  validates :tax_percent, :country, :state, :city, :lat, :lng, presence: true
  
  has_many :day_prices, inverse_of: :unit
end
