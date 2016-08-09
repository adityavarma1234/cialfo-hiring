class CreateColleges < ActiveRecord::Migration
  def change
    create_table :colleges do |t|
      t.text :name
      t.string :rank
      t.string :tuition_fees
      t.string :total_enrollement
      t.string :acceptance_rate
      t.string :average_retention_rates
      t.string :graduation_rate

      t.timestamps null: false
    end
  end
end
