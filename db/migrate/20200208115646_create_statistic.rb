class CreateStatistic < ActiveRecord::Migration[6.0]
  def change
  	create_table :statistics do |t|
  	t.integer :total_amount
  	t.integer :month_amount
  	t.integer :year_amount
  	end

  	
  end
end
