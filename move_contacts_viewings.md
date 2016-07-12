# After fixing paperclip s3 bucket had to create new property and move viewings, contacts, showings from old listings to new to make data look realistic

Want to move data from property 9 to property 10

    View.where(property_id: 9).each do |x|
      x.property_id = 10
      x.save
    end

    Contact.where(property_id: 9).each do |x|
      x.property_id = 10
      x.save
    end

    Showing.where(property_id: 9).each do |x|
      x.property_id = 10
      x.save
    end