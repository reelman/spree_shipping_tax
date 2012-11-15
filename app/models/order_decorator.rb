Spree::Order.state_machine.after_transition from: :delivery , do: :create_tax_charge!

Spree::Order.class_eval do
  def price_adjustments_with_shipping_adjustments
    result = price_adjustments_without_shipping_adjustments

    shipments.each do |shipment|
      result.concat shipment.adjustments
    end

    result
  end

  alias_method_chain :price_adjustments, :shipping_adjustments
end