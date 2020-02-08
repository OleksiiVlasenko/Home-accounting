# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_08_095400) do

  create_table "credit", force: :cascade do |t|
    t.text "user"
    t.integer "amount"
    t.text "category_debit"
    t.integer "total_amount"
    t.integer "month_amount"
    t.integer "year_amount"
    t.text "comment"
  end

  create_table "debet", force: :cascade do |t|
    t.text "user"
    t.integer "amount"
    t.text "category_credit"
    t.integer "total_amount"
    t.integer "month_amount"
    t.integer "year_amount"
    t.text "comment"
  end

end
