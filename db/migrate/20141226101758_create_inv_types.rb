class CreateInvTypes < ActiveRecord::Migration
  def change
    create_table :inv_types do |t|

      t.timestamps null: false
    end
  end
end
