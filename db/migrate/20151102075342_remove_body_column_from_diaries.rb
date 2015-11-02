class RemoveBodyColumnFromDiaries < ActiveRecord::Migration
  def change
    rename_column :diaries, :body, :title
    change_column :diaries, :title, :string
  end
end
