<?php
/*
This script insert the course data from the CSV located in the Data folder
of the server. It writes all lines fromt the file into the table in the database.
*/
ini_set('auto_detect_line_endings',TRUE);
ini_set('display_errors', 'On');
error_reporting(E_ALL|E_STRICT);
$row = 1;
$con = mysql_connect("prinappdata.db.10830446.hostedresource.com", "prinappdata", "PrinApp1!");
if(!$con)
{
	die('Could not connect: ' . mysql_error());
}
/*
Remove this comments to make the table clear before you update with new information.
mysql_select_db("prinappdata", $con);
$clear = 'TRUNCATE TABLE `coursedata`';
$query = mysql_query($clear,$con);

if(!$query)
{
   die('Query execution problem: ' . mysql_error());
}
*/

//Start of the import of the course data.
if (($handle = fopen("http://prinapp.geektron.me/Data/courseScheduleDataSpring2013.csv", "r")) !== FALSE) //open the file.
{
	while (($data = fgetcsv($handle,0,",",'"')) !== FALSE) 
	{
        $num = count($data);
        echo "<p> $num fields in line $row: <br /></p>\n";
        $row++;
		if($row == 2)
		{
			continue;
		}
		
		$sql = sprintf("Insert into `prinappdata`.`coursedata` VALUES('%s','%s','%s','%s','%s','%s','%s','%s','%s', '%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s');",
																		$data[0],$data[1],$data[2],$data[3],$data[4],$data[5],$data[6],$data[7]
																		,$data[8],$data[9],$data[10],$data[11],$data[12],$data[13],$data[14],$data[15]
																		,$data[16],$data[17],$data[18],$data[19],$data[20],$data[21],$data[22],$data[23]
																		,$data[24],$data[25],$data[26],$data[27],$data[28],$data[29],$data[30],$data[31]
																		);
				
				echo $sql . '<br />';
				//include fix to correct quotation marks glitch.
		if (!mysql_query($sql,$con))
		{
		//New query with the single quotes switched out with double quoted this is done in an 
		//effort to input data that has single quotes in it. eg. D'Evelyn
		$sql = sprintf('Insert into `prinappdata`.`coursedata` VALUES("%s","%s","%s","%s","%s","%s","%s","%s","%s", "%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s");',
																		$data[0],$data[1],$data[2],$data[3],$data[4],$data[5],$data[6],$data[7]
																		,$data[8],$data[9],$data[10],$data[11],$data[12],$data[13],$data[14],$data[15]
																		,$data[16],$data[17],$data[18],$data[19],$data[20],$data[21],$data[22],$data[23]
																		,$data[24],$data[25],$data[26],$data[27],$data[28],$data[29],$data[30],$data[31]
																		);
			if (!mysql_query($sql,$con))
			{
				die('Error: ' . mysql_error());
			}
		}
	}
	fclose($handle);
}
?>