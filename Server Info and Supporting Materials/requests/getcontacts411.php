<?php
ini_set('display_errors', 'On');
error_reporting(E_ALL|E_STRICT);

include 'Global.php';
$DBConn = GetConn();
header("Content-Type: text/plain");
mysql_select_db("prinappdata",$DBConn);

$result = mysql_query("SELECT * FROM `contacts`");

$doc = new DOMDocument();
$root = $doc->createElement("Contacts");
$root = $doc->appendChild($root);

while($row = mysql_fetch_array($result))
{
	$Meald = $doc->createElement("Item");
	$MealdTag = $root->appendChild($Meald);

	$MealdTag->appendChild($doc->createElement("Name",htmlentities($row['name'])));
	$MealdTag->appendChild($doc->createElement("Contact",htmlentities($row['contact'])));
	$MealdTag->appendChild($doc->createElement("Type",htmlentities($row['type'])));
	$MealdTag->appendChild($doc->createElement("Seq",htmlentities($row['seq'])));
}
$doc->formatOutput = true;
echo $doc->saveXML();
mysql_close($DBConn);
?>
