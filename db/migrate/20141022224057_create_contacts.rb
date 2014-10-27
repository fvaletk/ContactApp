class CreateContacts < ActiveRecord::Migration
  def up
    create_table :contacts do |t|
      t.string "firstname"
      t.string "lastname"
      t.string "email", :unique => true  
      t.timestamps
    end
  end

  def down
    drop_table :contacts
  end
end
