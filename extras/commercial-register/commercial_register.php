<?php
$datastr = fopen('php://input',"rb");
if ($fp = fopen('/data/comreg/dump' . date('m-d-Y') . '.xml', "wb")){
    while(!feof($datastr)){
        fwrite($fp,fread($datastr,4096)) ;
    }
}
?>
