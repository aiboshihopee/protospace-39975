class AddPrototypeIdToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :prototype_id, :integer
    add_index :comments, :prototype_id
  end
end
