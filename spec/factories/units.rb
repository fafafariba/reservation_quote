FactoryGirl.define do
	factory :unit do 
		country { Faker::Address.country }
		state { Faker::Address.state }
		city { Faker::Address.city }
		ad_name { Faker::Book.title }
		tax_percent { Float(rand(11) + 7) }
		lat { Faker::Address.latitude }
		lng { Faker::Address.longitude }
	end
end
