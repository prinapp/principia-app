-- phpMyAdmin SQL Dump
-- version 2.11.11.3
-- http://www.phpmyadmin.net
--
-- Host: 50.63.231.51
-- Generation Time: May 03, 2013 at 08:22 AM
-- Server version: 5.0.96
-- PHP Version: 5.1.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `prinappdata`
--

-- --------------------------------------------------------

--
-- Table structure for table `menu1_T`
--

CREATE TABLE `menu1_T` (
  `food_id` int(11) NOT NULL auto_increment,
  `date` date NOT NULL,
  `mealtype` varchar(3) NOT NULL,
  `mealname` text NOT NULL,
  PRIMARY KEY  (`food_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=152 ;

--
-- Dumping data for table `menu1_T`
--

INSERT INTO `menu1_T` VALUES(1, '2013-04-28', 'BRK', 'Chefs Choice');
INSERT INTO `menu1_T` VALUES(2, '2013-04-29', 'BRK', 'Cinnamon Rolls');
INSERT INTO `menu1_T` VALUES(3, '2013-04-30', 'BRK', 'Cheese Omelette');
INSERT INTO `menu1_T` VALUES(4, '2013-05-01', 'BRK', 'Breakfast Smoothie');
INSERT INTO `menu1_T` VALUES(5, '2013-05-02', 'BRK', 'Eggs Benedict Meat');
INSERT INTO `menu1_T` VALUES(6, '2013-05-03', 'BRK', 'Breakfast Bacon');
INSERT INTO `menu1_T` VALUES(7, '2013-05-04', 'BRK', 'Scrambled Eggs Elsah');
INSERT INTO `menu1_T` VALUES(8, '2013-04-29', 'BRK', 'Scrambled Eggs Elsah');
INSERT INTO `menu1_T` VALUES(9, '2013-04-30', 'BRK', 'Breakfast Bacon');
INSERT INTO `menu1_T` VALUES(10, '2013-05-01', 'BRK', 'Cottage Fries');
INSERT INTO `menu1_T` VALUES(11, '2013-05-02', 'BRK', 'Eggs Benedict Veggie');
INSERT INTO `menu1_T` VALUES(12, '2013-05-03', 'BRK', 'Texas Toast');
INSERT INTO `menu1_T` VALUES(13, '2013-05-04', 'BRK', 'Pancakes St.Louis');
INSERT INTO `menu1_T` VALUES(14, '2013-04-29', 'BRK', 'Sausage Link Elsah');
INSERT INTO `menu1_T` VALUES(15, '2013-04-30', 'BRK', 'Sausage Gravy');
INSERT INTO `menu1_T` VALUES(16, '2013-05-01', 'BRK', 'Pepper Jack Cheese');
INSERT INTO `menu1_T` VALUES(17, '2013-05-02', 'BRK', 'Sausage Patties');
INSERT INTO `menu1_T` VALUES(18, '2013-05-03', 'BRK', 'Hashbrown Patties');
INSERT INTO `menu1_T` VALUES(19, '2013-05-04', 'BRK', 'Sausage Link Elsah');
INSERT INTO `menu1_T` VALUES(20, '2013-04-29', 'BRK', 'Breakfast Bacon');
INSERT INTO `menu1_T` VALUES(21, '2013-04-30', 'BRK', 'Milk Gravy');
INSERT INTO `menu1_T` VALUES(22, '2013-05-01', 'BRK', 'Scrambled Eggs Elsah');
INSERT INTO `menu1_T` VALUES(23, '2013-05-02', 'BRK', 'Breakfast Bacon');
INSERT INTO `menu1_T` VALUES(24, '2013-05-03', 'BRK', 'Eggs McPrin Meat,C');
INSERT INTO `menu1_T` VALUES(25, '2013-05-04', 'BRK', 'Breakfast Bacon');
INSERT INTO `menu1_T` VALUES(26, '2013-04-29', 'BRK', 'Pancakes St.Louis');
INSERT INTO `menu1_T` VALUES(27, '2013-04-30', 'BRK', 'Muffin, Asst Base');
INSERT INTO `menu1_T` VALUES(28, '2013-05-01', 'BRK', 'Breakfast Burrito');
INSERT INTO `menu1_T` VALUES(29, '2013-05-02', 'BRK', 'Muffin, Asst Base');
INSERT INTO `menu1_T` VALUES(30, '2013-05-03', 'BRK', 'Eggs McPrin Veggie,C');
INSERT INTO `menu1_T` VALUES(31, '2013-04-29', 'BRK', 'Butter,Map,Blue');
INSERT INTO `menu1_T` VALUES(32, '2013-04-30', 'BRK', 'Biscuits');
INSERT INTO `menu1_T` VALUES(33, '2013-05-01', 'BRK', 'Jewish Coffee Cake');
INSERT INTO `menu1_T` VALUES(34, '2013-05-02', 'BRK', 'Hashbrown Shredded');
INSERT INTO `menu1_T` VALUES(35, '2013-05-03', 'BRK', 'Donut');
INSERT INTO `menu1_T` VALUES(36, '2013-05-01', 'BRK', 'Burrito Breakfast');
INSERT INTO `menu1_T` VALUES(37, '2013-04-28', 'LUN', 'Steak Au Pouive');
INSERT INTO `menu1_T` VALUES(38, '2013-04-29', 'LUN', 'Flatz, Buffalo Chic');
INSERT INTO `menu1_T` VALUES(39, '2013-04-30', 'LUN', 'Mu shu veggies');
INSERT INTO `menu1_T` VALUES(40, '2013-05-01', 'LUN', 'Sandwich melt Eggpla');
INSERT INTO `menu1_T` VALUES(41, '2013-05-02', 'LUN', 'Sandwich French Ham');
INSERT INTO `menu1_T` VALUES(42, '2013-05-03', 'LUN', 'Wings of Fire');
INSERT INTO `menu1_T` VALUES(43, '2013-05-04', 'LUN', 'Bean & Cheese Burrit');
INSERT INTO `menu1_T` VALUES(44, '2013-04-28', 'LUN', 'Baked Chicken Breast');
INSERT INTO `menu1_T` VALUES(45, '2013-04-29', 'LUN', 'Pork Tenderloin');
INSERT INTO `menu1_T` VALUES(46, '2013-04-30', 'LUN', 'Reuben Sandwich');
INSERT INTO `menu1_T` VALUES(47, '2013-05-01', 'LUN', 'Muffalatta Sandwich');
INSERT INTO `menu1_T` VALUES(48, '2013-05-02', 'LUN', 'Bosco Cheese Pizza');
INSERT INTO `menu1_T` VALUES(49, '2013-05-03', 'LUN', 'Turk-E-Burger');
INSERT INTO `menu1_T` VALUES(50, '2013-05-04', 'LUN', 'Chimichangas');
INSERT INTO `menu1_T` VALUES(51, '2013-04-28', 'LUN', 'Penne w/ Rstd Bnt Sq');
INSERT INTO `menu1_T` VALUES(52, '2013-04-29', 'LUN', 'Egg Salad');
INSERT INTO `menu1_T` VALUES(53, '2013-04-30', 'LUN', 'Turkey Sandwich');
INSERT INTO `menu1_T` VALUES(54, '2013-05-01', 'LUN', 'Roast Turkey');
INSERT INTO `menu1_T` VALUES(55, '2013-05-02', 'LUN', 'Pizza Pepperoni');
INSERT INTO `menu1_T` VALUES(56, '2013-05-03', 'LUN', 'Spicy Black Bean');
INSERT INTO `menu1_T` VALUES(57, '2013-05-04', 'LUN', 'Crispitos Spicy');
INSERT INTO `menu1_T` VALUES(58, '2013-04-28', 'LUN', 'Mashed Potatoes');
INSERT INTO `menu1_T` VALUES(59, '2013-04-29', 'LUN', 'Fries Crinkle Cut');
INSERT INTO `menu1_T` VALUES(60, '2013-04-30', 'LUN', 'Fries Crinkle Cut');
INSERT INTO `menu1_T` VALUES(61, '2013-05-01', 'LUN', 'Mashed Potatoes');
INSERT INTO `menu1_T` VALUES(62, '2013-05-02', 'LUN', 'Curry Rice');
INSERT INTO `menu1_T` VALUES(63, '2013-05-03', 'LUN', 'Burger Garnish');
INSERT INTO `menu1_T` VALUES(64, '2013-05-04', 'LUN', 'Apple Crispitos');
INSERT INTO `menu1_T` VALUES(65, '2013-04-28', 'LUN', 'Meat Gravy');
INSERT INTO `menu1_T` VALUES(66, '2013-04-29', 'LUN', 'Corn Nuggets');
INSERT INTO `menu1_T` VALUES(67, '2013-04-30', 'LUN', 'Wax Beans');
INSERT INTO `menu1_T` VALUES(68, '2013-05-01', 'LUN', 'Meat Gravy');
INSERT INTO `menu1_T` VALUES(69, '2013-05-02', 'LUN', 'Country Blend Veggie');
INSERT INTO `menu1_T` VALUES(70, '2013-05-03', 'LUN', 'Curley Fries');
INSERT INTO `menu1_T` VALUES(71, '2013-05-04', 'LUN', 'Pepper Jack Cheese');
INSERT INTO `menu1_T` VALUES(72, '2013-04-28', 'LUN', 'Vegetable Gravy');
INSERT INTO `menu1_T` VALUES(73, '2013-04-29', 'LUN', 'Green Beans');
INSERT INTO `menu1_T` VALUES(74, '2013-04-30', 'LUN', 'Scandinavian Mix');
INSERT INTO `menu1_T` VALUES(75, '2013-05-01', 'LUN', 'Vegetable Gravy');
INSERT INTO `menu1_T` VALUES(76, '2013-05-02', 'LUN', 'Brussels Sprouts');
INSERT INTO `menu1_T` VALUES(77, '2013-05-03', 'LUN', 'Vegetable Summer');
INSERT INTO `menu1_T` VALUES(78, '2013-05-04', 'LUN', 'Fresh Corn Chips');
INSERT INTO `menu1_T` VALUES(79, '2013-04-28', 'LUN', 'Peas');
INSERT INTO `menu1_T` VALUES(80, '2013-04-29', 'LUN', 'Tomato Basil Bisque');
INSERT INTO `menu1_T` VALUES(81, '2013-04-30', 'LUN', 'Carrot Ginger Soup');
INSERT INTO `menu1_T` VALUES(82, '2013-05-01', 'LUN', 'Peas');
INSERT INTO `menu1_T` VALUES(83, '2013-05-02', 'LUN', 'Soup butternut with');
INSERT INTO `menu1_T` VALUES(84, '2013-05-03', 'LUN', 'Walk About Soup');
INSERT INTO `menu1_T` VALUES(85, '2013-05-04', 'LUN', 'Friojoles');
INSERT INTO `menu1_T` VALUES(86, '2013-04-28', 'LUN', 'Corn');
INSERT INTO `menu1_T` VALUES(87, '2013-04-29', 'LUN', 'Soup,Spinach & Feta');
INSERT INTO `menu1_T` VALUES(88, '2013-04-30', 'LUN', 'Split Pea W/Ham Soup');
INSERT INTO `menu1_T` VALUES(89, '2013-05-01', 'LUN', 'Chefs Choice');
INSERT INTO `menu1_T` VALUES(90, '2013-05-02', 'LUN', 'French Onion Soup');
INSERT INTO `menu1_T` VALUES(91, '2013-05-03', 'LUN', 'Chefs Choice');
INSERT INTO `menu1_T` VALUES(92, '2013-05-04', 'LUN', 'Potato Chowder Soup');
INSERT INTO `menu1_T` VALUES(93, '2013-04-28', 'LUN', 'Clam Chowder Soup');
INSERT INTO `menu1_T` VALUES(94, '2013-04-29', 'LUN', 'Chill Grill Chicken');
INSERT INTO `menu1_T` VALUES(95, '2013-04-30', 'LUN', 'Chill Grill Chicken');
INSERT INTO `menu1_T` VALUES(96, '2013-05-01', 'LUN', 'Vegetarian Vegetable');
INSERT INTO `menu1_T` VALUES(97, '2013-05-02', 'LUN', 'Chill Grill Chicken');
INSERT INTO `menu1_T` VALUES(98, '2013-05-03', 'LUN', 'Chill Grill Chicken');
INSERT INTO `menu1_T` VALUES(99, '2013-05-01', 'LUN', 'Kansas City Steak');
INSERT INTO `menu1_T` VALUES(100, '2013-05-01', 'LUN', 'Chill Grill Chicken');
INSERT INTO `menu1_T` VALUES(101, '2013-04-28', 'DIN', 'Chicken Less Pattie');
INSERT INTO `menu1_T` VALUES(102, '2013-04-29', 'DIN', 'Brisket of Beef');
INSERT INTO `menu1_T` VALUES(103, '2013-04-30', 'DIN', 'Grilled Chicken');
INSERT INTO `menu1_T` VALUES(104, '2013-05-01', 'DIN', 'Tempura Cod');
INSERT INTO `menu1_T` VALUES(105, '2013-05-02', 'DIN', 'Pork and Green Chili');
INSERT INTO `menu1_T` VALUES(106, '2013-05-03', 'DIN', 'Wrap Station');
INSERT INTO `menu1_T` VALUES(107, '2013-05-04', 'DIN', 'London Broil');
INSERT INTO `menu1_T` VALUES(108, '2013-04-28', 'DIN', 'Chicken Pattie');
INSERT INTO `menu1_T` VALUES(109, '2013-04-29', 'DIN', 'Spinach Quiche');
INSERT INTO `menu1_T` VALUES(110, '2013-04-30', 'DIN', 'Tortellini Cheese');
INSERT INTO `menu1_T` VALUES(111, '2013-05-01', 'DIN', 'Japanese Noodle Bowl');
INSERT INTO `menu1_T` VALUES(112, '2013-05-02', 'DIN', 'Chicken Strips');
INSERT INTO `menu1_T` VALUES(113, '2013-05-03', 'DIN', 'Bayou Chicken');
INSERT INTO `menu1_T` VALUES(114, '2013-05-04', 'DIN', 'Eggplant bites');
INSERT INTO `menu1_T` VALUES(115, '2013-04-28', 'DIN', 'Chefs Choice');
INSERT INTO `menu1_T` VALUES(116, '2013-04-29', 'DIN', 'Ham & Cheese Quiche');
INSERT INTO `menu1_T` VALUES(117, '2013-04-30', 'DIN', 'Tortellini Meat');
INSERT INTO `menu1_T` VALUES(118, '2013-05-01', 'DIN', 'Teriyaki Chicken');
INSERT INTO `menu1_T` VALUES(119, '2013-05-02', 'DIN', 'Chicken Less Nuggets');
INSERT INTO `menu1_T` VALUES(120, '2013-05-03', 'DIN', 'Tofu Marinade spicy');
INSERT INTO `menu1_T` VALUES(121, '2013-05-04', 'DIN', 'Chefs Choice');
INSERT INTO `menu1_T` VALUES(122, '2013-04-28', 'DIN', 'Tator Tots');
INSERT INTO `menu1_T` VALUES(123, '2013-04-29', 'DIN', 'Fries Steak');
INSERT INTO `menu1_T` VALUES(124, '2013-04-30', 'DIN', 'Parsiled Potatoes');
INSERT INTO `menu1_T` VALUES(125, '2013-05-01', 'DIN', 'Jasmine Rice');
INSERT INTO `menu1_T` VALUES(126, '2013-05-02', 'DIN', 'Mac and Cheese');
INSERT INTO `menu1_T` VALUES(127, '2013-05-03', 'DIN', 'Fresh Chips');
INSERT INTO `menu1_T` VALUES(128, '2013-05-04', 'DIN', 'Roasted Potatoes');
INSERT INTO `menu1_T` VALUES(129, '2013-04-28', 'DIN', 'Burger Garnish');
INSERT INTO `menu1_T` VALUES(130, '2013-04-29', 'DIN', 'Corn on the Cobb');
INSERT INTO `menu1_T` VALUES(131, '2013-04-30', 'DIN', 'Broccoli Floretts');
INSERT INTO `menu1_T` VALUES(132, '2013-05-01', 'DIN', 'Fresh Carrots');
INSERT INTO `menu1_T` VALUES(133, '2013-05-02', 'DIN', 'Chefs Choice');
INSERT INTO `menu1_T` VALUES(134, '2013-05-03', 'DIN', 'Fresh Carrots');
INSERT INTO `menu1_T` VALUES(135, '2013-05-04', 'DIN', 'San Fran Blend');
INSERT INTO `menu1_T` VALUES(136, '2013-04-28', 'DIN', 'Capri Blend Veggies');
INSERT INTO `menu1_T` VALUES(137, '2013-04-29', 'DIN', 'Baked Beans Elsah');
INSERT INTO `menu1_T` VALUES(138, '2013-04-30', 'DIN', 'Cheese Sauce');
INSERT INTO `menu1_T` VALUES(139, '2013-05-01', 'DIN', 'Chefs Choice');
INSERT INTO `menu1_T` VALUES(140, '2013-05-02', 'DIN', 'Corn');
INSERT INTO `menu1_T` VALUES(141, '2013-05-03', 'DIN', 'Chefs Choice');
INSERT INTO `menu1_T` VALUES(142, '2013-05-04', 'DIN', 'Mixed Vegetable');
INSERT INTO `menu1_T` VALUES(143, '2013-04-28', 'DIN', 'Chill Grill Chicken');
INSERT INTO `menu1_T` VALUES(144, '2013-04-29', 'DIN', 'Corn Muffin');
INSERT INTO `menu1_T` VALUES(145, '2013-04-30', 'DIN', 'Garlic Toast');
INSERT INTO `menu1_T` VALUES(146, '2013-05-01', 'DIN', 'Chill Grill Chicken');
INSERT INTO `menu1_T` VALUES(147, '2013-05-02', 'DIN', 'Chefs Choice');
INSERT INTO `menu1_T` VALUES(148, '2013-05-03', 'DIN', 'Chill Grill Chicken');
INSERT INTO `menu1_T` VALUES(149, '2013-04-29', 'DIN', 'Chill Grill Chicken');
INSERT INTO `menu1_T` VALUES(150, '2013-04-30', 'DIN', 'Chill Grill Chicken');
INSERT INTO `menu1_T` VALUES(151, '2013-05-02', 'DIN', 'Chill Grill Chicken');
