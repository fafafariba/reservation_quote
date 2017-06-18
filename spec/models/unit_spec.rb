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

require 'rails_helper'

RSpec.describe Unit, type: :model do
  describe "presence validations" do
    it { should validate_presence_of(:country) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:tax_percent) }
    it { should validate_presence_of(:ad_name) }
    it { should validate_presence_of(:lat) }
    it { should validate_presence_of(:lng) }
  end 

  describe "uniquness validations" do
    subject { FactoryGirl.build(:unit) }
    it { should validate_uniqueness_of(:ad_name) }
  end
end
