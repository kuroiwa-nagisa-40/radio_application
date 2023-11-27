class ChangeInformationToEmailInProgram < ActiveRecord::Migration[7.0]
  def change
    rename_column :programs, :information, :url
  end
end
