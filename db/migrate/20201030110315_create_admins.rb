class CreateAdmins < ActiveRecord::Migration[6.0]
  def change
    create_table :admins do |t|
      t.string :provider, default: "google_oauth2"
      t.string :uid
      t.string :name, null: false
      t.string :email, null: false
      t.boolean :category_access
      t.boolean :brand_access
      t.boolean :item_access
      t.boolean :employee_access
      t.boolean :storage_access
      t.boolean :admin_access, default: false

      t.timestamps
    end
  end
end
