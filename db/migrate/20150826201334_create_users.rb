class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :password_digest
      t.string :email

      t.timestamps null: false
    end
    
    add_index :users, :email ##### , unique: true ==> database level unique check
  end
end
