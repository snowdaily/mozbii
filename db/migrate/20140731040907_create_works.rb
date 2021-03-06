class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.string :name
      t.text :data, :limit => 16777215
      t.integer :user_id

      t.timestamps
    end
  end
end
