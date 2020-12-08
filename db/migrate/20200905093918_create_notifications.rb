class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.string :notifiable_name
      t.string :details
      t.boolean :read_status, default: false
      t.string :urgency

      t.timestamps
    end
  end
end
