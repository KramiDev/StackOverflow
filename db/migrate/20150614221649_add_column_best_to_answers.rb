class AddColumnBestToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :best, :boolean, null: false, default: false
  end
end
