class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :like
      t.references :voteable, polymorphic: true, index: true
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end
end
