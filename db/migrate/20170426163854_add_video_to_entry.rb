class AddVideoToEntry < ActiveRecord::Migration[5.0]
  def change
    add_column :entries, :video, :string
  end
end
