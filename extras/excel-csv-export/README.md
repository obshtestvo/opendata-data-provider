В директорията са налични три скрипта:

- export.php - превръща .txt файл (получен след save as unicode .txt от Excel) във валиден .csv
- export.bat - същото като горното, но на локален Windows компютър
- convert.php - конвертира .xls(x) във валиден .csv

# Цел #

Целта на скриптовете е да решат проблема с конвертирането на Excel файлове в csv. Стандартната функционалност на Excel не работи правилно - резултатът не е в UTF-8, записите са разделени най-често с точка и запетая (;) вм. със запетая (и това зависи от настройките както на Windows, така и на Excel), и не слага кавички около всеки запис (което е допустимо според csv конвенциите, но не е желателно)

## export.php ##
Приема текстов файл, получен след save as unicode .txt в Excel, (напр. качен през export.html) и заменя табове със запетаи, слага кавички около всеки запис и осигурява резултатът да е UTF-8 with BOM

## export.bat ##
Същото като горното, но локално, като текстовият файл се очаква да се казва data.txt (TODO: параметър)

## convert.php ##

Конвертира .xls(x) файл към .csv, в UTF-8 with BOM. Файлът се качва през convert.html. Използва библиотеката <a href="https://github.com/PHPOffice/PHPExcel">PHPExcel</a>, която се инсталира чрез копиране на директорията Classes там, където е convert.php

# Инсталиране на PHP на сървър със CKAN #

За да се използват тези скриптове на същия сървър, на който е инсталиран CKAN, следва да се инсталира и конфигурира PHP с nginx.

Следват се стъпките, <a href="http://askubuntu.com/questions/134666/what-is-the-easiest-way-to-enable-php-on-nginx">посочени тук</a>, като към nginx.conf, освен описаният location фрагмент, се добавя и `root /var/www/php`. PHP файловете се разполагат в същата директория.

За error logging: <a href="https://stackoverflow.com/questions/8677493/php-fpm-doesnt-write-to-error-log">catch_workers_output = yes</a>
За увеличаване на upload limit: <a href="https://rtcamp.com/tutorials/php/increase-file-upload-size-limit/">max_post_size и upload_max_filesize</a>
