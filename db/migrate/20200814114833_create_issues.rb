class CreateIssues < ActiveRecord::Migration[6.0]
  def change
    create_table :issues do |t|
      t.belongs_to :item, null: false
      t.text :details, null: false
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
