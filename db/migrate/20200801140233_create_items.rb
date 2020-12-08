class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.belongs_to :employee, default: nil
      t.belongs_to :brand, null: false
      t.string :name, null: false
      t.boolean :status, default: true
      t.text :notes
      t.string :document

      t.timestamps
    end
  end
end
