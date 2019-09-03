# Powershell Script
# Writen by Rin Ure (XSEC) XBOX LIVE Security
# Date: April 18th 2014
# WEC Client Server Connection Test Script

$x = 0
$y = 0

$date = Get-Date -format u | %{ $_.Split(' ')[0]; }
$WECServer = "machine1.contoso.com"

If (Test-Path -Path "D:\Wec Coverage Logs\$date")
{
    # rmdir "D:\WEC Coverage Logs\$date"
} else {
    mkdir "D:\WEC Coverage Logs\$date"
}

$file1 = "D:\WEC Coverage Logs\$date\Connect_to_WEC_LogOutput.txt"
$file2 = "D:\WEC Coverage Logs\$date\Connect_to_WEC_CountersOutput.txt"

for (;;)
{
    $timestamp = @{}
    $timestamp = Get-Date -Format o

    $error.clear()
    $response = invoke-command {winrm id -r:$hostname -auth:none} -ErrorAction silentlycontinue

    If (!$response)
    {
        $x++
        [string]$errorstring = $error[1]
        $errorlist = $errorstring.split(' ')
        $decimalerror = $errorlist[3].trim('\n')
        $hexerror = $errorlist[4].trim('\n')

        $testport = invoke-command {portqry -n $hostname -e 5985} -ErrorAction SilentlyContinue
        
        write-output "$timestamp,machine1.contoso.com,-->,$WECServer,WSManFault,$decimalerror,$hexerror" | out-file $file1 -append
        Write-Output "$timestamp,machine1.contoso.com,-->,$WECServer,PORTTest,$testport" | out-file $file1 -append
        Write-Output "SLC Date($timestamp) Failed WinRM Connection Test ($x) Times" | out-file $file2
    } 
    Else 
    {
        $y++
        Write-Output "$timestamp,machine1.contoso.com,-->,$WECServer,Healthy,0,0" | out-file $file1 -append
        Write-Output "SLC Date($timestamp) Successful WinRM Connection Test ($y) Times" | out-file $file2
    }

    Sleep 120
}

