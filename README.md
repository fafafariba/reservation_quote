# Company X Reservation Quote Project

Company X is just getting off the ground and needs to know how much to price units and to keep track of the requests that have been made.

## Objective

To build the application by which Company X internal team can log the reservation request information and quote the total price and taxes to the customer.

## Requirements

- The reservation requests should be called inquiries.
- An inquiry should have a rental site.
- The inquiry should have a unit.
- The user should be able to select the unit by the ad name.
- The inquiry should have a price, which is the sum of all _nights_ that the guest stayed in the room. So a stay from May 1st to May 3rd would have two nights.
- The inquiry should store the amount of taxes that were withheld, when the inquiry was made.

## Initial Setup

The project was skeleton was an Rails application with a Postgres database and models already set up.

## MyApproach

### Gems

For testing purposes, I added Faker, Factory Girl, Database Cleaner, Shoulda-Matchers, and Annotate gems.

### Database Schema

As the inquiry should have a location, I added `lat` and `lng` coordinate columns to the `units` to have quick access to geolocation. This may come handy when providing a precise location to an external service to obtain market rates for daily rental prices. In addition, I included `country`, `state`, and `city`, with indexing, for increased searchability when gathering data by region. An index and uniquness constraint was also added to `ad_name` for searchability and to ensure no two units have the same `ad_name`.

The `day_prices` table has a 'belongs to' relation to `unit`, so presumably the unit `ad_name`, location, and taxes can easily be determined using that association. However, as tax percentages are subject to change over time, I added a `tax_percent` column to capture the tax rate at the time of inquiry.

`units`
- `ad_name`
- `tax_percent`
+ `country`
+ `state`
+ `city`
+ `lat`
+ `lng`

`day_prices`
- `unit_id`
- `date`
- `price`
+ `tax_percent`

### Models

Presence and uniqueness validations were added to both models to ensure data integrity.

```
class Unit < ApplicationRecord
  validates :ad_name, presence: true, uniqueness: true
  validates :tax_percent, :country, :state, :city, :lat, :lng, presence: true
  ...
end
```

```
class DayPrice < ApplicationRecord
  validates :date, :price, :unit_id, :tax_percent, presence: true
  ...
end
```

### Controllers

The `Inquiries` controller takes a `start_date`, `end_date`, and `unit_id` as parameters. The difference of the dates determines the number of `DayPrice` objects that will be created and saved in the database. Using ActiveRecord's `transaction` method ensures that either all of the objects are saved simultaneously or none are if at least one object has an error. This prevents redundant entries if a post request isn't successful the first time and the user tries again.

### Service Objects

I created service objects to keep the controller as 'skinny' as possible. The `DatesParam` class takes the `start_date` and `end_date` of the reservation request and returns an array of dates, for which prices needed to be found. The `Price`class then determines a `price` value for each of those dates, based on the location of the unit. Lastly, the `SumTaxes` class calculates the information that needs to be returned to the user after the inquiry has been recorded, i.e. the sum of the hotel over all the dates and the total taxes.

### Tests

Using RSpec, I added tests for 'Unit' model, 'DayPrice' model, and 'Inquiries' controller.

### Sample Inquiry

AJAX request from frontend:

  ```
  $.ajax({
    method: 'POST',
    data: { start_date: '2017-06-19', end_date: '2017-06-21', ad_name: 'SOMA Loft' },
    url: '/inquiries'
  })
  ```

Response in JSON format:

```
 { price: 223.53, taxes: 33.53 }
```
### Data Analysis

With the current setup, you can use SQL to pull data with specific paramters like location and price. For example

```
SELECT day_prices.price, (day_prices.price * day_prices.tax_percent) AS tax
FROM day_prices
JOIN units ON units.id = day_prices.unit_id
WHERE unit.city = 'San Francisco' AND unit.id = 4 AND day_prices.date BETWEEN '2017-04-01' AND '2017-04-30';
```







