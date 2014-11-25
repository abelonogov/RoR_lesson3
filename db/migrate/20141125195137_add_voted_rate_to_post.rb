class AddVotedRateToPost < ActiveRecord::Migration
  def change
    add_column :posts, :voted_rate, :integer, default: 0
  end
end
