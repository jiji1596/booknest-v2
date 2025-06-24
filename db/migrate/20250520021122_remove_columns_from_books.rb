class RemoveColumnsFromBooks < ActiveRecord::Migration[7.1]
  def change
    remove_column :books, :availability, :boolean
    remove_column :books, :description, :string
    remove_reference :books, :user, foreign_key: true
  end
end
