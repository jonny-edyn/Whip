class AddImpressionsColumnToBills < ActiveRecord::Migration
  def change
  	add_column :bills, :impressions_count, :integer, default: 0
  end
end
