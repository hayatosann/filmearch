class CreateTheaters < ActiveRecord::Migration[5.2]
  def change
    create_table :theaters do |t|
      t.string      :name
      t.text        :prefecture
      t.text        :address
      t.timestamps
    end
  end
end
