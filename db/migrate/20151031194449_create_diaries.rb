class CreateDiaries < ActiveRecord::Migration
  def change
    create_table :diaries do |t|
      t.text :body
      t.references :owner, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
