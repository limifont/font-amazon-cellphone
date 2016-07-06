class CreateCellphones < ActiveRecord::Migration
  def change
    create_table :cellphones do |t|
      t.string :title
      t.string :star_count
      t.string :price
      t.string :img_src

      t.timestamps null: false
    end
  end
end
