# Powershell Script
# Writen by Rin Ure (XSEC) XBOX LIVE Security
# Date: Feb 11th 2014
# WEC Coverage

$servers = @("machine1.contoso.com", "machine2.contoso.com", "machine3.contoso.com", "machine4.contoso.com");

$date = Get-Date -format u | %{ $_.Split(' ')[0]; }

If (Test-Path -Path "D:\Wec Coverage Logs\$date")
{
    rmdir "D:\WEC Coverage Logs\$date"
} else {
    mkdir "D:\WEC Coverage Logs\$date"
}

$file = "D:\WEC Coverage Logs\$date\wec_subscription_coverage_output.txt"

foreach ($server in $servers)
{
	write-output "$server,XSYSTEM,TOTAL,ACTIVE,INACTIVE,PARTNER,NONPROD,PROD" | out-file $file -append

   	$XSYSTEM_Total    = winrs -r:$server wecutil gs XSYSTEM | findstr "Address" | wc -l
	$XSYSTEM_Active   = winrs -r:$server wecutil gr XSYSTEM | findstr "Active" | wc -l
	$XSYSTEM_Inactive = winrs -r:$server wecutil gr XSYSTEM | findstr "Inactive" | wc -l
	$XSYSTEM_PROD     = winrs -r:$server wecutil gr XSYSTEM | findstr ".prod.live" | wc -l
	$XSYSTEM_NONPROD  = winrs -r:$server wecutil gr XSYSTEM | findstr ".nonprod.live" | wc -l
	$XSYSTEM_PARTNER  = winrs -r:$server wecutil gr XSYSTEM | findstr ".partner.live" | wc -l

	$total    = $XSYSTEM_Total.Substring(7)
	$active   = $XSYSTEM_Active.Substring(7)
	$inactive = $XSYSTEM_Inactive.Substring(7)
	$partner  = $XSYSTEM_PARTNER.Substring(7)
	$nonprod  = $XSYSTEM_NONPROD.Substring(7)
	$prod     = $XSYSTEM_PROD.Substring(7)

	write-output "$server,XSYSTEM,$total,$active,$inactive,$partner,$nonprod,$prod" | out-file $file -append
}
