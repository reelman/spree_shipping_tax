module Spree
  class Calculator::DefaultTaxWithShipping < Calculator::DefaultTax
    def self.description
      I18n.t(:default_tax_with_shipping)
    end

    def compute(computable)
      if computable.is_a?(Spree::Adjustment)
        compute_adjustment(computable)
      else
        super(computable)
      end
    end

    private

      def compute_adjustment(adjustment)
        deduced_total_by_rate(adjustment.amount, rate)
      end

      def compute_order(order)
        matched_line_items = order.line_items.select do |line_item|
          line_item.product.tax_category == rate.tax_category
        end

        # computer order total for UK VAT, by calculating vat on each line item separately
        line_items_total = matched_line_items.sum {|li|  round_to_two_places(li.total * rate.amount)}
        line_items_total + order.shipments.sum {|shipment| shipment.adjustment ? (round_to_two_places(shipment.adjustment.amount * rate.amount)) : 0}
      end

  end
end