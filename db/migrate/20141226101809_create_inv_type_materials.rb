class CreateInvTypeMaterials < ActiveRecord::Migration
  def change
    create_table :inv_type_materials do |t|

      t.timestamps null: false
    end
  end
end
