<?php
// filename: ajaxProxy.php
header("Content-Type: text/xml");
if ( substr($_GET['url'], 0, 7) == 'http://' ) {
  $handle = fopen($_GET['url'], "rb");
  while ( !feof($handle) ) {
    echo fread($handle, 8192);
  }
  fclose($handle);
}
?>