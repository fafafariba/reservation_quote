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

### Database

There are two tables: 
`units`
- `ad_name`
- `tax_percent`

`day_prices`
- `unit_id`
- `date`
- `price`

### Models

