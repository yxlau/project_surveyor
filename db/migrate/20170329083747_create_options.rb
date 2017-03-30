class CreateOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :options do |t|
      t.string :value
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end
