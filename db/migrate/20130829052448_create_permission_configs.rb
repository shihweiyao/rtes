class CreatePermissionConfigs < ActiveRecord::Migration
  def change
    create_table :permission_configs, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8'  do |t|
      t.integer :member_id
      t.integer :member_p, :default => 0, :null => false
      t.timestamps
    end
  end
end
