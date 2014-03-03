class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8'  do |t|
      t.string :name
      t.string :username      
      t.string :email
      t.string :phone
      t.string :verification_code           
      t.boolean :verified, default: false
      
      t.string :hashed_pw
      t.string :salt
      t.timestamps
    end
  end
end
