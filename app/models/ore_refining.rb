class OreRefining < ActiveRecord::Base
  self.table_name = 'ore_refining'
  self.primary_key = :type_id

  belongs_to :inv_type, foreign_key: :type_id

end
