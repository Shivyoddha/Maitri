class AddforiegnToBookamark < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookmarks, :user, foreign_key: true
    add_reference :bookmarks, :blog, foreign_key: true
  end
end
