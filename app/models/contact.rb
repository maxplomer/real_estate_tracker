class Contact < ActiveRecord::Base
  validates :name, :presence => true
  validates :title, :presence => true
  validates :email, :presence => true
  validates :company, :presence => true
  validates :phone, :presence => true

  belongs_to(
    :property,
    class_name: "Property",
    foreign_key: :property_id
  )

end
