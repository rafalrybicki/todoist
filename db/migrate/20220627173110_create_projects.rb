class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.references :owner, null: false, foreign_key: { to_table: :users }
      t.string :name, null: false
      t.integer :color, default: 0
      t.integer :size, default: o
      t.boolean :favorite, default: false
      t.integer :order, null: false
      t.integer :sort_type, default: 0
      t.integer :sort_order, default: 0

      t.timestamps
    end
  end
end
