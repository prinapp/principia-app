<?php
ini_set('display_errors', 'On');
error_reporting(E_ALL|E_STRICT);

include 'Global.php';
$DBConn = GetConn();
header("Content-Type: text/plain");
mysql_select_db("prinappdata",$DBConn);

$crn = $_GET['crn'];

$courseLookUp = sprintf('select syvrsct_crn, syvrsct_crse_numb, syvrsct_crse_title, syvrsct_subj_code, syvrsct_days_1, syvrsct_days_2, syvrsct_meeting_time_1, syvrsct_meeting_time_2, syvrsct_enrl, syvrsct_max_enrl'
        . ' ,syvrsct_prereq_flag, syvrsct_bldg_code_1, syvrsct_bldg_code_2, syvrsct_levels, syvrsct_attr_code_1, syvrsct_attr_code_2, syvrsct_attr_code_3, syvrsct_attr_code_4, syvrsct_instructor_1, syvrsct_room_code_1, syvrsct_room_code_2 from course_data where `syvrsct_crn` = %d',$crn);

$results = mysql_query($courseLookUp);
//check for errors
if(!$results)
{
    die(mysql_error());
}

$doc = new DOMDocument();
$root = $doc->createElement("CourseDetail");
$root = $doc->appendChild($root);

while($row = mysql_fetch_array($results))
{
    $course = $doc->createElement("Course");
    $courseTag = $root->appendChild($course);
    $courseTag->appendChild($doc->createElement("CRN",htmlentities($row[0])));
    $courseTag->appendChild($doc->createElement("Course_Num",htmlentities($row[1])));
    $courseTag->appendChild($doc->createElement("Title",htmlentities($row[2])));
    $courseTag->appendChild($doc->createElement("Subject",htmlentities($row[3])));
    $courseTag->appendChild($doc->createElement("Day_1",htmlentities($row[4])));
    $courseTag->appendChild($doc->createElement("Day_2",htmlentities($row[5])));
    $courseTag->appendChild($doc->createElement("Time_1",htmlentities($row[6])));
    $courseTag->appendChild($doc->createElement("Time_2",htmlentities($row[7])));
    $courseTag->appendChild($doc->createElement("Enrolled",htmlentities($row[8])));
    $courseTag->appendChild($doc->createElement("Max",htmlentities($row[9])));
    $courseTag->appendChild($doc->createElement("Prereq",htmlentities($row[10])));
    $courseTag->appendChild($doc->createElement("Bldg_1",htmlentities($row[11])));
    $courseTag->appendChild($doc->createElement("Bldg_2",htmlentities($row[12])));
    $courseTag->appendChild($doc->createElement("Open_To",htmlentities($row[13])));
    $courseTag->appendChild($doc->createElement("Attr_1",htmlentities($row[14])));
    $courseTag->appendChild($doc->createElement("Attr_2",htmlentities($row[15])));
    $courseTag->appendChild($doc->createElement("Attr_3",htmlentities($row[16])));
    $courseTag->appendChild($doc->createElement("Attr_4",htmlentities($row[17])));
    $courseTag->appendChild($doc->createElement("Instructor",htmlentities($row[18])));
    $courseTag->appendChild($doc->createElement("Room_1",htmlentities($row[19])));
    $courseTag->appendChild($doc->createElement("Room_2",htmlentities($row[20])));
    
}
$doc->formatOutput = true;
echo $doc->saveXML();
mysql_close($DBConn);

?>