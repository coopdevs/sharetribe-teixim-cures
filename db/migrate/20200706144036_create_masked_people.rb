class CreateMaskedPeople < ActiveRecord::Migration[5.2]
  def change
    create_view :masked_people
  end
end
