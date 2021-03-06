# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151230190405) do

  create_table "addresses", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "street"
    t.string   "suite"
    t.string   "city"
    t.string   "state"
    t.integer  "zipcode"
    t.boolean  "is_primary",  default: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "person_id"
    t.string   "person_type"
    t.boolean  "is_visible",  default: true
    t.string   "country",     default: "United States"
  end

  add_index "addresses", ["person_type", "person_id"], name: "index_addresses_on_person_type_and_person_id"

  create_table "card_flavors", force: :cascade do |t|
    t.integer  "card_id"
    t.integer  "flavor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "card_flavors", ["card_id", "flavor_id"], name: "index_card_flavors_on_card_id_and_flavor_id", unique: true
  add_index "card_flavors", ["card_id"], name: "index_card_flavors_on_card_id"
  add_index "card_flavors", ["flavor_id"], name: "index_card_flavors_on_flavor_id"

  create_table "card_images", force: :cascade do |t|
    t.integer  "card_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "picture"
    t.integer  "side"
  end

  add_index "card_images", ["card_id"], name: "index_card_images_on_card_id"

  create_table "card_occasions", force: :cascade do |t|
    t.integer  "card_id"
    t.integer  "occasion_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "card_occasions", ["card_id", "occasion_id"], name: "index_card_occasions_on_card_id_and_occasion_id", unique: true
  add_index "card_occasions", ["card_id"], name: "index_card_occasions_on_card_id"
  add_index "card_occasions", ["occasion_id"], name: "index_card_occasions_on_occasion_id"

  create_table "card_relationships", force: :cascade do |t|
    t.integer  "card_id"
    t.integer  "relationship_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "card_relationships", ["card_id", "relationship_id"], name: "index_card_relationships_on_card_id_and_relationship_id", unique: true
  add_index "card_relationships", ["card_id"], name: "index_card_relationships_on_card_id"
  add_index "card_relationships", ["relationship_id"], name: "index_card_relationships_on_relationship_id"

  create_table "card_survey_rankings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "occasion_id"
    t.integer  "relationship_id"
    t.integer  "flavor_id"
    t.integer  "first_card_id"
    t.integer  "second_card_id"
    t.integer  "third_card_id"
    t.integer  "fourth_card_id"
    t.integer  "fifth_card_id"
    t.integer  "sixth_card_id"
    t.integer  "seventh_card_id"
    t.integer  "eighth_card_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "card_survey_rankings", ["flavor_id"], name: "index_card_survey_rankings_on_flavor_id"
  add_index "card_survey_rankings", ["occasion_id"], name: "index_card_survey_rankings_on_occasion_id"
  add_index "card_survey_rankings", ["relationship_id"], name: "index_card_survey_rankings_on_relationship_id"
  add_index "card_survey_rankings", ["user_id"], name: "index_card_survey_rankings_on_user_id"

  create_table "card_vendors", force: :cascade do |t|
    t.integer  "card_id"
    t.integer  "vendor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "url"
  end

  add_index "card_vendors", ["card_id"], name: "index_card_vendors_on_card_id"
  add_index "card_vendors", ["vendor_id"], name: "index_card_vendors_on_vendor_id"

  create_table "cards", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  create_table "comment_upvotes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "comment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comment_upvotes", ["comment_id"], name: "index_comment_upvotes_on_comment_id"
  add_index "comment_upvotes", ["user_id"], name: "index_comment_upvotes_on_user_id"

  create_table "comments", force: :cascade do |t|
    t.text     "body"
    t.integer  "upvotes",    default: 0
    t.integer  "post_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "user_id"
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "flavors", force: :cascade do |t|
    t.string "name"
  end

  create_table "occasions", force: :cascade do |t|
    t.string "name"
  end

  create_table "order_occasions", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "occasion_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "order_occasions", ["occasion_id"], name: "index_order_occasions_on_occasion_id"
  add_index "order_occasions", ["order_id"], name: "index_order_occasions_on_order_id"

  create_table "order_purchase_groups", force: :cascade do |t|
    t.integer  "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "order_purchase_groups", ["order_id"], name: "index_order_purchase_groups_on_order_id"

  create_table "order_statuses", force: :cascade do |t|
    t.integer  "order_id"
    t.boolean  "purchased",  default: false
    t.boolean  "delivered",  default: false
    t.boolean  "canceled",   default: false
    t.boolean  "refunded",   default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "order_statuses", ["order_id"], name: "index_order_statuses_on_order_id"

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "recipient_id"
    t.integer  "card_id"
    t.datetime "recipient_arrival_date"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "pre_address",            default: false
    t.integer  "shipping_address_id"
  end

  add_index "orders", ["card_id"], name: "index_orders_on_card_id"
  add_index "orders", ["recipient_id"], name: "index_orders_on_recipient_id"
  add_index "orders", ["user_id"], name: "index_orders_on_user_id"

  create_table "post_upvotes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "post_upvotes", ["post_id"], name: "index_post_upvotes_on_post_id"
  add_index "post_upvotes", ["user_id"], name: "index_post_upvotes_on_user_id"

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.string   "link"
    t.integer  "upvotes",    default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "user_id"
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

  create_table "profile_pictures", force: :cascade do |t|
    t.integer  "person_id"
    t.string   "person_type"
    t.string   "picture"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profile_pictures", ["person_type", "person_id"], name: "index_profile_pictures_on_person_type_and_person_id"

  create_table "recipient_occasions", force: :cascade do |t|
    t.integer  "recipient_id"
    t.integer  "occasion_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "month"
    t.integer  "day"
    t.text     "notes"
    t.integer  "status",       default: 0
    t.string   "name"
  end

  add_index "recipient_occasions", ["occasion_id"], name: "index_recipient_occasions_on_occasion_id"
  add_index "recipient_occasions", ["recipient_id"], name: "index_recipient_occasions_on_recipient_id"

  create_table "recipients", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "relationship_id"
    t.integer  "status",          default: 0
  end

  add_index "recipients", ["user_id"], name: "index_recipients_on_user_id"

  create_table "relationships", force: :cascade do |t|
    t.string "name"
  end

  create_table "user_stripe_accounts", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "customer_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "user_stripe_accounts", ["user_id"], name: "index_user_stripe_accounts_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "is_admin",               default: false
    t.boolean  "is_activated",           default: false
    t.string   "activation_digest"
    t.datetime "activated_at"
    t.string   "password_reset_digest"
    t.datetime "password_reset_sent_at"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "birth_month"
    t.integer  "birth_day"
    t.integer  "birth_year"
    t.string   "phone_number"
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "vendors", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "waitlists", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
