<?php
ini_set('display_errors', 'On');
error_reporting(E_ALL|E_STRICT);

include 'Global.php';
$DBConn = GetConn();
header("Content-Type: text/plain");
mysql_select_db("prinappdata",$DBConn);

$searchTerm = $_GET['search'];
$semester = $_GET['term'];
$semArray = explode("_", $semester);
$semester = $semArray[0] . " " . $semArray[1]; 

//Check to see if the query is either numeric or a string and use the right specifiers in each of the courseQuery strings.
if(is_numeric($searchTerm))
{
    $courseQuery = sprintf("SELECT term_desc, syvrsct_crn, syvrsct_subj_code, syvrsct_crse_numb, 
syvrsct_crse_title, syvrsct_instructor_1, syvrsct_instructor_2 FROM `course_data` WHERE syvrsct_crse_title like '%%%d%%' or syvrsct_instructor_1 like '%%%d%%' or syvrsct_instructor_2 like '%%%d%%' or syvrsct_subj_desc like '%%%d%%' or syvrsct_crse_numb like '%%%d%%' AND term_desc = '%s' ",$searchTerm,$searchTerm,$searchTerm,$searchTerm,$searchTerm,$semester);
}
else{
    $courseQuery = sprintf("SELECT term_desc, syvrsct_crn, syvrsct_subj_code, syvrsct_crse_numb, 
syvrsct_crse_title, syvrsct_instructor_1, syvrsct_instructor_2 FROM `course_data` WHERE syvrsct_crse_title like '%%%s%%' or syvrsct_instructor_1 like '%%%s%%' or syvrsct_instructor_2 like '%%%s%%' or syvrsct_subj_desc like '%%%s%%' or syvrsct_crse_numb like '%%%s%%' AND term_desc = '%s'",$searchTerm,$searchTerm,$searchTerm,$searchTerm,$searchTerm,$semester);
}
$results = mysql_query($courseQuery);
//check for errors
if(!$results)
{
    die(mysql_error());
}

//XML document creation.
$doc = new DOMDocument();
$root = $doc->createElement("CourseList");
$root = $doc->appendChild($root);

while($row = mysql_fetch_array($results))
{
    $course = $doc->createElement("Course");
    $courseTag = $root->appendChild($course);
    $courseTag->appendChild($doc->createElement("Term",htmlentities($row[0])));
    $courseTag->appendChild($doc->createElement("CRN",htmlentities($row[1])));
    $courseTag->appendChild($doc->createElement("Subject",htmlentities($row[2])));
    $courseTag->appendChild($doc->createElement("Course_Num",htmlentities($row[3])));
    $courseTag->appendChild($doc->createElement("Course_Title",htmlentities($row[4])));
    $courseTag->appendChild($doc->createElement("Prof_1",htmlentities($row[5])));
    $courseTag->appendChild($doc->createElement("Prof_2",htmlentities($row[6])));
}
$doc->formatOutput = true;
echo $doc->saveXML();
mysql_close($DBConn);
?>