class CreateLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|
      t.string :app_name, null: false
      t.string :status, default: 'fail'
      t.integer :log_type, null: false
      t.timestamps
    end
  end
end
