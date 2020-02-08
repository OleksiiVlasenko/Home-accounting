class CreateCredit < ActiveRecord::Migration[6.0]
  def change
  	create_table :credits do |t|
  	t.text :user
  	t.integer :amount
  	t.text :category_credit
  	t.text :date
    t.text :comment
	end
	
end
end
