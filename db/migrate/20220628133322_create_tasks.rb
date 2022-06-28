class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :content, null: false
      t.boolean :completed, default: false
      t.datetime :target_date, null: true
      t.integer :order, null: false
      t.references :project, null: false, foreign_key: true
      t.references :owner, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
