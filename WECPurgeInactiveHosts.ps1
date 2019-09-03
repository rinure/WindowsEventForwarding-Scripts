# Powershell Script
# Writen by Ted Hardy (MSIT)
# Updated by Rin Ure (XSEC) XBOX LIVE Security
# Date: Augest 4th 2014
# Script for Pruning WEC Hosts from Registry

$reg_root = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\EventCollector\Subscriptions"

$init_date = Get-Date "1/1/1601"

$max_days_since_checkin = 1;

$date_to_compare = (Get-Date).AddDays(-$max_days_since_checkin)
$date_to_compare = $date_to_compare.AddTicks(-$init_date.ticks)

$ts = New-Object System.TimeSpan($date_to_compare.ticks)

$milliseconds_to_compare = $ts.TotalMilliseconds * 10000

$subscriptions = Get-ChildItem $reg_root
$subscriptions | %{
	$subscription = $_.PSChildName
    Write-Host ("Starting cleanup on $subscription")
	$sub_path = $reg_root + "\$subscription\EventSources"
    $totalcount = 0
    $sourcecount = 0
	Get-ChildItem $sub_path | %{
		$machine = $reg_root + "\$subscription\EventSources\" + $_.PSChildName
		$lastheartbeat = (Get-ItemProperty -Path $machine).LastHeartbeatTime
        $totalcount++
        if (($totalcount % 1000) -eq 0)
        {
            Write-Host ("    Still processing...$totalcount")
        }
        if($lastheartbeat -lt $milliseconds_to_compare)
		{
            $sourcecount++
			# Delete the key
			Remove-Item -Path $machine
		}
	}
    Write-Host ("$subscription : Cleaned up $sourcecount out of $totalcount")
} 