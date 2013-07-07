<?php
ini_set('display_errors', 'On');
error_reporting(E_ALL|E_STRICT);

include 'Global.php';
$DBConn = GetConn();
header("Content-Type: text/plain");
mysql_select_db("prinappdata",$DBConn);

$result = mysql_query("SELECT * FROM `menu1_T` ORDER BY `menu1_T`.`date` ASC");

$doc = new DOMDocument();
$root = $doc->createElement("MealInfo");
$root = $doc->appendChild($root);


while($row = mysql_fetch_array($result))
{
	$Meald = $doc->createElement("Description");
	$MealdTag = $root->appendChild($Meald);
	$MealdTag->appendChild($doc->createElement("Date",htmlentities($row['date'])));
	if(preg_match('/BRK/',$row['mealtype']))
	$MealdTag->appendChild($doc->createElement("Type",htmlentities('Breakfast')));

	if(preg_match('/LUN/',$row['mealtype']))
	$MealdTag->appendChild($doc->createElement("Type",htmlentities('Lunch')));
	
	if(preg_match('/DIN/',$row['mealtype']))
	$MealdTag->appendChild($doc->createElement("Type",htmlentities('Dinner')));

	$MealdTag->appendChild($doc->createElement("Info",htmlentities($row['mealname'])));
}
$doc->formatOutput = true;
echo $doc->saveXML();
mysql_close($DBConn);
?>
