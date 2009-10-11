# -*- coding: utf-8 -*-
require 'erb'

# 用 rake db:structure:dump 可以 dump 出用于代码的 SQL 语句
# 然后和 mysqldump istore_development -u root > dump.sql 的结果比较
module DbDumper
  class ColumnInfo
    attr_accessor :name, :config

    def initialize(name, config)
      @name, @config = name, config
    end
  end

  class TableInfo
    attr_accessor :name, :columns

    def initialize(name, columns)
      @name, @columns = name, columns
    end

    def self.load(sql_text)
      info = nil
      sql_text.each do |line|
        case line.strip
        when /CREATE TABLE `(.*)`.*/
          info = new($1, [])
        when /`(.*)`\s+(.*),/
          info.columns << ColumnInfo.new($1, $2)
        end
      end
      info
    end
  end

  def self.to_mysql
    dump_header + dump_currencies + dump_customers + dump_material_items +
      dump_measuring_units + dump_purchase_order_items +
      dump_purchase_orders + dump_sale_order_items + dump_sale_orders +
      dump_saled_store_product_items + dump_sessions + dump_store_product_items +
      dump_store_products + dump_used_material_items + dump_users +
      dump_vendor_products + dump_vendors + dump_tailer
  end

  def self.dump_header
    template = <<END_OF_TEMPLATE
--
-- Database:
--

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- CREATE DATABASE `istore_development` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE 'istore_development';

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

