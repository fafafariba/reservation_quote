class SumTaxes
	# Service object calculating sum of requested reserveration (without taxes) and tax

	def initialize(priced_inquiries)
		@priced_inquiries = priced_inquiries
	end

	def sum
		total = 0
		@priced_inquiries.each do |inq|
			total += Float(inq[:price])
		end
		total
	end

	def taxes(total, tax_percent)
		(Float(total * tax_percent) / 100).round(2)
	end
end
		