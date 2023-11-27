class ChangeUrlToStringInProgram < ActiveRecord::Migration[7.0]
  def change
    change_column :programs, :url, :string
  end
end
