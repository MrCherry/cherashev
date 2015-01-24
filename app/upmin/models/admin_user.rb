class AdminUser < Upmin::Model
  # The attributes method overwrites default attributes shown for a model, and replaces them with the provided attributes. These don't all need to be editable, but as long as there is an :attr_name= method available upmin assumes that the attribute should be editable.
  # attributes :email, :password, :password_confirmation

  # The items_per_page method overrides the number of items shown for a model from the default of 30.
  # (The global default can also be modified in the upmin config initializer.)
  # items_per_page 15

  # # The actions method overwrites all actions and uses the provided list of methods.
  # actions :update_price
  #
  # # You can use custom methods inside of admin that are explicitly for admin pages. For example, you might want a method to update the price and automatically add a 10% markup.
  # def update_price(raw_price)
  #   model.price = raw_price * 1.10 # our markup is 10%
  #   model.save!
  # end


end