class CreateVotedPost < ActiveRecord::Migration
  def change
    create_table :voted_posts do |t|
      t.integer :user_id
      t.integer :post_id
    end
  end
end
