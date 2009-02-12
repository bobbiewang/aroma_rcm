# -*- coding: utf-8 -*-
def fill_products(products, vendor_id)
  products.each do | product_infos |
    title, cap, price = product_infos
    if cap == -1
      VendorProduct.create(:title => title, :vendor_id => vendor_id, :price => price)
    else
      VendorProduct.create(:title => title, :vendor_id => vendor_id,
                           :capacity => cap, :price => price)
    end
  end
end

class CreateVendorProducts < ActiveRecord::Migration
  def self.up
    create_table :vendor_products do |t|
      t.string  :title, :null => false
      t.integer :vendor_id, :null => false
      t.integer :capacity
      t.decimal :price, :precision => 10, :scale => 4
      t.boolean :active, :null => false, :default => true
      t.text :description

      t.timestamps
    end

    of_products =
      [
       ["安息香 10ml",              10,  144],
       ["澳洲坚果油 50ml",          50,  128],
       ["白千层 10ml",              10,  136],
       ["白芷根 2ml",               2,   352],
       ["柏树 10ml",                10,  200],
       ["玻璃搅拌棒",               -1,  18],
       ["玻璃量杯 25ml/30ml",       -1,  54],
       ["茶树 10ml",                10,  144],
       ["朝鲜蓟（豆蔻） 10ml",      10,  400],
       ["橙叶 10ml",                10,  136],
       ["德国甘菊 2ml",             2,   304],
       ["丁香苞 10ml",              10,  144],
       ["杜松莓 10ml",              10,  256],
       ["芳香师专业木盒/48孔",      -1,  800],
       ["佛手柑（FCF） 10ml",       10,  224],
       ["复方薰香油/强效抗菌 10ml", 10,  0],
       ["广藿香 10ml",              10,  144],
       ["荷荷芭油 150ml",           150, 328],
       ["黑胡椒 10ml",              10,  248],
       ["胡萝卜油 50ml",            50,  192],
       ["胡荽 10ml",                10,  168],
       ["金盏花油 50ml",            50,  192],
       ["抗菌手册",                 -1,  0],
       ["苦橙花 2ml",               2,   600],
       ["葵花油 150ml",             150, 120],
       ["扩香热油钵（含热油皿）",   -1,  810],
       ["莱姆 10ml",                10,  136],
       ["酪梨油（Crude） 50ml",     50,  120],
       ["酪梨油（Refined） 50ml",   50,  136],
       ["琉璃苣油 50ml",            50,  304],
       ["绿薄荷 10ml",              10,  144],
       ["罗马甘菊 5ml",             5,   430],
       ["马乔莲（Spanish） 10ml",   10,  240],
       ["玫瑰（5%） 10ml",          10,  184],
       ["玫瑰果油 50ml",            50,  384],
       ["玫瑰香脂 2ml",             2,   1008],
       ["没药 10ml",                10,  352],
       ["迷迭香 10ml",              10,  144],
       ["摩洛哥甘菊 5ml",           5,   410],
       ["耐奥利 10ml",              10,  152],
       ["柠檬 10ml",                10,  136],
       ["柠檬草 10ml",              10,  152],
       ["牛膝草 10ml",              10,  312],
       ["欧薄荷（English） 10ml",   10,  152],
       ["欧蓍草 10ml",              10,  600],
       ["欧蓍草 5ml",               5,   410],
       ["葡萄籽油 150ml",           150, 128],
       ["葡萄柚 10ml",              10,  144],
       ["肉桂叶 10ml",              10,  180],
       ["乳香 10ml",                10,  360],
       ["山艾 5ml",                 5,   248],
       ["山茶花油 50ml",            50,  184],
       ["山鸡椒 10ml",              10,  136],
       ["生姜 10ml",                10,  224],
       ["圣约翰草油 50ml",          50,  216],
       ["鼠尾草 10ml",              10,  248],
       ["苏格兰松树 10ml",          10,  152],
       ["台湾红桧 10ml",            10,  136],
       ["檀香木 10ml",              10,  720],
       ["桃核油 150ml",             150, 184],
       ["桃金娘 10ml",              10,  184],
       ["天竺葵（Egyptian） 10ml",  10,  208],
       ["甜百里香 10ml",            10,  344],
       ["甜百里香 5ml",             5,   250],
       ["甜柳橙 10ml",              10,  128],
       ["甜杏仁油 150ml",           150, 144],
       ["甜茴香 10ml",              10,  144],
       ["晚樱草 150ml",             150, 384],
       ["晚樱草油 50ml",            50,  240],
       ["维吉尼亚杉木 10ml",        10,  170],
       ["闻香纸 50 片",             -1,  18],
       ["香草地图",                 -1,  40],
       ["香茅 10ml",                10,  128],
       ["香水树（Extra） 10ml",     10,  216],
       ["小麦胚芽油 150ml",         150, 232],
       ["杏核油 150ml",             150, 192],
       ["亚特兰大杉木 10ml",        10,  136],
       ["岩兰草 10ml",              10,  216],
       ["椰子油 50ml",              50,  88],
       ["掌型玫瑰 10ml",            10,  168],
       ["真实薰衣草 10ml",          10,  152],
       ["真香蜂草 2ml",             2,   1184],
       ["芝麻油 150ml",             150, 192],
       ["紫苏（罗勒） 10ml",        10,  224],
       ["茉莉（绝对油） 2ml",       2,   560],
       ["缬草 5ml",                 5,   352],
       ["桉树（Citriodora） 10ml",  10,  136],
       ["桉树（Globulus） 10ml",    10,  150],
       ["桉树（Radiata） 10ml",     10,  210],
       ["榛实油 50ml",              50,  50],
       ["橘 10ml",                  10,  168]
      ]

    spa_products =
      [
       ["10ml Bergamot",                      10,  3.91],
       ["3ml Chamomile German",               3,   9.12],
       ["3ml Chamomile Roman",                3,   4.49],
       ["10ml Cypress",                       10,  3.37],
       ["10ml Geranium",                      10,  4.05],
       ["10ml Grapefruit",                    10,  2.31],
       ["10ml Juniper berry",                 10,  5.11],
       ["10ml Lavender",                      10,  2.79],
       ["10ml Lemon",                         10,  2.69],
       ["3ml Neroli",                         3,   25.33],
       ["10ml Niaouli",                       10,  2.79],
       ["10ml Patchouli",                     10,  2.89],
       ["10ml Pine",                          10,  3.95],
       ["10ml Rosemary",                      10,  3.98],
       ["10ml Sandalwood",                    10,  18.16],
       ["10ml Spikenard",                     10,  10],
       ["10ml Tea tree",                      10,  2.38],
       ["10ml Thyme sweet",                   10,  10.18],
       ["10ml Benzoin",                       10,  2.69],
       ["10ml Frankincense",                  10,  6.77],
       ["10ml Myrrh",                         10,  5.2],
       ["125ml Almond1",                      25,  2.97],
       ["50ml Evening primrose",              50,  5.9],
       ["125ml Grapeseed",                    125, 2.21],
       ["50ml Jojoba",                        50,  4.26],
       ["50ml Rosehip",                       50,  14.22],
       ["125ml Wheatgerm",                    125, 4.43],
       ["15ml Lip balm",                      15,  3.18],
       ["10ml Chamomile eye drops",           10,  1.7],
       ["500ml Cleansing milk",               500, 14.6],
       ["50ml Cypress exfoliating cream",     50,  4.95],
       ["200ml Chamomile Roman Hydrolat",     200, 5.34],
       ["200ml  Lavender Hydrolat",           200, 5.34],
       ["200ml Melissa Hydrolat",             200, 5.34],
       ["200ml Rose Hydrolat",                200, 7.45],
       ["200ml Neroli Hydrolat",              200, 3.68],
       ["200ml Peppermint  Hydrolat",         200, 5.34],
       ["200ml Rosemary Hydrolat",            200, 5.34],
       ["200ml Witchazel Hydrolat",           200, 5.34],
       ["Glass Beaker",                       -1,  3.5],
       ["Stir rod",                           -1,  2.5],
       ["Measuring cup",                      -1,  0.5],
       ["10ml glass bottle + dropper/cap",    -1,  0.3],
       ["Aromastream vaporiser",              -1,  21.23],
       ["Filter replacement for Aromastream", -1,  1.7],
       ["Car freshener",                      -1,  3.1],
       ["AromaTherapy Workbook",              -1,  16],
       ["Carrier oils",                       -1,  20],
       ["Hydrolats",                          -1,  20],
       ["Shirley Price AromaTherapy(DVD)",    -1,  20],
       ["30ml Scalp tonic",                   30,  2.83],
       ["200ml Shampoo for greasy hair",      200, 3.74],
       ["200ml Hair conditioner",             200, 2.79]
      ]

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
       ["Spatula", -1, 0.06]
      ]

    fill_products(of_products,  1)
    fill_products(spa_products, 2)
    fill_products(ppa_products, 3)
  end

  def self.down
    drop_table :vendor_products
  end
end
