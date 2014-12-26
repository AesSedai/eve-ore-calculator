class InvTypeMaterial < ActiveRecord::Base
  self.table_name = 'inv_type_material'
  self.primary_key = :type_id

  belongs_to :inv_type, foreign_key: :type_id

end
