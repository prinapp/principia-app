<?php
ini_set('auto_detect_line_endings',TRUE);
ini_set('display_errors', 'On');
error_reporting(E_ALL|E_STRICT);
$row = 1;
$con = mysql_connect("prinappdata.db.10830446.hostedresource.com", "prinappdata", "PrinApp1!");
if(!$con)
{
	die('Could not connect: ' . mysql_error());
}

mysql_select_db("prinappdata", $con);
$clear = 'TRUNCATE TABLE `TABLE_1`';
$query = mysql_query($clear,$con);

if(!$query)
{
   die('Query execution problem: ' . mysql_error());
}

if (($handle = fopen("http://prinapp.geektron.me/Data/menu.csv", "r")) !== FALSE) {
    while (($data = fgetcsv($handle,0,",",'"')) !== FALSE) {
        $num = count($data);
        echo "<p> $num fields in line $row: <br /></p>\n";
        $row++;
	if($row == 1)
	 	continue;
	    else if($row == 2)
	    {
	     	continue;
            }
	else if($row == 3)
	{
	   continue;
	}
	$sql = sprintf('INSERT INTO `prinappdata`.`TABLE_1` (`COL 1`, `COL 2`, `COL 3`, `COL 4`, `COL 5`, `COL 6`, `COL 7`, `COL 8`, `COL 9`, `COL 10`, `COL 11`, `COL 12`, `COL 13`, `COL 14`) VALUES ("%s", "%s", "%s", "%s", "%s", "%s", "%s", "%s", "%s", "%s", "%s", "%s", "%s", "%s")',
							 $data[0],
							 $data[1],
							$data[2],
							$data[3],
							$data[4],
							$data[5],
							$data[6],
							$data[7],
							$data[8],
							$data[9],
							$data[10],
							$data[11],
							$data[12],
							$data[13]);
	echo $sql . '<br />';
	if (!mysql_query($sql,$con))
		{
			die('Error: ' . mysql_error());
		}
    }
    fclose($handle);
}
?>
