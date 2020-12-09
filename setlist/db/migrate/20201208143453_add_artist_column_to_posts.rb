class AddArtistColumnToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :artist,
    :string
  end
end
