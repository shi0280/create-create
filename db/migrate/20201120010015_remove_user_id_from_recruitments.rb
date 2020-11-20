class RemoveUserIdFromRecruitments < ActiveRecord::Migration[6.0]
  def change
    remove_column :recruitments, :user_id, :reference
  end
end
