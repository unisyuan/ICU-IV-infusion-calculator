$currentDir = 'C:\Users\FJUHUSER.FJCUH.001\.gemini\antigravity\scratch\icu_calculator'
$scratchDir = Join-Path $currentDir 'reference'

$drugsJson = Get-Content -Path (Join-Path $scratchDir 'drugs_extracted.json') -Raw -Encoding utf8
$compatJson = Get-Content -Path (Join-Path $scratchDir 'compatibility_extracted.json') -Raw -Encoding utf8
$electroJson = Get-Content -Path (Join-Path $scratchDir 'electrolytes_extracted.json') -Raw -Encoding utf8

$templatePath = Join-Path $currentDir 'template.html'
$indexPath = Join-Path $currentDir 'index.html'

if (-Not (Test-Path $templatePath)) {
    Write-Error 'template.html not found!'
    exit 1
}

$html = Get-Content -Path $templatePath -Raw -Encoding utf8

# Replace tokens
$html = $html.Replace('// __DRUGS_JSON__', $drugsJson)
$html = $html.Replace('// __COMPAT_JSON__', $compatJson)
$html = $html.Replace('// __ELECTROLYTES_JSON__', $electroJson)

$html | Out-File -FilePath $indexPath -Encoding utf8
Write-Output 'App built successfully!'
