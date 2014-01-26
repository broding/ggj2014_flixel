<?php

require_once('config.php');

$link = new mysqli(host, user, password, database);

if(mysqli_connect_errno())
{
	die("Failed to connect to MySQL: " .$link->error);
}
$query = $link->prepare("SELECT name, score, date FROM highscores ORDER BY score DESC LIMIT 20");
	if($query->execute()) {
		$query -> bind_result($name, $score, $date);
		$highscorelist = array();
		
		$namelist = array();
		$scorelist = array();
		$datelist = array();
		
		while ($query->fetch())
		{
			array_push($namelist, $name);
			array_push($scorelist, $score);
			array_push($datelist, $date);
		}
		array_push($highscorelist, $namelist, $scorelist, $datelist);
		echo json_encode($highscorelist);
			
	}else
	{
		die("Request failed");
	}

mysqli_close($link);
?>