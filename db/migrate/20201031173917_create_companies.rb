class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.integer :cnpj
      t.string :foundation
      t.belongs_to :foundator
      t.timestamps
    end
  end
end
