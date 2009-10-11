namespace :utils do
  desc "Add new vendor products from a file"
  task(:add_vendor_products => :environment) do
    # Check whether there is filename in command line
    if ARGV.size != 2
      puts "Please run 'Rake utils:add_vendor_products filename'."
      exit 1
    end

    # Get the filename and open the file
    filename = ARGV.last
    begin
      infile = File.open(filename)
    rescue
      puts "Failed to open file '#{filename}'."
      exit 1
    end

    # Parse data in file one by one
    infile.each_line do |line|
      # Parse one line and verify data consistency
      fields = line.split(':')
      if fields.size != 6
        puts "WARN line[#{infile.lineno}]: #{line}"
        puts "Line format:"
        puts "vendor_id:title:capacity:material_amount:measuring_unit_id:price"
        exit 1
      end

      vendor_id, title, capacity, material_amount, measuring_unit_id, price = fields
      puts "Adding #{title}"
      puts "\t#{Vendor.find(vendor_id).full_name}, " +
        "#{material_amount}#{MeasuringUnit.find(measuring_unit_id).abbr_name}, " +
        "W#{capacity}, #{price}"
      VendorProduct.create(:title => title, :vendor_id => vendor_id,
                           :capacity => capacity, :price => price, :active => true,
                           :material_amount => material_amount,
                           :measuring_unit_id => measuring_unit_id)
    end
  end
end
