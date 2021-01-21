community = Community.first
author = Person.find_by(given_name: 'Troy')
current_user = author

def create_listing(params, shape, community, current_user, author)
  uuid = UUIDUtils.create
  result = ListingFormViewUtils.build_listing_params(shape, uuid, params, community)
  raise "Couldn't build listing params" unless result.success

  listing = Listing.new(result.data)
  service = Admin::ListingsService.new(community: community, params: params, person: current_user)

  ActiveRecord::Base.transaction do
    listing.author = author
    service.create_state(listing)

    listing.save!

    listing.upsert_field_values!(params.to_unsafe_hash[:custom_fields])
    listing.reorder_listing_images(params, current_user.id)
  end
end

paid = ListingShape.find_by(name: 'venta-sin-pagos-en-linea')
params = ActionController::Parameters.new({
  listing: {
    title: "Taula",
    price: "0",
    unit: "{\"unit_type\":\"unit\",\"kind\":\"quantity\",\"quantity_selector\":\"number\"}",
    shipping_price: "0",
    shipping_price_additional: "0",
    delivery_methods: ["pickup"],
    description: "una taula",
    category_id: "2",
    listing_shape_id: "1"
  }
})

create_listing(params, paid, community, current_user, author)

free = ListingShape.find_by(name: 'venta-con-pagos-en-linea')
params = ActionController::Parameters.new({
  listing: {
    title: "Cadires",
    price: "50",
    unit: "{\"unit_type\":\"unit\",\"kind\":\"quantity\",\"quantity_selector\":\"number\"}",
    shipping_price: "0",
    shipping_price_additional: "0",
    delivery_methods: ["pickup"],
    description: "unes cadires molt maques",
    category_id: "2"
  }
})

create_listing(params, free, community, current_user, author)
