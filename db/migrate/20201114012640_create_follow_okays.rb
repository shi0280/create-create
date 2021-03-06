class CreateFollowOkays < ActiveRecord::Migration[6.0]
  def change
    create_table :follow_okays do |t|
      t.references :following, null: false, foreign_key: {to_table: :users}
      t.references :followed, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
