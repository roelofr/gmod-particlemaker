#!/usr/bin/env php
<?php

$gameDir = 'E:\servers\source\gmod\garrysmod';

$gameDir = rtrim($gameDir, '/\\');

$resourcePath = $gameDir . '/resource/localization/';

if(!file_exists($resourcePath) || !is_dir($resourcePath)) {
    echo "Gmod dir not found";
    exit();
}

$files = scandir($resourcePath);

$locales = [];

foreach($files as $file) {
    $path = $resourcePath . $file;
    if($file[0] == '.' || !file_exists($path) || !is_dir($path)) {
        continue;
    }

    $locales[] = $file;
}

$localVersions = [];

$langFile = "/resource/localization/%s/main_menu.properties";

function toRealUnicode($match) {
    return mb_convert_encoding(pack('H*', $match[1]), 'UTF-8', 'UCS-2BE');
};
const UNI_REGEX = '/\\\\u([0-9a-fA-F]{4})/';

foreach ($locales as $language) {
    $langPath = $gameDir . sprintf($langFile, $language);

    if(
        !file_exists($langPath) ||
        !is_file($langPath) ||
        !is_readable($langPath)
    )
        continue;

    $data = file_get_contents($langPath);

    $matches = null;

    if(preg_match('/^new_game=(.+)$/m', $data, $matches)) {
        $match = $matches[1];
        $match = preg_replace_callback(UNI_REGEX, 'toRealUnicode', $match);
        $localVersions[$language] = [
            $language,
            $matches[1],
            $match
        ];
    } else {
        echo "No match on {$language}\n";
    }
}

$arrayOut = [];
$format = '{"%s", "%s"}';

foreach($localVersions as list($lang, $enc, $plain)) {
    $arrayOut[] = sprintf($format, $plain, $lang);
}
$format2 = "local localeLinks = {\r\n    %s\r\n}";

$result = sprintf($format2, implode(",\r\n    ", $arrayOut));

file_put_contents(__DIR__ . '/locales.lua', $result);
