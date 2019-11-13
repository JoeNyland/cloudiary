class DropDiaryRefFromEntries < ActiveRecord::Migration
  def change
    remove_reference :entries, :diary
  end
end
