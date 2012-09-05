/*# Test import into Magento 11/04/2011
# ---------------------------------------
# Host     : test.excessequip.com
# Port     : 3306
# Database : excesse1_magento */

USING KW_EMIT
SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";



DROP TABLE IF EXISTS admin_assert;

CREATE TABLE `admin_assert` (
  `assert_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `assert_type` varchar(20) NOT NULL DEFAULT '',
  `assert_data` text,
  PRIMARY KEY (`assert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ACL Asserts';


DROP TABLE IF EXISTS admin_role;

CREATE TABLE `admin_role` (
  `role_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0',
  `tree_level` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `sort_order` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `role_type` char(1) NOT NULL DEFAULT '0',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0',
  `role_name` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`role_id`),
  KEY `parent_id` (`parent_id`,`sort_order`),
  KEY `tree_level` (`tree_level`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='ACL Roles';

INSERT INTO admin_role ( `role_id`, `parent_id`, `tree_level`, `sort_order`, `role_type`, `user_id`, `role_name`)
VALUES ('1', '0', '1', '1', 'G', '0', 'Administrators'),
('3', '1', '2', '0', 'U', '1', 'admin');

DROP TABLE IF EXISTS admin_rule;

CREATE TABLE `admin_rule` (
  `rule_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(10) unsigned NOT NULL DEFAULT '0',
  `resource_id` varchar(255) NOT NULL DEFAULT '',
  `privileges` varchar(20) NOT NULL DEFAULT '',
  `assert_id` int(10) unsigned NOT NULL DEFAULT '0',
  `role_type` char(1) DEFAULT NULL,
  `permission` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`rule_id`),
  KEY `resource` (`resource_id`,`role_id`),
  KEY `role_id` (`role_id`,`resource_id`),
  CONSTRAINT `FK_admin_rule` FOREIGN KEY (`role_id`) REFERENCES `admin_role` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='ACL Rules';

INSERT INTO admin_rule ( `rule_id`, `role_id`, `resource_id`, `privileges`, `assert_id`, `role_type`, `permission`)
VALUES ('1', '1', 'all', '', '0', 'G', 'allow');

DROP TABLE IF EXISTS admin_user;

CREATE TABLE `admin_user` (
  `user_id` mediumint(9) unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(32) NOT NULL DEFAULT '',
  `lastname` varchar(32) NOT NULL DEFAULT '',
  `email` varchar(128) NOT NULL DEFAULT '',
  `username` varchar(40) NOT NULL DEFAULT '',
  `password` varchar(40) NOT NULL DEFAULT '',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified` datetime DEFAULT NULL,
  `logdate` datetime DEFAULT NULL,
  `lognum` smallint(5) unsigned NOT NULL DEFAULT '0',
  `reload_acl_flag` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `extra` text,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `UNQ_ADMIN_USER_USERNAME` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Users';