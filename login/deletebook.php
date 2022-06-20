<?php 
	include "conn.php";

    $book_id = mysqli_real_escape_string($connect,  $_POST['book_id']);    
    $publisher_id = mysqli_real_escape_string($connect,  $_POST['publisher_id']);
    $author_id = mysqli_real_escape_string($connect,  $_POST['author_id']);
   
  
    $query = "DELETE FROM book WHERE book_id = '".$book_id."'";

    $results = mysqli_query($connect,$query);

    if($results>0)
    {
        echo "Book has been deleted successfully";
    }

?>
