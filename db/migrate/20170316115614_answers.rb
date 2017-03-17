class Answers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string   :body, null: false
      t.boolean  :correct, default: :false
      t.integer  :user_id, null: false
      t.integer  :question_id, null: false

      t.timestamps null: false
    end
  end
end
