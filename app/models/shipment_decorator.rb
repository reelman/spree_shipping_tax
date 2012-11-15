Spree::Shipment.class_eval do
  has_many :adjustments, :as => :adjustable, :dependent => :destroy
end