<?php
ini_set('memory_limit', '256M');

error_reporting(E_ALL);

header('Content-Type: text/csv;charset=UTF-8');
header('Content-Disposition: attachment; filename=data.csv');

/** PHPExcel https://github.com/PHPOffice/PHPExcel */
require_once 'Classes/PHPExcel.php'; // (this should include the autoloader)
require_once 'Classes/PHPExcel/IOFactory.php';

$excel_readers = array(
    'Excel5' , 
    'Excel2003XML' , 
    'Excel2007'
);

echo "\xEF\xBB\xBF"; // UTF-8 BOM

$path = $_FILES["sourceFile"]["tmp_name"];
$reader = PHPExcel_IOFactory::createReaderForFile($path);
$reader->setReadDataOnly(true);

$excel = $reader->load($path);

$writer = PHPExcel_IOFactory::createWriter($excel, 'CSV');

$filename = "uploads/result.csv" . rand(100, 10000);
$writer->save(realpath(dirname(__FILE__)) . "/" . $filename);

$handle = fopen($filename, "r");
if ($handle) {
	$buffer = "";
	while (($line = fgets($handle)) !== false) {
		if (!endsWith(trim($line), '"')) {
			$buffer .= trim($line) . " / ";
		} else {
			echo $buffer;
			echo $line;
			$buffer = "";
		}
	}
} else {
	echo "Error reading file";
}

function endsWith($haystack, $needle) {
    // search forward starting from end minus needle length characters
    return $needle === "" || (($temp = strlen($haystack) - strlen($needle)) >= 0 && strpos($haystack, $needle, $temp) !== FALSE);
}
function utf8_fopen_read($fileName) { 
    $fc = iconv('utf-16', 'utf-8', file_get_contents($fileName)); 
    $handle=fopen("php://memory", "rw"); 
    fwrite($handle, $fc); 
    fseek($handle, 0); 
    return $handle; 
} 
?>