END_OF_TEMPLATE

    template
  end

  def self.dump_currencies
    table_info =
      TableInfo.new('currencies',
                    [ColumnInfo.new('id', "int(11) NOT NULL auto_increment"),
                     ColumnInfo.new('full_name', "varchar(255) NOT NULL"),
                     ColumnInfo.new('iso_code', "varchar(255) NOT NULL"),
                     ColumnInfo.new('symbol', "varchar(255) NOT NULL"),
                     ColumnInfo.new('created_at', "datetime default NULL"),
                     ColumnInfo.new('updated_at', "datetime default NULL")])

    dump_table(table_info)
  end

  def self.dump_customers
    table_info =
      TableInfo.new('customers',
                    [ColumnInfo.new('id', "int(11) NOT NULL auto_increment"),
                     ColumnInfo.new('name', "varchar(255) NOT NULL"),
                     ColumnInfo.new('gender', "varchar(255) default NULL"),
                     ColumnInfo.new('address', "varchar(255) default NULL"),
                     ColumnInfo.new('post_code', "varchar(255) default NULL"),
                     ColumnInfo.new('telephone', "varchar(255) default NULL"),
                     ColumnInfo.new('mobilephone', "varchar(255) default NULL"),
                     ColumnInfo.new('email', "varchar(255) default NULL"),
                     ColumnInfo.new('wangwang', "varchar(255) default NULL"),
                     ColumnInfo.new('qq', "varchar(255) default NULL"),
                     ColumnInfo.new('msn', "varchar(255) default NULL"),
                     ColumnInfo.new('birthday', "date default NULL"),
                     ColumnInfo.new('details', "text"),
                     ColumnInfo.new('created_at', "datetime default NULL"),
                     ColumnInfo.new('updated_at', "datetime default NULL")])

    dump_table(table_info)
  end

  def self.dump_material_items
    table_info = TableInfo.load(<<EOS
CREATE TABLE `material_items` (
  `id` int(11) NOT NULL auto_increment,
  `purchase_order_id` int(11) NOT NULL,
  `vendor_product_id` int(11) NOT NULL,
  `item_price` decimal(10,4) default NULL,
  `item_cost` decimal(10,4) default NULL,
  `quantity` int(11) NOT NULL,
  `usedup` tinyint(1) NOT NULL default '0',
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
EOS
)

    dump_table(table_info)
  end

  def self.dump_measuring_units
    table_info = TableInfo.load(<<EOS
CREATE TABLE `measuring_units` (
  `id` int(11) NOT NULL auto_increment,
  `full_name` varchar(255) default NULL,
  `abbr_name` varchar(255) default NULL,
  `precision` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
EOS
)

    dump_table(table_info)
  end

  def self.dump_purchase_order_items
    table_info =
      TableInfo.new('purchase_order_items',
                    [ColumnInfo.new('id', "int(11) NOT NULL auto_increment"),
                     ColumnInfo.new('purchase_order_id', "int(11) NOT NULL"),
                     ColumnInfo.new('vendor_product_id', "int(11) NOT NULL"),
                     ColumnInfo.new('unit_price', "decimal(10,4) default NULL"),
                     ColumnInfo.new('unit_cost', "decimal(10,4) default NULL"),
                     ColumnInfo.new('quantity', "int(11) NOT NULL"),
                     ColumnInfo.new('created_at', "datetime default NULL"),
                     ColumnInfo.new('updated_at', "datetime default NULL")])

    dump_table(table_info)
  end

  def self.dump_purchase_orders
    table_info =
      TableInfo.new('purchase_orders',
                    [ColumnInfo.new('id', "int(11) NOT NULL auto_increment"),
                     ColumnInfo.new('vendor_id', "int(11) NOT NULL"),
                     ColumnInfo.new('purchased_at', "date NOT NULL"),
                     ColumnInfo.new('arrived_at', "date default NULL"),
                     ColumnInfo.new('postage', "decimal(10,4) default '0.0000'"),
                     ColumnInfo.new('total_cost', "decimal(13,4) default NULL"),
                     ColumnInfo.new('comments', "text"),
                     ColumnInfo.new('created_at', "datetime default NULL"),
                     ColumnInfo.new('updated_at', "datetime default NULL")])

    dump_table(table_info)
  end

  def self.dump_sale_order_items
    table_info =
      TableInfo.new('sale_order_items',
                    [ColumnInfo.new('id', "int(11) NOT NULL auto_increment"),
                     ColumnInfo.new('sale_order_id', "int(11) NOT NULL"),
                     ColumnInfo.new('purchase_order_item_id', "int(11) NOT NULL"),
                     ColumnInfo.new('unit_price', "decimal(10,4) NOT NULL"),
                     ColumnInfo.new('quantity', "int(11) NOT NULL"),
                     ColumnInfo.new('created_at', "datetime default NULL"),
                     ColumnInfo.new('updated_at', "datetime default NULL")])

    dump_table(table_info)
  end

  def self.dump_sale_orders
    table_info =
      TableInfo.new('sale_orders',
                    [ColumnInfo.new('id', "int(11) NOT NULL auto_increment"),
                     ColumnInfo.new('customer_id', "int(11) NOT NULL"),
                     ColumnInfo.new('saled_at', "date NOT NULL"),
                     ColumnInfo.new('postage', "decimal(10,4) NOT NULL default '0.0000'"),
                     ColumnInfo.new('comments', "text"),
                     ColumnInfo.new('created_at', "datetime default NULL"),
                     ColumnInfo.new('updated_at', "datetime default NULL")])

    dump_table(table_info)
  end

  def self.dump_saled_store_product_items
    table_info = TableInfo.load(<<EOS
CREATE TABLE `saled_store_product_items` (
  `id` int(11) NOT NULL auto_increment,
  `sale_order_id` int(11) NOT NULL,
  `store_product_item_id` int(11) NOT NULL,
  `item_price` decimal(10,4) NOT NULL,
  `quantity` int(11) NOT NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
EOS
)

    dump_table(table_info)
  end

  def self.dump_sessions
    template = <<END_OF_TEMPLATE
--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `sessions` (
  `id` int(11) NOT NULL auto_increment,
  `session_id` varchar(255) NOT NULL,
  `data` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_sessions_on_session_id` (`session_id`),
  KEY `index_sessions_on_updated_at` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

END_OF_TEMPLATE

    template
  end

  def self.dump_store_product_items
    table_info = TableInfo.load(<<EOS
CREATE TABLE `store_product_items` (
  `id` int(11) NOT NULL auto_increment,
  `store_product_id` int(11) NOT NULL,
  `produced_at` date default NULL,
  `quantity` int(11) NOT NULL,
  `comments` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
EOS
)

    dump_table(table_info)
  end

  def self.dump_store_products
    table_info = TableInfo.load(<<EOS
CREATE TABLE `store_products` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) NOT NULL,
  `capacity` int(11) default NULL,
  `measuring_unit_id` int(11) default NULL,
  `price` decimal(10,4) default NULL,
  `active` tinyint(1) NOT NULL default '1',
  `description` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
EOS
)

    dump_table(table_info)
  end

  def self.dump_used_material_items
    table_info = TableInfo.load(<<EOS
CREATE TABLE `used_material_items` (
  `id` int(11) NOT NULL auto_increment,
  `material_item_id` int(11) NOT NULL,
  `store_product_item_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
EOS
)

    dump_table(table_info)
  end

  def self.dump_users
    table_info =
      TableInfo.new('users',
                    [ColumnInfo.new('id', "int(11) NOT NULL auto_increment"),
                     ColumnInfo.new('name', "varchar(255) NOT NULL"),
                     ColumnInfo.new('hashed_password', "varchar(255) NOT NULL"),
                     ColumnInfo.new('salt', "varchar(255) NOT NULL"),
                     ColumnInfo.new('created_at', "datetime default NULL"),
                     ColumnInfo.new('updated_at', "datetime default NULL")])

    dump_table(table_info)
  end

  def self.dump_vendor_products
    table_info = TableInfo.load(<<EOS
CREATE TABLE `vendor_products` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) NOT NULL,
  `vendor_id` int(11) NOT NULL,
  `capacity` int(11) default NULL,
  `price` decimal(10,4) default NULL,
  `active` tinyint(1) NOT NULL default '1',
  `description` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `measuring_unit_id` int(11) NOT NULL,
  `material_amount` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=228 DEFAULT CHARSET=utf8;
EOS
)

    dump_table(table_info)
  end

  def self.dump_vendors
    table_info =
      TableInfo.new('vendors',
                    [ColumnInfo.new('id', "int(11) NOT NULL auto_increment"),
                     ColumnInfo.new('full_name', "varchar(255) NOT NULL"),
                     ColumnInfo.new('abbr_name', "varchar(32) NOT NULL"),
                     ColumnInfo.new('currency_id', "int(11) NOT NULL"),
                     ColumnInfo.new('active', "tinyint(1) NOT NULL default '1'"),
                     ColumnInfo.new('created_at', "datetime default NULL"),
                     ColumnInfo.new('updated_at', "datetime default NULL")])

    dump_table(table_info)
  end

  def self.dump_tailer
    template = <<END_OF_TEMPLATE
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on <%= Time.now %>
END_OF_TEMPLATE

    ERB.new(template, 0, "%<>").result
  end

  def self.dump_table(table)
    dump_table_structure(table) + dump_table_data(table)
  end

  def self.dump_table_structure(table)
    template = <<END_OF_TEMPLATE
--
-- Table structure for table `<%= table.name %>`
--

<% records = const_get(table.name.singularize.camelize).find(:all, :order => 'id') %>

DROP TABLE IF EXISTS `<%= table.name %>`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `<%= table.name %>` (
<% for column in table.columns %>
  `<%= column.name %>` <%= column.config %>,
<% end %>
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=<%= records.last.id + 1 %> DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

END_OF_TEMPLATE

    ERB.new(template, 0, "%<>").result(binding)
  end

  def self.dump_table_data(table)
    template = <<END_OF_TEMPLATE
--
-- Dumping data for table `<%= table.name %>`
--

<% records = const_get(table.name.singularize.camelize).find(:all, :order => 'id') %>
LOCK TABLES `<%= table.name %>` WRITE;
/*!40000 ALTER TABLE `<%= table.name %>` DISABLE KEYS */;
<% if records.size > 0 %>
INSERT INTO `<%= table.name %>` VALUES <% records.each_with_index do |r, i| %>
(<% table.columns.each_with_index do |c_info, j| %>
<%= dump_column_value(r, c_info) %><%= j != table.columns.size - 1 ? "," : "" %><% end %>)<%= i == records.size - 1 ? ';' : ',' %>
<% end %>
<% end %>

/*!40000 ALTER TABLE `<%= table.name %>` ENABLE KEYS */;
UNLOCK TABLES;

END_OF_TEMPLATE

    ERB.new(template, 0, ">").result(binding)
  end

  def self.dump_column_value(record, column_info)
    value = record.send column_info.name
    case column_info.config
    when /^int/:       value.nil? ? "NULL" : value.to_i
    when /^decimal/:   value.nil? ? "NULL" : "'%.4f'" % value
    when /^varchar/:   value.nil? ? "NULL" : "'#{value}'"
    when /^text/:      value.nil? ? "NULL" : value.blank? ? "''" : value.inspect
    when /^tinyint/:   value.nil? ? "NULL" : value ? 1 : 0
    when /^date /:     value.nil? ? "NULL" : "'#{value}'"
    when /^datetime /: value.nil? ? "NULL" : "'#{value}'"
    else raise RuntimeError, "Unkown column type in #{column_info.config}"
    end
  end
end
