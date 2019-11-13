class DropDiaries < ActiveRecord::Migration
  def change
    drop_table :diaries
  end
end
