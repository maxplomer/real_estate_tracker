class Property < ActiveRecord::Base

  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id
  )

  has_many(
    :contacts,
    class_name: "Contact",
    foreign_key: :property_id,
    dependent: :destroy
  )

  has_many(
    :showings,
    class_name: "Showing",
    foreign_key: :property_id,
    dependent: :destroy
  )

  has_many(
    :views,
    class_name: "View",
    foreign_key: :property_id,
    dependent: :destroy
  )
	
end
