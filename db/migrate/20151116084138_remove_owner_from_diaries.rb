class RemoveOwnerFromDiaries < ActiveRecord::Migration
  def change
    remove_column :diaries, :owner, :reference
    remove_column :diaries, :owner_id, :integer
  end
end
