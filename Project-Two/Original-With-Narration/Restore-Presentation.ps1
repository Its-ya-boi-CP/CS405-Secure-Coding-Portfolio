$target = Join-Path $PSScriptRoot '..\CS405_Project_Two_Security_Policy_Presentation_Coden_Polk_WITH_NARRATION.pptx'
$stream = [IO.File]::Create($target)
try {
    Get-ChildItem -LiteralPath $PSScriptRoot -Filter 'presentation.pptx.part*' | Sort-Object Name | ForEach-Object {
        $bytes = [IO.File]::ReadAllBytes($_.FullName)
        $stream.Write($bytes, 0, $bytes.Length)
    }
} finally { $stream.Close() }
$expected = '20681858e429fa17f9f210dbd977cd1fa78adfbdd56dbb6fb49e4f52a265c5f8'
$actual = (Get-FileHash -LiteralPath $target -Algorithm SHA256).Hash.ToLowerInvariant()
if ($actual -ne $expected) { throw 'Checksum mismatch. Download all presentation parts and try again.' }
Write-Output "Original narrated presentation restored and verified: $target"
