class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :firstname
      t.string :lastname
      t.text :address
      t.date :dob
      t.string :phone
      t.string :gender
      t.decimal :balance
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
