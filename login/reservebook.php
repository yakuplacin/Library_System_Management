<?php 
	include "conn.php";

    $book_id = (int)$_POST['book_id'];
    $student_id = mysqli_real_escape_string($connect,  $_POST['student_id']);
    $date = mysqli_real_escape_string($connect,  $_POST['date']);
    $book_status=mysqli_real_escape_string($connect,  $_POST['book_status']);
    

    $query = "UPDATE book SET book_status = '".$book_status."' WHERE book_id = '".$book_id."', INSERT INTO reservation (book_id,student_id,date) VALUES ('".$book_id."','".$student_id."','".$date."')";
    
    
    $results = mysqli_query($connect,$query);

    
    if($results>0)
    {
        echo "Book has been given successfully";
    }

?>
