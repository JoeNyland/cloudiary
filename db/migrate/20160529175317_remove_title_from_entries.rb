class RemoveTitleFromEntries < ActiveRecord::Migration[4.2]
  def change
    remove_column :entries, :title
  end
end
