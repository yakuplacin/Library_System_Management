<?php
if ($_POST) {

    include 'conn.php';

    $username =  mysqli_real_escape_string($connect,  $_POST['username']);
    $password =  mysqli_real_escape_string($connect,  $_POST['password']);
    //$username = "yakup.deneme@agu.edu.tr";
    //$password = '147852369';

    $consult2 = $connect->query("SELECT password FROM authentication WHERE username = '".$username."'");
    $consult3 = $consult2->fetch_array()[0] ?? '';
  //  echo $consult3;
    $isCorrect = password_verify($password, $consult3);
  //  echo $isCorrect;
  //  echo "lkkkkkkkkkkkkkkkkkkk";
    if ($isCorrect) {
        $consult = $connect->query("SELECT * FROM authentication WHERE username = '".$username."'");
        while ($extractdata = $consult->fetch_assoc()) {
            $result[] = $extractdata;
        }
    }else {
        echo "password is wrong";
    }

  //  echo "lalalalalalaa";
    echo json_encode($result);
  //  echo "elellelelele";
} else {
    echo "Nothing is posted";
}
