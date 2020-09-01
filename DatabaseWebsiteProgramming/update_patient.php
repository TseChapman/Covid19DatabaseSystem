<?php
/**
 * Created by PhpStorm.
 * User: MKochanski
 * Date: 7/24/2018
 * Time: 3:07 PM
 */
require_once 'config.inc.php';
// Get Customer Number
$id = $_GET['id'];
if ($id === "") {
    header('location: list_patients.php');
    exit();
}
if ($id === false) {
    header('location: list_patients.php');
    exit();
}
if ($id === null) {
    header('location: list_patients.php');
    exit();
}
?>
<html>
<head>
    <title>COVID-19 Patient Database</title>
    <link rel="stylesheet" href="base.css">
</head>
<body>
<?php
require_once 'header.inc.php';
?>
<div>
    <h2>Update Patient</h2>
    <?php

    // Create connection
    $conn = new mysqli($servername, $username, $password, $database, $port);

    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }
    // update last name
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $lastName = $_POST['lastName'];
        if ($lastName === null)
            echo "<div><i>Specify a new last name</i></div>";
        else if ($lastName === false)
            echo "<div><i>Specify a new last name</i></div>";
        else if (trim($lastName) === "")
            echo "<div><i>Specify a new last name</i></div>";
        else {
            /* perform update */
            $sql = "UPDATE Person SET lastName = ? WHERE personID = ?";
            $stmt = $conn->stmt_init();
            if (!$stmt->prepare($sql)) {
                echo "failed to prepare";
            } else {
                $stmt->bind_param('ss',$lastName,$id);
                $stmt->execute();
                $conn->commit();
            }
        }
    }
    
    // update first name
     if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $firstName = $_POST['firstName'];
        if ($firstName === null)
            echo "<div><i>Specify a new first name</i></div>";
        else if ($firstName === false)
            echo "<div><i>Specify a new first name</i></div>";
        else if (trim($firstName) === "")
            echo "<div><i>Specify a new first name</i></div>";
        else {
            /* perform update */
            $sql2 = "UPDATE Person SET firstName = ? WHERE personID = ?";
            $stmt2 = $conn->stmt_init();
            if (!$stmt2->prepare($sql2)) {
                echo "failed to prepare";
            } else {
                $stmt2->bind_param('ss',$firstName,$id);
                $stmt2->execute();
                $conn->commit();
            }
        }
    }

    /* Refresh the Data */
    $sql = "SELECT personID,lastName,firstName,dateOfBirth,telephoneNo,email,sexCode FROM Person P WHERE P.personID = ?";
    $stmt = $conn->stmt_init();
    if (!$stmt->prepare($sql)) {
        echo "failed to prepare";
    }
    else {
        $stmt->bind_param('s',$id);
        $stmt->execute();
        $stmt->bind_result($personID,$lastName,$firstName,$dateOfBirth,$telephoneNo,$email,$sexCode);
        ?>
        <form method="post">
            <input type="hidden" name="id" value="<?= $id ?>">
        <?php
        while ($stmt->fetch()) {
            echo '<a href="show_patient.php?id='  . $personID . '">' . $lastName .  ', ' . $firstName . '</a><br>' .
            'Date of Birth: ' . $dateOfBirth . '</a><br>' . 'Sex: ' . $sexCode . '</a><br>' . 'Telephone Number: '  . $telephoneNo . '</a><br>' . 'Email: ' . $email;
        }
    ?><br><br>
            New Last Name: <input type="text" name="lastName">
            <button type="submit">Update</button>
        </form>
    <?php
    }
    
     
     /* Refresh the Data */
    $sql = "SELECT personID,lastName,firstName,dateOfBirth,telephoneNo,email,sexCode FROM Person P WHERE P.personID = ?";
    $stmt = $conn->stmt_init();
    if (!$stmt->prepare($sql)) {
        echo "failed to prepare";
    }
    else {
        ?>
        <form method="post">
            <input type="hidden" name="id" value="<?= $id ?>">
            New First Name: <input type="text" name="firstName">
            <button type="submit">Update</button>
        </form>
    <?php
    }
        
    $conn->close();

    ?>
</>
</body>
</html>
