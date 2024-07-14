# Window Text to RDS by: João Moleano

# Destination path and file  
$path = c:\rds\radiotext.txt

# Refresh rate
$refresh = 3

# Process to monitor
$app = mpv

# Chars to remove from end (app name)
$trim = 11

# Function to replace special chars
function Update-SpecialCharacters {
    # From https://stackoverflow.com/questions/7836670/how-remove-accents-in-powershell
    param ([String]$sourceStringToClean = [String]::Empty)
    $normalizedString = $sourceStringToClean.Normalize( [Text.NormalizationForm]::FormD )
    $stringBuilder = new-object Text.StringBuilder
    $normalizedString.ToCharArray() | ForEach-Object { 
        if ( [Globalization.CharUnicodeInfo]::GetUnicodeCategory($_) -ne [Globalization.UnicodeCategory]::NonSpacingMark) {
            [void]$stringBuilder.Append($_)
        }

    }
    # From https://lazywinadmin.com/2015/05/powershell-remove-diacritics-accents.html
    [Text.Encoding]::ASCII.GetString([Text.Encoding]::GetEncoding("Cyrillic").GetBytes($stringBuilder.ToString()))
}

# The code...

Do {

# Get window title from application
$rds = Get-Process $app | Format-Table -HideTableHeaders mainWindowtitle | Out-String
# Lenght of the final message
$lenght = ($rds.Length) - $trim
# Replace special chars
$rdsout = Update-SpecialCharacters($rds)
# Generates final string and outputs it to a file
$rdsout.subString(0,$lenght) | Out-File $path -width 200
# File generated puts text on line 2 so we have to recreate the file with only one line
(Get-Content -Path $path | Select-Object -Skip 1) | Set-Content $path
# wait...
sleep $refresh

}

while ($true)
