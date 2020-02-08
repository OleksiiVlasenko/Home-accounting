class CreateHomeAccounting < ActiveRecord::Migration[6.0]
  def change
  	create_table :debet do |t|
  	t.text :user
  	t.integer :amount
  	t.text :category_in
  	t.integer :total_amount
  	t.integer :month_amount
  	t.integer :year_amount
  	end
  	create_table :credit do |t|
  	t.text :user
  	t.integer :amount
  	t.text :category_in
  	t.integer :total_amount
  	t.integer :month_amount
  	t.integer :year_amount
  	end
  
  end
end
