class Prices
	# Service object that uses external service to find prices per night based on location

	def initialize(dates, unit)
		@dates = dates
		@unit = unit 
	end

	def get_prices
		result = []
		lat = @unit.lat
		lng = @unit.lng
		@dates.each do |date|
			# Call to fetch price
			price = ([100, 200].sample + 20*rand()).round(2)
			result << { date: date, price: price  }
		end
		result
	end 
end