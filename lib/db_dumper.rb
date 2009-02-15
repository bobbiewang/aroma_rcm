require 'erb'

module DbDumper
  def self.to_mysql
    dump_header + dump_currencies + dump_customers + dump_purchase_order_items +
      dump_purchase_order + dump_sale_order_items + dump_sale_order +
      dump_sessions + dump_users + dump_vendor_products + dump_vendors +
      dump_tailer
  end

  def self.dump_header
    template = <<END_OF_TEMPLATE
--
-- Database:
--

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- CREATE DATABASE `iclinic_development` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE 'iclinic_development';

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
    template = <<END_OF_TEMPLATE
--
-- Table structure for table `<%= table %>`
--

<% records = const_get(table.singularize.camelize).find(:all, :order => 'id') %>

DROP TABLE IF EXISTS `<%= table %>`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `<%= table %>` (
  `id` int(11) NOT NULL auto_increment,
  `full_name` varchar(255) NOT NULL,
  `iso_code` varchar(255) NOT NULL,
  `symbol` varchar(255) NOT NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=<%= records.size + 1 %> DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `<%= table %>`
--

LOCK TABLES `<%= table %>` WRITE;
/*!40000 ALTER TABLE `<%= table %>` DISABLE KEYS */;
<% if records.size > 0 %>
INSERT INTO `<%= table %>` VALUES
<% records.each_with_index do |r, i| %>
(<%= r.id %>, '<%= r.full_name %>', '<%= r.iso_code %>', '<%= r.symbol %>', '<%= r.created_at %>', '<%= r.updated_at %>')<%= i == records.size - 1 ? ';' : ',' %>
<% end %>
<% end %>
/*!40000 ALTER TABLE `<%= table %>` ENABLE KEYS */;
UNLOCK TABLES;

END_OF_TEMPLATE

    table = "currencies"
    ERB.new(template, 0, "%<>").result(binding)
  end

  def self.dump_customers
    template = <<END_OF_TEMPLATE
--
-- Table structure for table `<%= table %>`
--

<% records = const_get(table.singularize.camelize).find(:all, :order => 'id') %>

DROP TABLE IF EXISTS `<%= table %>`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `<%= table %>` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `gender` varchar(255) default NULL,
  `address` varchar(255) default NULL,
  `post_code` varchar(255) default NULL,
  `telephone` varchar(255) default NULL,
  `mobilephone` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  `wangwang` varchar(255) default NULL,
  `qq` varchar(255) default NULL,
  `msn` varchar(255) default NULL,
  `birthday` date default NULL,
  `details` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=<%= records.size + 1 %> DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `<%= table %>`
--

LOCK TABLES `<%= table %>` WRITE;
/*!40000 ALTER TABLE `<%= table %>` DISABLE KEYS */;
<% if records.size > 0 %>
INSERT INTO `<%= table %>` VALUES
<% records.each_with_index do |r, i| %>
(<%= r.id %>, '<%= r.name %>', '<%= r.gender %>', '<%= r.address %>', '<%= r.post_code %>', '<%= r.telephone %>', '<%= r.mobilephone %>', '<%= r.email %>', '<%= r.wangwang %>', '<%= r.qq %>', '<%= r.msn %>', '<%= r.birthday %>', <%= r.details.inspect %>, '<%= r.created_at %>', '<%= r.updated_at %>')<%= i == records.size - 1 ? ';' : ',' %>
<% end %>
<% end %>
/*!40000 ALTER TABLE `<%= table %>` ENABLE KEYS */;
UNLOCK TABLES;

END_OF_TEMPLATE

    table = "customers"
    ERB.new(template, 0, "%<>").result(binding)
  end

  def self.dump_purchase_order_items
    template = <<END_OF_TEMPLATE
--
-- Table structure for table `<%= table %>`
--

<% records = const_get(table.singularize.camelize).find(:all, :order => 'id') %>

DROP TABLE IF EXISTS `<%= table %>`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `<%= table %>` (
  `id` int(11) NOT NULL auto_increment,
  `purchase_order_id` int(11) NOT NULL,
  `vendor_product_id` int(11) NOT NULL,
  `unit_price` decimal(10,4) default NULL,
  `unit_cost` decimal(10,4) default NULL,
  `ml_cost` decimal(10,4) default NULL,
  `drop_cost` decimal(10,4) default NULL,
  `quantity` int(11) NOT NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=<%= records.size + 1 %> DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `<%= table %>`
--

LOCK TABLES `<%= table %>` WRITE;
/*!40000 ALTER TABLE `<%= table %>` DISABLE KEYS */;
<% if records.size > 0 %>
INSERT INTO `<%= table %>` VALUES
<% records.each_with_index do |r, i| %>
(<%= r.id %>, '<%= r.purchase_order_id %>', '<%= r.vendor_product_id %>', '<%= r.unit_price %>', '<%= r.unit_cost %>', '<%= r.ml_cost %>', '<%= r.drop_cost %>', <%= r.quantity %>, '<%= r.created_at %>', '<%= r.updated_at %>')<%= i == records.size - 1 ? ';' : ',' %>
<% end %>
<% end %>
/*!40000 ALTER TABLE `<%= table %>` ENABLE KEYS */;
UNLOCK TABLES;

END_OF_TEMPLATE

    table = "purchase_order_items"
    ERB.new(template, 0, "%<>").result(binding)
  end

  def self.dump_purchase_order
    template = <<END_OF_TEMPLATE
--
-- Table structure for table `<%= table %>`
--

<% records = const_get(table.singularize.camelize).find(:all, :order => 'id') %>

DROP TABLE IF EXISTS `<%= table %>`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `<%= table %>` (
  `id` int(11) NOT NULL auto_increment,
  `vendor_id` int(11) NOT NULL,
  `purchased_at` date NOT NULL,
  `arrived_at` date default NULL,
  `postage` decimal(10,4) default '0.0000',
  `total_cost` decimal(13,4) default NULL,
  `comments` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)

) ENGINE=InnoDB AUTO_INCREMENT=<%= records.size + 1 %> DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `<%= table %>`
--

LOCK TABLES `<%= table %>` WRITE;
/*!40000 ALTER TABLE `<%= table %>` DISABLE KEYS */;
<% if records.size > 0 %>
INSERT INTO `<%= table %>` VALUES
<% records.each_with_index do |r, i| %>
(<%= r.id %>, '<%= r.vendor_id %>', '<%= r.purchased_at %>', '<%= r.arrived_at %>', '<%= r.postage %>', '<%= r.total_cost %>', <%= r.comments.inspect %>, '<%= r.created_at %>', '<%= r.updated_at %>')<%= i == records.size - 1 ? ';' : ',' %>
<% end %>
<% end %>
/*!40000 ALTER TABLE `<%= table %>` ENABLE KEYS */;
UNLOCK TABLES;

END_OF_TEMPLATE

    table = "purchase_orders"
    ERB.new(template, 0, "%<>").result(binding)
  end

  def self.dump_sale_order_items
    template = <<END_OF_TEMPLATE
--
-- Table structure for table `<%= table %>`
--

<% records = const_get(table.singularize.camelize).find(:all, :order => 'id') %>

DROP TABLE IF EXISTS `<%= table %>`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `<%= table %>` (
  `id` int(11) NOT NULL auto_increment,
  `sale_order_id` int(11) NOT NULL,
  `purchase_order_item_id` int(11) NOT NULL,
  `unit_cost` decimal(10,4) NOT NULL,
  `unit_price` decimal(10,4) NOT NULL,
  `quantity` int(11) NOT NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=<%= records.size + 1 %> DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `<%= table %>`
--

LOCK TABLES `<%= table %>` WRITE;
/*!40000 ALTER TABLE `<%= table %>` DISABLE KEYS */;
<% if records.size > 0 %>
INSERT INTO `<%= table %>` VALUES
<% records.each_with_index do |r, i| %>
(<%= r.id %>, '<%= r.sale_order_id %>', '<%= r.purchase_order_item_id %>', '<%= r.unit_cost %>', '<%= r.unit_price %>', <%= r.quantity %>, '<%= r.created_at %>', '<%= r.updated_at %>')<%= i == records.size - 1 ? ';' : ',' %>
<% end %>
<% end %>
/*!40000 ALTER TABLE `<%= table %>` ENABLE KEYS */;
UNLOCK TABLES;

END_OF_TEMPLATE

    table = "sale_order_items"
    ERB.new(template, 0, "%<>").result(binding)
  end

  def self.dump_sale_order
    template = <<END_OF_TEMPLATE
--
-- Table structure for table `<%= table %>`
--

<% records = const_get(table.singularize.camelize).find(:all, :order => 'id') %>

DROP TABLE IF EXISTS `<%= table %>`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `<%= table %>` (
  `id` int(11) NOT NULL auto_increment,
  `customer_id` int(11) NOT NULL,
  `saled_at` date NOT NULL,
  `postage` decimal(10,4) NOT NULL default '0.0000',
  `comments` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=<%= records.size + 1 %> DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `<%= table %>`
--

LOCK TABLES `<%= table %>` WRITE;
/*!40000 ALTER TABLE `<%= table %>` DISABLE KEYS */;
<% if records.size > 0 %>
INSERT INTO `<%= table %>` VALUES
<% records.each_with_index do |r, i| %>
(<%= r.id %>, '<%= r.customer_id %>', '<%= r.saled_at %>', '<%= r.postage %>', <%= r.comments.inspect %>, '<%= r.created_at %>', '<%= r.updated_at %>')<%= i == records.size - 1 ? ';' : ',' %>
<% end %>
<% end %>
/*!40000 ALTER TABLE `<%= table %>` ENABLE KEYS */;
UNLOCK TABLES;

END_OF_TEMPLATE

    table = "sale_orders"
    ERB.new(template, 0, "%<>").result(binding)
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

  def self.dump_users
    template = <<END_OF_TEMPLATE
--
-- Table structure for table `<%= table %>`
--

<% records = const_get(table.singularize.camelize).find(:all, :order => 'id') %>

DROP TABLE IF EXISTS `<%= table %>`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `<%= table %>` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `hashed_password` varchar(255) NOT NULL,
  `salt` varchar(255) NOT NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=<%= records.size + 1 %> DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `<%= table %>`
--

LOCK TABLES `<%= table %>` WRITE;
/*!40000 ALTER TABLE `<%= table %>` DISABLE KEYS */;
<% if records.size > 0 %>
INSERT INTO `<%= table %>` VALUES
<% records.each_with_index do |r, i| %>
(<%= r.id %>, '<%= r.name %>', '<%= r.hashed_password %>', '<%= r.salt %>', '<%= r.created_at %>', '<%= r.updated_at %>')<%= i == records.size - 1 ? ';' : ',' %>
<% end %>
<% end %>
/*!40000 ALTER TABLE `<%= table %>` ENABLE KEYS */;
UNLOCK TABLES;

END_OF_TEMPLATE

    table = "users"
    ERB.new(template, 0, "%<>").result(binding)
  end

  def self.dump_vendor_products
    template = <<END_OF_TEMPLATE
--
-- Table structure for table `<%= table %>`
--

<% records = const_get(table.singularize.camelize).find(:all, :order => 'id') %>

DROP TABLE IF EXISTS `<%= table %>`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `<%= table %>` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) NOT NULL,
  `vendor_id` int(11) NOT NULL,
  `capacity` int(11) default NULL,
  `price` decimal(10,4) default NULL,
  `active` tinyint(1) NOT NULL default '1',
  `description` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=<%= records.size + 1 %> DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `<%= table %>`
--

LOCK TABLES `<%= table %>` WRITE;
/*!40000 ALTER TABLE `<%= table %>` DISABLE KEYS */;
<% if records.size > 0 %>
INSERT INTO `<%= table %>` VALUES
<% records.each_with_index do |r, i| %>
(<%= r.id %>, '<%= r.title %>', <%= r.vendor_id %>, <%= r.capacity.nil? ? "NULL" : r.capacity %>, '<%= r.price %>', <%= r.active? ? 1 : 0 %>, <%= r.description.nil? ? "NULL" : r.description.inspect %>, '<%= r.created_at %>', '<%= r.updated_at %>')<%= i == records.size - 1 ? ';' : ',' %>
<% end %>
<% end %>
/*!40000 ALTER TABLE `<%= table %>` ENABLE KEYS */;
UNLOCK TABLES;

END_OF_TEMPLATE

    table = "vendor_products"
    ERB.new(template, 0, "%<>").result(binding)
  end

  def self.dump_vendors
    template = <<END_OF_TEMPLATE
--
-- Table structure for table `<%= table %>`
--

<% records = const_get(table.singularize.camelize).find(:all, :order => 'id') %>

DROP TABLE IF EXISTS `<%= table %>`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `<%= table %>` (
  `id` int(11) NOT NULL auto_increment,
  `full_name` varchar(255) NOT NULL,
  `abbr_name` varchar(32) NOT NULL,
  `currency_id` int(11) NOT NULL,
  `active` tinyint(1) NOT NULL default '1',
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=<%= records.size + 1 %> DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `<%= table %>`
--

LOCK TABLES `<%= table %>` WRITE;
/*!40000 ALTER TABLE `<%= table %>` DISABLE KEYS */;
<% if records.size > 0 %>
INSERT INTO `<%= table %>` VALUES
<% records.each_with_index do |r, i| %>
(<%= r.id %>, '<%= r.full_name %>', '<%= r.abbr_name %>', <%= r.currency_id %>, <%= r.active? ? 1 : 0 %>, '<%= r.created_at %>', '<%= r.updated_at %>')<%= i == records.size - 1 ? ';' : ',' %>
<% end %>
<% end %>
/*!40000 ALTER TABLE `<%= table %>` ENABLE KEYS */;
UNLOCK TABLES;

END_OF_TEMPLATE

    table = "vendors"
    ERB.new(template, 0, "%<>").result(binding)
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
end
