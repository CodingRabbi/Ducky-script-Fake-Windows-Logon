function DropBox-Upload {

[CmdletBinding()]
param (
	
[Parameter (Mandatory = $True, ValueFromPipeline = $True)]
[Alias("f")]
[string]$SourceFilePath
) 

try {
    $db = "sl.Bbu_sEznesS6JQ7swX2yyz4U9KR8vuyD8H8FBVHTN1ykh4qU9IGCT8XpoAXiJWYx_AaDq8uxkhMfhzGCnpLofnBDJM4SL-c9acaJvV7XQaSveSqOUplDiJIVANLyt4x3eY-CPkiwaM0"

    $outputFile = Split-Path $SourceFilePath -leaf
    $TargetFilePath="/$outputFile"
    $arg = '{ "path": "' + $TargetFilePath + '", "mode": "add", "autorename": true, "mute": false }'
    $authorization = "Bearer " + $db
    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Authorization", $authorization)
    $headers.Add("Dropbox-API-Arg", $arg)
    $headers.Add("Content-Type", 'application/octet-stream')

    Invoke-RestMethod -Uri https://content.dropboxapi.com/2/files/upload -Method Post -InFile $SourceFilePath -Headers $headers
    return $true
}
catch {
    $errorLog = "ErrorLog.txt"
    $errorMessage = $_.Exception | Format-List -Force | Out-String
    $errorMessage | Out-File $errorLog -Append
    Write-Host "Error details saved to $errorLog"
    return $false
}
}

$FileName = "C:\Users\Moti\demo_macos.txt"
$result = $false
if (-not ([string]::IsNullOrEmpty($db))){
    $result = DropBox-Upload -f $FileName
}

if ($result) {
    Write-Host "File uploaded successfully."
} else {
    Write-Host "File upload failed."
}
