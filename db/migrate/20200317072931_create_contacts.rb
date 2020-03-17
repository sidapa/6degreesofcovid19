class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :contact_id
      t.datetime :last_contact
      t.datetime :confirmed_at

      t.timestamps
    end
  end
end
