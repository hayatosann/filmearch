class RemoveRateFromReviews < ActiveRecord::Migration[5.2]
  def change
    remove_column :reviews, :rate, :integer
  end
end
