# Engineering Test

## The challenge

We have a system that delivers advertising materials to broadcasters.

Advertising Material is uniquely identified by a 'Clock' number e.g.

* `WNP/SWCL001/010`
* `ZDW/EOWW005/010`

Our sales team have some new promotions they want to offer so
we need to introduce a mechanism for applying Discounts to orders.

Promotions like this can and will change over time so we need the solution to be flexible.

### Broadcasters

These are the Broadcasters we deliver to

* Viacom
* Disney
* Discovery
* ITV
* Channel 4
* Bike Channel
* Horse and Country


### Delivery Products

* Standard Delivery: $10
* Express Delivery: $20

### Discounts

* Send 2 or more materials via express delivery and the price for express delivery drops to $15
* Spend over $30 to get 10% off

### What we want from you

Provide a means of defining and applying various discounts to the cost of delivering material to broadcasters.

We don't need any UI for this, we just need you to show us how it would work through its API.

## Examples

Based on the both Discounts applied, the following examples should be valid:

* send `WNP/SWCL001/010` to Disney, Discovery, Viacom via Standard Delivery and Horse and Country via Express Delivery
    based on the defined Discounts the total should be $45.00

* send `ZDW/EOWW005/010` to Disney, Discovery, Viacom via Express Delivery
     based on the defined Discounts the total should be $40.50

# My approach

Two implementations to add, total discount and multi buy for express delivery. I decided to do the total discount first.

I did not want to change to much of the code, so just changed the method implementation instead and kept the api methods the same. As the implementation for the discounts were increase the amount of methods in the code, I felt it would be best to extract a discount class and inject it into the order class, this way sticking to the single responsibilty principle.

The class for discounts, allows the user to decide the values for the discounts (ie percentage etc) thus not hard coding these numbers, this is sticking to the open-closed principle.

All the code was test driven. I decided to use feature testing (with capybara), to test all the parts of the objects were integrated and the examples given above were working. I felt this was better than running the script run.rb as a manual check for integration.

Although the order class has no mocks of injected classes, I felt it would be best to do this for the class I created (discount).
