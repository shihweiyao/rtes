class AddMemberIdToAssetLists < ActiveRecord::Migration
  def change
    add_column :asset_lists, :member_id, :integer
  end
end
