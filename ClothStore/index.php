<?php
	$email = $_POST['email'];
	$password = $_POST['password'];

	// Database connection
	$conn = mysqli_connect('localhost','root','','index2');
	$name= "INSERT into user(`email`,`password`) values('$email','$password')";
    $execute = mysqli_query($conn,$name);
	if($execute){
		header("Location:login.html");
	}
	
	
?>