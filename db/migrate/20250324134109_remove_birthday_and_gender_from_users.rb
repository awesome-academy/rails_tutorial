class RemoveBirthdayAndGenderFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :birthday, :date if column_exists?(:users, :birthday)
    remove_column :users, :gender, :string if column_exists?(:users, :gender)
  end
end
