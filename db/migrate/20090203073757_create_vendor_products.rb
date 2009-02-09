# -*- coding: utf-8 -*-
class CreateVendorProducts < ActiveRecord::Migration
  def self.up
    create_table :vendor_products do |t|
      t.string  :title, :null => false
      t.integer :vendor_id, :null => false
      t.integer :capacity
      t.decimal :price, :null => false, :precision => 10, :scale => 4
      t.boolean :active, :null => false, :default => true

      t.timestamps
    end

    ppa_products =
      [
       ["100ml Amber Glass Bottle", -1, 0.5],
       ["100ml Chamomile Spray - Chamaemelum nobile - Hydrolat", 100, 3.5],
       ["100ml Tea Tree & Peppermint Mouthwash", 100, 2.98],
       ["10ml Amber Glass Bottle dropper & cap", -1, 0.3],
       ["10ml Benzoin - Styrax benzoin - resinoid", 10, 2.6],
       ["10ml Bergamot FCF - Citrus bergamia", 10, 4.0],
       ["10ml Citronella - Cymbopogon nardus", 10, 2.15],
       ["10ml Cypress - Cupressus sempervirens", 10, 4.05],
       ["10ml Elemi - Canarium luzonicum", 10, 3.5],
       ["10ml Geranium - Pelargonium graveolens", 10, 4.0],
       ["10ml Ginger - Zingiber officinalis", 10, 3.95],
       ["10ml Glass Bottle with pipette", -1, 0.7],
       ["10ml Juniper Berry - Juniperus communis", 10, 6.5],
       ["10ml Lavender High Altitude - L.angustifolia", 10, 4.95],
       ["10ml Manuka - Leptospernum scorparium", 10, 7.40],
       ["10ml Myrrh - Commiphora myrrha", 10, 5.75],
       ["10ml Orange Sweet - Citrus aurantium var sinensis per", 10, 3.25],
       ["10ml Patchouli - Pogostemon cablin", 10, 4.9],
       ["10ml Pine Scotch - Pine sylvestris", 10, 2.95],
       ["10ml Ravansara - Ravansara aromaticum", 10, 6.35],
       ["10ml Rosemary - Rosmarinus officinalis ct cineole", 10, 3.2],
       ["10ml Rosewood - Aniba roseodora", 10, 2.95],
       ["10ml Sandalwood - Santalum austrocalendonicum", 10, 22],
       ["10ml Tea Tree - Melaleuca alternifolia", 10, 2.95],
       ["125ml Nurture Stretch Marks - Body Lotion", 125, 5.4],
       ["125ml Nurture Stretch Marks - Body Oil", 125, 6.8],
       ["200ml Mandarin & Chamomile Baby Bath", 200, 3.6],
       ["20ml Amber Glass Bottle Dropper & Cap", -1, 0.4],
       ["24 Hole Wooden Box", -1, 17.25],
       ["25ml Amber Glass Bottle with Dropper and White Cap", -1, 1.95],
       ["30ml Amber Glass Jar/Black Lids", -1, 0.56],
       ["3ml Chamomile (Roman) - Chamaemelum nobile", 3, 5.2],
       ["3ml Frankincense - Boswelli carteri", 3, 4.25],
       ["3ml Sandalwood - Santalum austrocaledonicum", 3, 8.8],
       ["100gm Beeswax Granules - White", -1, 2.0],
       ["500ml Carrier Lotion", 500, 8.75],
       ["500ml Moisturiser Base - All skin types", 500, 12.5],
       ["500ml Neroli - Citrus aurantium var amara - Hydrolat", 500, 10.0],
       ["50ml Amber Glass Bottle with Dropper and White Cap", 50, 0.42],
       ["50ml Glass Measuring Beaker", -1, 2.25],
       ["50ml Perinease", 50, 4.95],
       ["5ml Sample Jars", -1, 0.35],
       ["60ml Scarworks Cream - Helps regenerate skin", 60, 5.25],
       ["60ml Skinworks Cream - To protect tender skin", 60, 5.25],
       ["Aromastream Fan Vaporiser", -1, 19.95],
       ["Aromastream Replacement Pad", -1, 2.90],
       ["Aromatherapy for Babies & Children", -1, 14.95],
       ["Atomiser Tops for Amber Bottle", -1, 0.5],
       ["Glass Stirring Rod", -1, 1.55],
       ["Spatula", -1, 0.06],
      ]
    VendorProduct.create(:title     => "10ml 薰衣草",
                         :vendor_id => 1,
                         :capacity  => 10,
                         :price     => 2.00)
    VendorProduct.create(:title     => "10ml Chamomile",
                         :vendor_id => 2,
                         :capacity  => 10,
                         :price     => 7.00)
    ppa_products.each do | product_infos |
      title, cap, price = product_infos
      if cap == -1
        VendorProduct.create(:title => title, :vendor_id => 3, :price => price)
      else
        VendorProduct.create(:title => title, :vendor_id => 3,
                             :capacity => cap, :price => price)
      end
    end
  end

  def self.down
    drop_table :vendor_products
  end
end
