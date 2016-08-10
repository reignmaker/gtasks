class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.references :user, index: true, foreign_key: true
      t.integer :state, null: false, default: 0

      t.timestamps null: false
    end

    add_index :tasks, :state

  end
end
