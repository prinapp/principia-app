<?php

function GetConn()
{
	$con = mysql_connect("prinappdata.db.10830446.hostedresource.com", "prinappdata", "PrinApp1!");
	if(!$con)
	{
		die('Could not connect: ' . mysql_error());
	}
return $con;
}
?>
