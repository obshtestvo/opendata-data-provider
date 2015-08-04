<?php
header('Content-Type: text/csv;charset=UTF-8');
header('Content-Disposition: attachment; filename=data.csv');

$uploadOk = 1;
$fileType = pathinfo(basename($_FILES["sourceFile"]["name"]), PATHINFO_EXTENSION);
// Check if image file is a actual image or fake image
if($fileType == "txt") {
	$handle = utf8_fopen_read($_FILES["sourceFile"]["tmp_name"], "r");
	if ($handle) {
		echo "\xEF\xBB\xBF"; // UTF-8 BOM
		while (($line = fgets($handle)) !== false) {
			$line = str_replace("\r", "", $line);
			$line = str_replace("\n", "", $line);
			$line = preg_replace('!\t+!', '","', $line);
			$line = str_replace('",""', '","', $line);
			$line = str_replace('"","', '","', $line);
			if (substr($line, 0, 1) != '"') {
				$line = '"' . $line;
			}
			if (substr($line, -1, 1) != '"') {
				$line = $line . '"';
			}
			echo $line . "\r\n";
		}

		fclose($handle);
	} else {
		echo "Error opening file";
	}
} else {
	echo "Unsupported file type " . $fileType;
}

function utf8_fopen_read($fileName) { 
    $fc = iconv('utf-16', 'utf-8', file_get_contents($fileName)); 
    $handle=fopen("php://memory", "rw"); 
    fwrite($handle, $fc); 
    fseek($handle, 0); 
    return $handle; 
} 
?>