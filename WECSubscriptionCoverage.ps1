# Powershell Script
# Writen by Rin Ure (XSEC) XBOX LIVE Security
# Date: Feb 11th 2014
# WEC Coverage

$servers = @("RR1MINACONIH801.MGMT.LIVE", "CO1MINACONIH811.MGMT.LIVE", "CO1MINACONIH812.MGMT.LIVE", "CO1MINACONIH813.MGMT.LIVE", "CO1MINACONIH814.MGMT.LIVE", "BN1MINACONIH509.MGMT.LIVE", "BLUMINACONIH501.MGMT.LIVE");

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
	write-output "$server,XSYSTEM,TOTAL,ACTIVE,INACTIVE,PARTNER,CORE,CERT,MGMT,NONPROD,PROD,RIO" | out-file $file -append

    $XSYSTEM_Total    = winrs -r:$server wecutil gs XSYSTEM | findstr "Address" | wc -l
	$XSYSTEM_Active   = winrs -r:$server wecutil gr XSYSTEM | findstr "Active" | wc -l
	$XSYSTEM_Inactive = winrs -r:$server wecutil gr XSYSTEM | findstr "Inactive" | wc -l
	$XSYSTEM_PROD     = winrs -r:$server wecutil gr XSYSTEM | findstr ".prod.live" | wc -l
	$XSYSTEM_MGMT     = winrs -r:$server wecutil gr XSYSTEM | findstr ".mgmt.live" | wc -l
	$XSYSTEM_RIO      = winrs -r:$server wecutil gr XSYSTEM | findstr ".RIO.LIVE" | wc -l
	$XSYSTEM_NONPROD  = winrs -r:$server wecutil gr XSYSTEM | findstr ".nonprod.live" | wc -l
	$XSYSTEM_CERT     = winrs -r:$server wecutil gr XSYSTEM | findstr ".cert.live" | wc -l
	$XSYSTEM_CORE     = winrs -r:$server wecutil gr XSYSTEM | findstr ".core.live" | wc -l
	$XSYSTEM_PARTNER  = winrs -r:$server wecutil gr XSYSTEM | findstr ".partner.live" | wc -l

	$total    = $XSYSTEM_Total.Substring(7)
	$active   = $XSYSTEM_Active.Substring(7)
	$inactive = $XSYSTEM_Inactive.Substring(7)
	$partner  = $XSYSTEM_PARTNER.Substring(7)
	$core     = $XSYSTEM_CORE.Substring(7)
	$cert     = $XSYSTEM_CERT.Substring(7)
	$mgmt     = $XSYSTEM_MGMT.Substring(7)
	$nonprod  = $XSYSTEM_NONPROD.Substring(7)
	$prod     = $XSYSTEM_PROD.Substring(7)
	$rio      = $XSYSTEM_RIO.Substring(7)

	write-output "$server,XSYSTEM,$total,$active,$inactive,$partner,$core,$cert,$mgmt,$nonprod,$prod,$rio" | out-file $file -append
}