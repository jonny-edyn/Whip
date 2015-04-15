class DropPostCodeTable < ActiveRecord::Migration
  def change
  	drop_table :post_codes
  end
end
