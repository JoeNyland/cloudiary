class DropDiaries < ActiveRecord::Migration[4.2]
  def change
    drop_table :diaries
  end
end
