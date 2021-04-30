class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.text :text
      t.date :deadline
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
