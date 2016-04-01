<?php
header("Content-Type: text/html;charset=utf-8");
?>
<html>
<body>
Качете xls(x) файла, който искате да конвертирате към csv:
<form action="convert.php" method="POST" enctype="multipart/form-data">
<input type="file" name="sourceFile" size="35" />
<input type="submit" value="Конвертирай" />
</form>
</body>
</html>
