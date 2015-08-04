<?php
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
$writer->save(realpath(dirname(__FILE__)) . "/uploads/result.csv");

readfile("uploads/result.csv");
?>