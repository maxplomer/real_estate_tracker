class Contact < ActiveRecord::Base

  belongs_to(
    :property,
    class_name: "Property",
    foreign_key: :property_id
  )

end
