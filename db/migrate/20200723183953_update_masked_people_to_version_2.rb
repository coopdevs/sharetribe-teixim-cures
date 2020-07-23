class UpdateMaskedPeopleToVersion2 < ActiveRecord::Migration[5.2]
  def change
    update_view :masked_people, version: 2, revert_to_version: 1
  end
end
