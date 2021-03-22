class RemoveFirstNameFromLeads < ActiveRecord::Migration[6.1]
  def change
    remove_column :leads, :first_name, :string
  end
end
