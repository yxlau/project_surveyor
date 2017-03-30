class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.string :title
      t.references :survey, foreign_key: true
      t.integer :option_count
      t.boolean :required
      t.boolean :multi

      t.timestamps
    end
  end
end
