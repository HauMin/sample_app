# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#

ActiveRecord::Schema.define(version: 20_190_530_095_412) do
  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
  end
end
