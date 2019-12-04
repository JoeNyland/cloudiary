class RemoveBodyColumnFromDiaries < ActiveRecord::Migration[4.2]
  def change
    rename_column :diaries, :body, :title
    change_column :diaries, :title, :string
  end
end
