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

require 'rails_helper'

RSpec.describe DayPrice, type: :model do
  describe "presence validations" do
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:unit_id) }
    it { should validate_presence_of(:tax_percent) }
  end 
end
