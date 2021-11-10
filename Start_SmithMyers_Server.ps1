Write-Host "Server process starting"

if ( Test-Path -Path $env:LOCALAPPDATA\serverDataPath.txt -PathType Leaf )
{
    Write-Host -f Green "Found file path in LocalAppData"

    Write-Host -f Green "Starting SmithMyers Server"

    $runit = Get-Content -Path $env:LOCALAPPDATA\serverDataPath.txt

    Invoke-Expression -Command $runit
}
elseif ((Test-Path -Path "C:\ProgramData\SmithMyers\tileserver-sm\4E93EAD9FEC3D306AEF36C3FECB2F188.txt" -PathType Leaf ) -or (Test-Path -Path "D:\SmithMyers\tileserver-sm\4E93EAD9FEC3D306AEF36C3FECB2F188.txt" -PathType Leaf ))
    {
        Write-Warning "Could not find saved data path. Searching C: and D: for data."

        Write-Warning "Creating serverDataPath.txt file at %localappdata%"

        New-Item -Path "$($env:LOCALAPPDATA)\serverDataPath.txt"
    }

    if ( Test-Path -Path "C:\ProgramData\SmithMyers\tileserver-sm\4E93EAD9FEC3D306AEF36C3FECB2F188.txt" -PathType Leaf )
    {
        $prefect = Get-Childitem -Path "C:\ProgramData\SmithMyers\tileserver-sm" -Include *4E93EAD9FEC3D306AEF36C3FECB2F188* -Recurse | Select Directory

        $pre = $prefect | Out-String

        $pos = $pre.IndexOf(":")

        $right = $pre.Substring($pos-1)

        $righttrim = $right.Trim()

        $rightreplace = $righttrim -replace '\\','/'

        $rightdelete = $rightreplace -replace ':',''

        $ss = $rightdelete | Out-String

        $ss = $ss.Trim()

        Write-Output $ss

        $smithmyersData = "docker run --rm -it -v " + "/$($ss):/data" + " -p 8182:80 smithmyers/smtileserver"

        $smithmyersData | Out-File -FilePath $env:LOCALAPPDATA\serverDataPath.txt

        $runit = Get-Content -Path $env:LOCALAPPDATA\serverDataPath.txt

        Invoke-Expression -Command $runit
    }
    if ( Test-Path -Path "D:\SmithMyers\tileserver-sm\4E93EAD9FEC3D306AEF36C3FECB2F188.txt" -PathType Leaf )
    {
        $prefect = Get-Childitem -Path "D:\SmithMyers\tileserver-sm" -Include *4E93EAD9FEC3D306AEF36C3FECB2F188* -Recurse | Select Directory

        $pre = $prefect | Out-String

        $pos = $pre.IndexOf(":")

        $right = $pre.Substring($pos-1)

        $righttrim = $right.Trim()

        $rightreplace = $righttrim -replace '\\','/'

        $rightdelete = $rightreplace -replace ':',''

        $ss = $rightdelete | Out-String

        $ss = $ss.Trim()

        Write-Output $ss

        $smithmyersData = "docker run --rm -it -v " + "/$($ss):/data" + " -p 8182:80 smithmyers/smtileserver"

        $smithmyersData | Out-File -FilePath $env:LOCALAPPDATA\serverDataPath.txt

        $runit = Get-Content -Path $env:LOCALAPPDATA\serverDataPath.txt

        Invoke-Expression -Command $runit
    }
else
{
    Write-Warning "Could not find correct file path searching all drives for tileserver data. This may take sometime"

    $prefect = get-psdrive -p "FileSystem" ` | % {write-host -f Green "Searching " $_.Root;get-childitem $_.Root -include *4E93EAD9FEC3D306AEF36C3FECB2F188* -r ` | sort-object Length -descending} | Select -First 1 | Select Directory

    Write-Warning "Creating serverDataPath.txt file at %localappdata%"

    New-Item -Path "$($env:LOCALAPPDATA)\serverDataPath.txt"

    $pre = $prefect | Out-String

    $pos = $pre.IndexOf(":")

    $right = $pre.Substring($pos-1)

    $righttrim = $right.Trim()

    $rightreplace = $righttrim -replace '\\','/'

    $rightdelete = $rightreplace -replace ':',''

    $ss = $rightdelete | Out-String

    $ss = $ss.Trim()

    Write-Output $ss

    $smithmyersData = "docker run --rm -it -v " + "/$($ss):/data" + " -p 8182:80 smithmyers/smtileserver"

    $smithmyersData | Out-File -FilePath $env:LOCALAPPDATA\serverDataPath.txt

    $runit = Get-Content -Path $env:LOCALAPPDATA\serverDataPath.txt

    Invoke-Expression -Command $runit
}
