class AddRequesterId < ActiveRecord::Migration
  def change
    add_column :cat_rental_requests, :requester_id, :integer

    add_index :cat_rental_requests, :requester_id
  end
end
