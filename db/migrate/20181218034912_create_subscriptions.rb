class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
	  t.string :app_name, null: false
      t.string :email, null: false
      t.timestamps
    end
    add_index :subscriptions, [:app_name, :email], unique: true
  end
end
