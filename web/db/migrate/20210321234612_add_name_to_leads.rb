class AddNameToLeads < ActiveRecord::Migration[6.1]
  def change
    add_column :leads, :name, :string
  end
end
