class RemoveLastNameFromLeads < ActiveRecord::Migration[6.1]
  def change
    remove_column :leads, :last_name, :string
  end
end
