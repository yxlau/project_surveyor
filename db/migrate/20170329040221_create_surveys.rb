class CreateSurveys < ActiveRecord::Migration[5.0]
  def change
    create_table :surveys do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.integer :responses_count, default: 0

      t.timestamps
    end
  end
end
