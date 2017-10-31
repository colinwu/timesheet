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

ActiveRecord::Schema.define(version: 20150328190000) do

  create_table "contacts", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.string   "phone",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address",    limit: 255
  end

  create_table "events", force: :cascade do |t|
    t.datetime "end_at"
    t.integer  "project_id",  limit: 4
    t.string   "description", limit: 255
    t.float    "rate",        limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "invoice_id",  limit: 4
    t.datetime "start_at"
  end

  create_table "expenses", force: :cascade do |t|
    t.date     "date"
    t.float    "amount",     limit: 24
    t.string   "desc",       limit: 255
    t.boolean  "money",      limit: 1
    t.integer  "project_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "hst",        limit: 24
  end

  create_table "invoices", force: :cascade do |t|
    t.integer  "project_id",   limit: 4
    t.date     "invoice_date"
    t.date     "paid_date"
    t.string   "memo",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contact_id",  limit: 4
    t.float    "rate",        limit: 24
  end

end
