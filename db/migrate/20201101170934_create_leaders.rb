class CreateLeaders < ActiveRecord::Migration[6.0]
  def change
    create_table :leaders do |t|
      t.string :name
      t.string :surname
      t.integer :age
      t.string :department
      t.belongs_to :foundator
      t.timestamps
    end
  end
end
