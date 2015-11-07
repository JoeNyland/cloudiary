class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.references :diary, index: true, foreign_key: true
      t.string :title
      t.text :body

      t.timestamps null: false
    end
  end
end
