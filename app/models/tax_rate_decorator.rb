Spree::TaxRate.class_eval do
  def adjust_with_shipments(order)
    adjust_without_shipments(order)

    if included_in_price && order.shipment
      create_adjustment(create_label, order.shipment, order.shipment.adjustment)
    end

  end

  alias_method_chain :adjust, :shipments
end