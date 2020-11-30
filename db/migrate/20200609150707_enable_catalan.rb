class EnableCatalan < ActiveRecord::Migration[5.2]
  def up
    community = Community.first

    # The order of locales matters. The first one is the default
    community.locales << 'ca'
    community.save!
  end

  def down
    community = Community.first
    community.update_attribute(:settings, { 'locales' => ['es'] })
  end
end
