class DateParams
	def initialize(start_date, end_date)
		@start_date = Date.parse(start_date)
		@end_date = Date.parse(end_date)
	end

	def extract_dates
		raise "Invalid dates" if @start_date > @end_date

		results = []
		curr_date = @start_date
			until curr_date == @end_date
				results << curr_date
				curr_date += 1
			end
		results
	end
end