<?php
ini_set('display_errors', 'On');
error_reporting(E_ALL|E_STRICT);

include 'Global.php';
$DBConn = GetConn();
header("Content-Type: text/plain");
mysql_select_db("prinappdata",$DBConn);

$results = mysql_query("SELECT distinct term_desc FROM `course_data` LIMIT 0, 30");
//check for errors
if(!$results)
{
    die(mysql_error());
}

$doc = new DOMDocument();
$root = $doc->createElement("TermList");
$root = $doc->appendChild($root);

while($row = mysql_fetch_array($results))
{
    $Term = $doc->createElement("Term");
    $termTag = $root->appendChild($Term);
    $termTag->appendChild($doc->createElement("Sem",htmlentities($row[0])));
}

$doc->formatOutput = true;
echo $doc->saveXML();
mysql_close($DBConn);
?>