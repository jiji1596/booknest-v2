class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :description
      t.integer :published_year
      t.boolean :availability, default: false
      # t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
