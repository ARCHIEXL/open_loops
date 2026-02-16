class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.integer :importance
      t.integer :urgency
      t.integer :effort
      t.datetime :completed_at

      t.timestamps
    end
  end
end
