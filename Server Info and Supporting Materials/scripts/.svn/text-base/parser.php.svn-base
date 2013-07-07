<?php
ini_set('display_errors', 'On');
error_reporting(E_ALL|E_STRICT);

$con = mysql_connect("prinappdata.db.10830446.hostedresource.com", "prinappdata", "PrinApp1!");
if(!$con)
{
	die('Could not connect: ' . mysql_error());
}

mysql_select_db("prinappdata", $con);

//---------------------------------------------------//
/*
This little section of code ensures that the table we
will be writing to is empty in the very beginning. This
will be called everytime the page is requested.
*/
$clear = 'TRUNCATE TABLE `menu1_T`';
$clrquery = mysql_query($clear,$con);

if(!$clrquery)
{
   die('Query execution problem: ' . mysql_error());
}
//---------------------------------------------------//

//Query to access the relevant columns in the dirty table.
$sql = "SELECT `COL 1`, `COL 2`, `COL 4`, `COL 6`, `COL 8`, `COL 10`, `COL 12`, `COL 14` FROM `TABLE_1`";
$query = mysql_query($sql);

//check if query succeeds
if(!$query)
{
    die('Query execution problem: ' . mysql_error());
}
/*Date parsing for the first row in dirty table*/
$row = mysql_fetch_row($query);
$dtearray = array();
for($dindex=1;$dindex<count($row);$dindex++)
{
	$arrdate = preg_split("/\s/",$row[$dindex]); //This is how you split string with regular expression
	if($timestamp = strtotime($arrdate[0] === false)) //check to see if valid date, if not give todays date
	{
		$date = date('Y-m-d');
	}
	else 
	{
		/*process date from timestamp and then add the new date into an array
		filled with a week of dates*/		
		$date = date('Y-m-d', strtotime($arrdate[0]));
		$dtearray[$dindex] = $date;
	}
}
/*This while loop will process each row in the dirty table
  It determines what mealtype is being processed then creates
  a query string with the corresponding date mealtype and meal name
*/
while($row = mysql_fetch_array($query))
{
	$dtindex = 1;	//index for the date array created earlier
	//check to see if the mealtype field in the column is empty.
	//--if true, the mealtype doesn't change.
	//--if false, there is a new mealtype so, read the new type and make it the current one
	if(!empty($row['COL 1']))
	{
		$mealtype = $row['COL 1'];
	}
	for($rindex = 2;$rindex<count($row);$rindex+=2)
	{				
		$colid = 'COL '. $rindex; //increment the column id of the dirty table
	//check to see if the mealname is empty
	//--if true, there is a valid meal name and we can enter it into the new table.
	//--if false, there is no meal name, skip to the next row
		if(empty($row[$colid]))
		{
			$dtindex++;	//increment the date index if there is no meal for that day.
			continue;
		}
		$insq = sprintf("INSERT INTO `prinappdata`.`menu1_T` (`date`, `mealtype`, `mealname`) VALUES ('%s', '%s', '%s')",$dtearray[$dtindex],$mealtype,$row[$colid]);
		if (!mysql_query($insq,$con))
		{
			die('Error: ' . mysql_error());
		}
		$dtindex++;		
	}
}
/*	-------------Code Notes----------------
	This is the string to copy a single meal element into the database table
	$insq = sprintf("INSERT INTO `menu_t`.`menu1_T` (`date`, `mealtype`, `mealname`) VALUES ('%s', '%s', '%s')"
			,$date,$mealtype,$row['COL 2']);
	
*/
  mysql_close($con);
?>
