class CreateBillIssues < ActiveRecord::Migration
  def change
    create_table :bill_issues do |t|
      t.integer :bill_id
      t.integer :issue_id

      t.timestamps null: false
    end
  end
end
