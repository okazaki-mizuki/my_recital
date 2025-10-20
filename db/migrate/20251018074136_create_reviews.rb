class CreateReviews < ActiveRecord::Migration[8.0]
  def change
    create_table :reviews do |t|
      t.string :orchestra
      t.string :conductor
      t.string :music
      t.text :impression

      t.timestamps
    end
  end
end
