$ErrorActionPreference = 'Stop'
$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$login = Invoke-WebRequest 'http://localhost:8080/login' -WebSession $session -ErrorAction Stop
$html = $login.Content
$pos = 0
$found = $false
while ($true) {
    $pos = $html.IndexOf('<input', $pos)
    if ($pos -lt 0) { break }
    $end = $html.IndexOf('>', $pos)
    if ($end -lt 0) { break }
    $tag = $html.Substring($pos, $end - $pos + 1)
    if ($tag -match 'type\s*=\s*"hidden"' -or $tag -match "type\s*=\s*'hidden'") { $found = $true; break }
    $pos = $end + 1
}
if (-not $found) { Write-Output 'CSRF_NOT_FOUND'; exit 1 }
$nameM = [regex]::Match($tag, 'name="([^"]+)"')
if (-not $nameM.Success) { $nameM = [regex]::Match($tag, "name='([^']+)'") }
$valM = [regex]::Match($tag, 'value="([^"]+)"')
if (-not $valM.Success) { $valM = [regex]::Match($tag, "value='([^']+)'") }
if (-not $nameM.Success -or -not $valM.Success) { Write-Output 'CSRF_NOT_FOUND'; exit 1 }
$csrfName = $nameM.Groups[1].Value
$csrfToken = $valM.Groups[1].Value
Write-Output "Found CSRF param: $csrfName (len=$(($csrfToken).Length))"
$body = @{}
$body.Add('username','customer')
$body.Add('password','customer')
$body.Add($csrfName,$csrfToken)
$resp = Invoke-WebRequest -Uri 'http://localhost:8080/authenticateTheUser' -Method POST -Body $body -WebSession $session -MaximumRedirection 0 -ErrorAction SilentlyContinue
if ($resp -ne $null) { Write-Output "LoginStatus: $($resp.StatusCode)" } else { Write-Output "LoginStatus: NULL (likely redirected)" }
$books = Invoke-WebRequest -Uri 'http://localhost:8080/books' -WebSession $session -ErrorAction Stop
$books.Content | Out-File temp_books_auth.html -Encoding UTF8
Write-Output "BooksLength: $($books.Content.Length)"
$links = @()
$pos = 0
while ($true) {
    $pos = $books.Content.IndexOf('<link', $pos)
    if ($pos -lt 0) { break }
    $end = $books.Content.IndexOf('>', $pos)
    if ($end -lt 0) { break }
    $tag = $books.Content.Substring($pos, $end - $pos + 1)
    $hrefPos = $tag.IndexOf('href=')
    if ($hrefPos -ge 0) {
        # detect quote char
        $qchar = $tag.Substring($hrefPos + 5, 1)
        if ($qchar -ne '"' -and $qchar -ne "'") { $qchar = '"'; $rest = $tag.Substring($hrefPos + 5) } else { $rest = $tag.Substring($hrefPos + 6) }
        $next = $rest.IndexOf($qchar)
        if ($next -ge 0) { $href = $rest.Substring(0, $next); $links += $href }
    }
    $pos = $end + 1
}
$links = $links | Select-Object -Unique
if ($links.Count -eq 0) { Write-Output 'No <link> tags found' }
foreach ($l in $links) {
    if ($l -match '^https?://') { 
        $uri = $l 
    } else { 
        if ($l.StartsWith('/')) { $uri = 'http://localhost:8080' + $l } else { $uri = 'http://localhost:8080/' + $l }
    }
    try {
        $r = Invoke-WebRequest -Uri $uri -WebSession $session -TimeoutSec 5 -ErrorAction Stop
        $status = $r.StatusCode
        $ctype = $r.Headers['Content-Type']
        $len = $r.Content.Length
    } catch {
        $status = 'ERR'
        $ctype = '-'
        $len = 0
    }
    Write-Output "$uri -> $status $ctype $len"
}
