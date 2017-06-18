# == Schema Information
#
# Table name: day_prices
#
#  id         :integer          not null, primary key
#  date       :date
#  price      :decimal(8, 2)
#  unit_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DayPrice < ApplicationRecord
  validates :date, :price, :unit_id, :tax_percent, presence: true
  belongs_to :unit, inverse_of: :day_prices
end
