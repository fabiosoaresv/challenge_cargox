class CreateCoordinators < ActiveRecord::Migration[6.0]
  def change
    create_table :coordinators do |t|
      t.string :name
      t.string :surname
      t.integer :age
      t.string :hired_at
      t.belongs_to :leader
      t.timestamps
    end
  end
end
