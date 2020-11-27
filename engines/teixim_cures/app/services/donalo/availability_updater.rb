module Donalo
  class AvailabilityUpdater < StockUpdater
    def update
      listing.open = current_quantity > 0
      listing.save
    end
  end
end

