class CreateAssetLists < ActiveRecord::Migration
  def change
    create_table :asset_lists, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name
      t.string :location
      t.timestamp :time

      t.timestamps
    end
  end
end
