class CreateMemberUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :member_users do |t|
      t.references :member, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
