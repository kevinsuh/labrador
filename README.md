# [Labrador](https://send-labrador.herokuapp.com): Queued greeting card delivery service

**Labrador makes sending a handwritten birthday card as easy as sending a text-message the day of.** We make it easy for you to be thoughtful towards the people you care about. Our mobile-first web app stores your contacts in one place, with their mailing addresses and important occasions.

We remind you of upcoming occasions and allow you to handle all your greeting card purchases at one time, and queue them so that you receive a pre-addressed, pre-stamped greeting card a couple weeks before your recipient's occasion (birthday, holiday, etc.).

Labrador is a Rails application using the popular [Angular](https://angularjs.org/) framework to build a mobile-first SPA.

- [Main Features](#main-features)
- [Gems](#gems)
- [Other](#other)
- [Authors](#authors)

<a name="main-features"/>
# Main Features
### Manage relationships with upcoming occasions
<img src="/app/assets/images/add_friend_example.png" width="250px" alt="Manage relationship">
	
	* Store all your relationships in one place, with mailing addresses and upcoming occasions
	* Receive reminders for upcoming occasions you have not purchased a card for

### Purchase and queue multiple card offerings
<img src="/app/assets/images/my_people_example.png" width="250px" alt="Purchase and Queue Cards">
	
	* Buy all your cards for the year at once, and receive them at the right times
	* We send you a pre-addressed, pre-stamped card so you can handwrite the message and deliver it
	* Uses [Stripe](https://stripe.com/) to store and handle online transactions

### View queued and purchased cards
<img src="/app/assets/images/queued_cards_example.png" width="250px" alt="View Your Queued Cards">
	
	* See which cards you have bought for which people
	* See cards that you are intending to purchase and have in your queue

Labrador was a side-project to explore creating a mobile-first web application using Angular and Rails, and is not currently in business operations.

<a name="gems"/>
# Gems

Labrador uses [bootstrap](https://github.com/twbs/bootstrap), [angular](https://github.com/angular) and [rails-sass](https://github.com/rails/sass-rails). This combination allows for quick development with powerful and modular functionality. It uses the stripe ruby gem to handle payment transactions.

<a name="other"/>
## Other
Labrador uses Heroku for deployment. Since it uses rails, one must remember to maintain precompiled assets each time it is updated. Since so much of the project is Angular and thus javascript, this happens very frequently.

Each time you deploy to production, remember to clean out precompiled assets (`/public/assets`) and run `rake assets:precompile`. We use heroku CLI to maintain our DB (`heroku run rake db:migrate`). We use the standard `Active Record` that comes with Rails to handle our model logic.

This project is not being actively maintained as of 8/15.

<a name="authors"/>
## Authors
[Kevin Suh](https://github.com/kevinsuh) ([@kevinsuh34](https://twitter.com/kevinsuh34)) is the primary developer for Labrador. All design work done by [Ben Xue](https://www.linkedin.com/in/benxue). Additional development from [Chip Koziara](https://github.com/chipkoziara) ([@chipkoziara](https://twitter.com/chipkoziara)). For inquiries, reach out at [kevinsuh34@gmail.com](https://mail.google.com/a/?view=cm&fs=1&to=kevinsuh34@gmail.com). For issues related specifically to Labrador's codebase, please post on our [issues](https://github.com/kevinsuh/labrador/issues) page.


