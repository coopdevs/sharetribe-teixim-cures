community = Community.first
new_listing_author = Person.find_by(given_name: 'Troy')
current_user = new_listing_author
shape = ListingShape.find_by(name: 'venta-sin-pagos-en-linea')
uuid = UUIDUtils.create

params = ActionController::Parameters.new({
  listing: {
    title: "Taula",
    price: "12",
    unit: "{\"unit_type\":\"unit\",\"kind\":\"quantity\",\"quantity_selector\":\"number\"}",
    shipping_price: "0",
    shipping_price_additional: "0",
    delivery_methods: ["pickup"],
    description: "una taula",
    category_id: "1",
    listing_shape_id: "1"
  }
})

result = ListingFormViewUtils.build_listing_params(shape, uuid, params, community)
raise "Couldn't build listing params" unless result.success

listing = Listing.new(result.data)
service = Admin::ListingsService.new(community: community, params: params, person: current_user)

ActiveRecord::Base.transaction do
  listing.author = new_listing_author
  service.create_state(listing)

  listing.save!

  listing.upsert_field_values!(params.to_unsafe_hash[:custom_fields])
  listing.reorder_listing_images(params, current_user.id)
end
