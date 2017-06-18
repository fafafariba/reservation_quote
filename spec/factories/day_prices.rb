FactoryGirl.define do
	factory :day_price do 
		unit_id { rand(11) }
		price { ([100, 200].sample + 20*rand()).round(2) }
		date { Faker::Date.forward(30) }
		tax_percent { Float(rand(11) + 7) }
	end
end