class CreateStorages < ActiveRecord::Migration[6.0]
  def change
    create_table :storages do |t|
      t.belongs_to :category, null: false
      t.integer :total
      t.integer :buffer
      t.date :procurement_time, null: false

      t.timestamps
    end
  end
end
