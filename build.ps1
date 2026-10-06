# Собирает index.html для PWA из tarelka.html (того же файла, что и артефакт).
$src = Get-Content -Raw -Encoding UTF8 (Join-Path $PSScriptRoot 'tarelka.html')
$split = $src.IndexOf('<div class="app">')
$head = $src.Substring(0, $split)
$body = $src.Substring($split)

$pwaHead = @'
<!doctype html>
<html lang="ru">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-title" content="Тарелка">
<meta name="apple-mobile-web-app-status-bar-style" content="default">
<meta name="theme-color" content="#F1F4EC" media="(prefers-color-scheme: light)">
<meta name="theme-color" content="#121613" media="(prefers-color-scheme: dark)">
<link rel="manifest" href="manifest.webmanifest">
<link rel="apple-touch-icon" href="apple-touch-icon.png">
<link rel="icon" href="icon-192.png">
<style>
  body{margin:0;overscroll-behavior:none;-webkit-tap-highlight-color:transparent}
  .app{padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}
  button{touch-action:manipulation}
  [hidden]{display:none!important}
</style>
'@

$pwaTail = @'
<script>
  if ('serviceWorker' in navigator) navigator.serviceWorker.register('sw.js');
</script>
</body>
</html>
'@

$out = $pwaHead + $head + "</head>`n<body>`n" + $body + "`n" + $pwaTail
[IO.File]::WriteAllText((Join-Path $PSScriptRoot 'index.html'), $out, (New-Object Text.UTF8Encoding $false))
Write-Output "index.html собран"
