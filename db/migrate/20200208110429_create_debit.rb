class CreateDebit < ActiveRecord::Migration[6.0]
  def change
  	create_table :credit do |t|
  	t.text :user
  	t.integer :amount
  	t.text :category_debit
  	t.integer :total_amount
  	t.integer :month_amount
  	t.integer :year_amount
  	t.text :comment
	end
end
end
