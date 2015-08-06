<?php
header("Content-Type: text/html;charset=utf-8");
?>
<html>
<body>
След като сте запазили xls файлът като .txt чрез "Save as Unicode (.txt)", качете получения .txt файл, за да го конвертирате към csv:
<form action="export.php" method="POST" enctype="multipart/form-data">
<input type="file" name="sourceFile" />
<input type="submit" value="Изпрати" />
</form>
</body>
</html>