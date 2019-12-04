class DropDiaryRefFromEntries < ActiveRecord::Migration[4.2]
  def change
    remove_reference :entries, :diary
  end
end
