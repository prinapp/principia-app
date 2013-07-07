<?php

include 'Global.php';

header("Content-Type: text/plain");
$DBConn = GetConn();
mysql_select_db("prinappdata", $DBConn);


$result = mysql_query("SELECT distinct `date`,`mealtype` FROM `menu1_T` ORDER BY `menu1_T`.`date` ASC");


$doc = new DOMDocument();
$root = $doc->createElement("Menu");
$root = $doc->appendChild($root);

$date = NULL;
$Meal = $doc->createElement("Meal");
$MealTag = $root->appendChild($Meal);
while($row = mysql_fetch_array($result))
{
	if(is_null($date))
	{
		$date = $row['date'];
		$MealTag->appendChild($doc->createElement("date",$row['date']));
		$MealTag->appendChild($doc->createElement("item",$row['mealtype']));
	}
	else
	{
		$Meal = $doc->createElement("Meal");
		$MealTag = $root->appendChild($Meal);
		$MealTag->appendChild($doc->createElement("date",$row['date']));
		$MealTag->appendChild($doc->createElement("item",$row['mealtype']));
		$date = $row['date'];
	}
	
	
}
$doc->formatOutput = true;

echo $doc->saveXML();

mysql_close($DBConn);
?>
