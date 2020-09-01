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
    <h2>Show Patient</h2>
    <?php

    // Create connection
    $conn = new mysqli($servername, $username, $password, $database, $port);

    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    $sql = "SELECT P.personID,lastName,firstName,dateOfBirth,D.deathDate,telephoneNo,email,sexCode,O.organizationCode,O.organizationName FROM (Person P LEFT JOIN Death D ON P.deathDateID = D.deathDateID) LEFT JOIN Organization O ON P.organizationID = O.organizationID WHERE P.personID = ?";
    $stmt = $conn->stmt_init();
    if (!$stmt->prepare($sql)) {
        echo "failed to prepare";
    }
    else {
        $stmt->bind_param('s',$id);
        $stmt->execute();
        $stmt->store_result();
        $stmt->bind_result($personID,$lastName,$firstName,$dateOfBirth,$deathDate,$telephoneNo,$email,$sexCode,$organizationCode,$organizationName);
        echo "<div>";
        while ($stmt->fetch()) {
             echo '<h1>'.$firstName.' '.$lastName.'</h1>';
             echo '<p>Date of Birth: '.$dateOfBirth.'</p>';
             echo '<p>Date of Death: '.$deathDate.'</p>';
			 echo '<p>Sex: '.$sexCode.'</p>';echo '<p>Date of Birth: '.$dateOfBirth.'</p>';
			 echo '<p>Telephone Number: '.$telephoneNo.'</p>';
			 echo '<p>Email Address: '.$email.'</p>';
			 echo '<p>Organization Name: '.$organizationName.'</p>';
			 echo '<p>Organization Type: '.$organizationCode.'</p>';
			 $sql2 = "SELECT C.caseID,C.illnessOnsetDate,C.hospitalizationEndDate,C.hospitalizationStartDate FROM Person P INNER JOIN CaseTable C ON P.personID = C.personID INNER JOIN Test T ON C.caseID = T.caseID WHERE C.personID = ?";
            $stmt2 = $conn->stmt_init();
            if (!$stmt2->prepare($sql2)) {
                echo "failed to prepare";
            }
            else {
                $stmt2->bind_param('s',$id);
                $stmt2->execute();
                $stmt2->store_result();
                $stmt2->bind_result($caseID,$illnessOnsetDate,$hospitalizationEndDate,$hospitalizationStartDate);
                echo '<table border="1" width="400" cellpadding="5">';
                echo "<tr>";
                echo "<th>Illness On Set Date</th>";
                echo "<th>Hospitalization Start Date</th>";
                echo "<th>Hospitalization End Date</th>";
                echo "<th>Tests</th>";
                while ($stmt2->fetch()) {
                    echo '<tr>';
        	        echo '<td>'.$illnessOnsetDate.'</td>';
        	        echo '<td>'.$hospitalizatinStartDate.'</td>';
        	        echo '<td>'.$hospitalizationEndDate.'</td>';
                    $sql3 = "SELECT T.testID,T.testCode,T.result,T.testNote,T.collectionDate,T.sentDate FROM Person P INNER JOIN CaseTable C ON P.personID = C.personID INNER JOIN Test T ON C.caseID = T.caseID WHERE C.personID = ?";
                    $stmt3 = $conn->stmt_init();
                    if (!$stmt3->prepare($sql3)) {
                        echo "failed to prepare";
                    }
                    else {
                        $stmt3->bind_param('s', $id);
                        $stmt3->execute();
                        $stmt3->store_result();
                        $stmt3->bind_result($testID,$testCode,$result,$testNote,$collectionDate,$sentDate);
                        echo '<td>';
                        echo '<table border="1" width="400" cellpadding="5">';
                        echo "<tr>";
                        echo "<th>Test Type</th>";
                        echo "<th>Test Result</th>";
                        echo "<th>Test Collection Date</th>";
                        echo "<th>Test Sent Date</th>";
                        echo "<th>Test Note</th>";

                        while ($stmt3->fetch()) {
                            echo '<tr>';
                            echo '<td>'.$testCode.'</td>';
                            echo '<td>'.$result.'</td>';
                            echo '<td>'.$collectionDate.'</td>';
                            echo '<td>'.$sentDate.'</td>';
                            echo '<td>'.$testNote.'</td>';
                            echo '</tr>';
                        }
                        
                        echo '</table>';
                        echo '</td>';

                    }
                echo '</tr>';
            	}
		 echo "</table>";

        }
    }
                echo "</div>";
    ?>
        <div>
            <a href="update_patient.php?id=<?= $personID ?>">Update Patient</a>
        </div>
    <?php
    }

    $conn->close();

    ?>
</>
</body>
</html>

