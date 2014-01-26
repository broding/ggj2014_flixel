<?php

require_once('config.php');

$link = new mysqli(host, user, password, database);

if(mysqli_connect_errno())
{
	die("Failed to connect to MySQL: " .$link->error);
}

$name = ($_POST['name']);
$score = ($_POST['score']);

$query = $link->prepare("CREATE TABLE IF NOT EXISTS `highscores` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT 'Player',
  `score` int(255) NOT NULL DEFAULT '0',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ; ");
$query->execute();

$query = $link->prepare("INSERT INTO highscores(name, score) VALUES (?, ?)");
	$query -> bind_param('si',$name, $score);

	if(!$query->execute()) {
		die("Request failed");
	}

$query = $link->prepare("SELECT name, score, date FROM highscores ORDER BY score DESC LIMIT 50");
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