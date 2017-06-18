require 'rails_helper'

RSpec.describe InquiriesController, type: :controller do
	let!(:unit) { create(:unit) }
	let(:ad_name) { unit.ad_name }
	let(:start_date) { Faker::Date.backward(2).to_s }
	let(:end_date) { Faker::Date.forward(2).to_s }
	let(:res) { JSON.parse(response.body) }

	context "with valid attributes" do
		let(:valid_attributes) { { start_date: start_date, end_date: end_date, ad_name: ad_name } }
		before { post :create, params: valid_attributes }
		
		it "creates multiple new day_prices" do
			diff = Date.parse(end_date) - Date.parse(start_date) 
			expect(DayPrice.count).to eq(diff) 
		end

		it "returns status code 201" do 
			# debugger
			expect(response).to have_http_status(201)
		end

		it "returns a price and taxes" do
			expect(res["price"]).to be > 0
			expect(res["taxes"]).to be > 0
		end
	end
	
	context "with invalid attributes" do 
		let(:invalid_ad_name) { { start_date: start_date, end_date: end_date, ad_name: "" } }
		let(:invalid_dates) { { start_date: end_date, end_date: start_date, ad_name: ad_name } }

		context "when the ad_name is invalid" do
			before { post :create, params: invalid_ad_name }

			it "does not create any day_prices" do
				expect(DayPrice.count).to eq(0) 
			end

			it "returns an error" do
				expect(response.status).to be >= 400
				expect(res["errors"]).not_to be_nil
			end
		end

		context "when the dates are invalid" do
			before { post :create, params: invalid_dates }

			it "does not create any day_prices" do
				expect(DayPrice.count).to eq(0) 
			end

			it "returns an error" do
				expect(response.status).to be >= 400
				expect(res["errors"]).not_to be_nil
			end
		end
	end
end
