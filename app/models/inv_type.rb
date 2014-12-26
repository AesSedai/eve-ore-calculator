class InvType < ActiveRecord::Base
  self.table_name = 'inv_type'
  self.primary_key = :type_id

  has_many :inv_type_materials, foreign_key: :type_id
  has_many :ore_refinings, foreign_key: :type_id

end