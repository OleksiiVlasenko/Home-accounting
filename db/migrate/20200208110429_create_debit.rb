class CreateDebit < ActiveRecord::Migration[6.0]
  def change
  	create_table :debits do |t|
  	t.text :user
  	t.integer :amount
  	t.text :category_debit
  	t.text :date
    t.text :comment
	end
end
end
