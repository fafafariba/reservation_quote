class InquiriesController < ApplicationController
	before_action :set_unit

	def create
		@priced_inquiries = inquiries.get_prices
	rescue => e
  	render json: { errors: e }, status: 422
	else
		day_price_objs = []
		
		@priced_inquiries.each do |inq|
			day_price_objs << DayPrice.new(date: inq[:date], price: inq[:price], unit_id: @unit.id, tax_percent: @unit.tax_percent)
		end

		begin
			DayPrice.transaction do
				day_price_objs.each { |obj| obj.save! }
			end

			sum = sum_taxes.sum
			taxes = sum_taxes.taxes(sum, @unit.tax_percent)

			render json: {price: sum, taxes: taxes}, status: 201
		rescue ActiveRecord::RecordInvalid => exception
			render json: new_params.map(&:errors), status: 422
		end
	end

	private

	def inquiries_params
		params.permit(:start_date, :end_date, :ad_name)
	end

	def set_unit
		@unit = Unit.find_by_ad_name!(inquiries_params[:ad_name])
	rescue ActiveRecord::RecordNotFound => e
  	render json: { errors: e }, status: 404
	end

	def all_dates
		DateParams.new(inquiries_params[:start_date], inquiries_params[:end_date])
	end

	def inquiries
		dates = all_dates.extract_dates
		Prices.new(dates, @unit)
	end

	def sum_taxes
		SumTaxes.new(@priced_inquiries)
	end
end
