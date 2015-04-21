class AddVotingNameToMp < ActiveRecord::Migration
  def change
  	add_column :mps, :voting_name, :string
  end
end
