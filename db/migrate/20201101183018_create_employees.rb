class CreateEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :surname
      t.integer :age
      t.string :hired_at
      t.boolean :in_experience
      t.string :level
      t.float :salary
      t.belongs_to :coordinator
      t.timestamps
    end
  end
end
