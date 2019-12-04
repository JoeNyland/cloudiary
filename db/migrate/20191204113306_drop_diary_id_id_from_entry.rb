class DropDiaryIdIdFromEntry < ActiveRecord::Migration[5.2]
  def change
    remove_column :entries, :diary_id_id
  end
end
