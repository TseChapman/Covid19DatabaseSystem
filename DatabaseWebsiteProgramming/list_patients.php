<?php
/**
 * Created by PhpStorm.
 * User: MKochanski
 * Date: 7/24/2018
 * Time: 3:07 PM
 */
require_once 'config.inc.php';

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
    <h2>Patient List</h2>
    <form method="post">
            <input type="hidden" name="id" value="<?= $id ?>">
            Filter By Last Name: <input type="text" name="userQuery">
            <button type="submit">Update</button>
    </form>
    <?php
    // Create connection
    $conn = new mysqli($servername, $username, $password, $database, $port);

    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }
    
    $userQuery = "";
    
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $userQuery = $_POST['userQuery'];
        if ($userQuery === null)
            $userQuery='';
        else if ($userQuery === false)
            $userQuery='';
    }
    
    $sql = "SELECT personID,lastName,firstName,dateOfBirth,telephoneNo,email,sexCode FROM Person P WHERE P.personID IN (SELECT CRPS.personID FROM CovidReportPersonRole CRPS WHERE CRPS.roleCode = 'Patient') AND lastName LIKE CONCAT('%',?,'%') ORDER BY lastName";
    $stmt = $conn->stmt_init();
    if (!$stmt->prepare($sql)) {
        echo "failed to prepare";
    }
    else {
        $stmt->bind_param('s', $userQuery);
        $stmt->execute();
        $stmt->bind_result($personID, $lastName, $firstName, $dateOfBirth, $telephoneNo, $email, $sexCode);
        echo '<table border="1" width="400" cellpadding="5">';
        echo "<tr>";
        echo "<th>Name</th>";
        echo "<th>Date of Birth</th>";
        echo "<th>Phone Number</th>";
        echo "<th>Email</th>";
        echo "<th>Sex</th>";
		echo "</tr>";
        while ($stmt->fetch()) {
			echo '<tr>';
            echo '<td><a href="show_patient.php?id='  . $personID . '">' . $lastName . ', ' . $firstName .'</a></td>';
			echo '<td>'.$dateOfBirth.'</td>';
			echo '<td>'.$telephoneNo.'</td>';
			echo '<td>'.$email.'</td>';
			echo '<td>'.$sexCode.'</td>';
			echo '</tr>';
        }
        echo "</table>";
    }

    $conn->close();

    ?>
</div>
</body>
</html>
