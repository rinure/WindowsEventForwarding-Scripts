﻿# Powershell Script
# Writen by Rin Ure (XSEC) XBOX LIVE Security
# Date: Jan 17th 2014

$servers = @("machine1.contoso.com", "machine2.contoso.com", "machine3.contoso.com");

$file = "D:\WEC Coverage Logs\wec_coverage_output.txt"

foreach ($server in $servers)
{
    $drop_domain = $server.trim('.MGMT.LIVE')
    $subscription1 = [string]::join('', ($drop_domain, 'sub1'))
    $subscription2 = [string]::join('', ($drop_domain, 'sub2'))
    $subscription3 = [string]::join('', ($drop_domain, 'sub3'))
    $subscription4 = [string]::join('', ($drop_domain, 'sub4'))
    $subscription5 = [string]::join('', ($drop_domain, 'sub5'))
    $subscription6 = [string]::join('', ($drop_domain, 'sub6'))

    $host1 = winrs -r:$server wecutil gs $subscription1 | findstr "Address" | %{ $_.Split(' ')[1]; }
    $host2 = winrs -r:$server wecutil gs $subscription2 | findstr "Address" | %{ $_.Split(' ')[1]; }
    $host3 = winrs -r:$server wecutil gs $subscription3 | findstr "Address" | %{ $_.Split(' ')[1]; }
    $host4 = winrs -r:$server wecutil gs $subscription4 | findstr "Address" | %{ $_.Split(' ')[1]; }
    $host5 = winrs -r:$server wecutil gs $subscription5 | findstr "Address" | %{ $_.Split(' ')[1]; }
    $host6 = winrs -r:$server wecutil gs $subscription6 | findstr "Address" | %{ $_.Split(' ')[1]; }
    
    write-output "Server,$server,Subscription:$serverXAPPLICATION" | out-file $file -append

    foreach ($host in $hosts1) {
        $error.clear()
    
	    $response = invoke-command {winrm id -r:$host -auth:none} -ErrorAction silentlycontinue
    
        If (!$response)
        {
            $errorlist = $error[1].Split(' ')
            $decimalerror = $errorlist[3].trim('\n')
            $hexerror = $errorlist[4].trim('\n')
            write-output "$server,WSManFault,$decimalerror,$hexerror" | out-file $file -append
        } Else {
            write-output "$server,Healthy,0,0" | out-file $file -append
        }
    }

    foreach ($host in $hosts2) {
        $error.clear()
    
	    $response = invoke-command {winrm id -r:$host -auth:none} -ErrorAction silentlycontinue
    
        If (!$response)
        {
            $errorlist = $error[1].Split(' ')
            $decimalerror = $errorlist[3].trim('\n')
            $hexerror = $errorlist[4].trim('\n')
            write-output "$server,WSManFault,$decimalerror,$hexerror" | out-file $file -append
        } Else {
            write-output "$server,Healthy,0,0" | out-file $file -append
        }
    }

    foreach ($host in $hosts3) {
        $error.clear()
    
	    $response = invoke-command {winrm id -r:$host -auth:none} -ErrorAction silentlycontinue
    
        If (!$response)
        {
            $errorlist = $error[1].Split(' ')
            $decimalerror = $errorlist[3].trim('\n')
            $hexerror = $errorlist[4].trim('\n')
            write-output "$server,WSManFault,$decimalerror,$hexerror" | out-file $file -append
        } Else {
            write-output "$server,Healthy,0,0" | out-file $file -append
        }
    }

    foreach ($host in $hosts4) {
        $error.clear()
    
	    $response = invoke-command {winrm id -r:$host -auth:none} -ErrorAction silentlycontinue
    
        If (!$response)
        {
            $errorlist = $error[1].Split(' ')
            $decimalerror = $errorlist[3].trim('\n')
            $hexerror = $errorlist[4].trim('\n')
            write-output "$server,WSManFault,$decimalerror,$hexerror" | out-file $file -append
        } Else {
            write-output "$server,Healthy,0,0" | out-file $file -append
        }
    }
    
    foreach ($host in $hosts5) {
        $error.clear()
    
	    $response = invoke-command {winrm id -r:$host -auth:none} -ErrorAction silentlycontinue
    
        If (!$response)
        {
            $errorlist = $error[1].Split(' ')
            $decimalerror = $errorlist[3].trim('\n')
            $hexerror = $errorlist[4].trim('\n')
            write-output "$server,WSManFault,$decimalerror,$hexerror" | out-file $file -append
        } Else {
            write-output "$server,Healthy,0,0" | out-file $file -append
        }
    }
    
    foreach ($host in $hosts6) {
        $error.clear()
    
	    $response = invoke-command {winrm id -r:$host -auth:none} -ErrorAction silentlycontinue
    
        If (!$response)
        {
            $errorlist = $error[1].Split(' ')
            $decimalerror = $errorlist[3].trim('\n')
            $hexerror = $errorlist[4].trim('\n')
            write-output "$server,WSManFault,$decimalerror,$hexerror" | out-file $file -append
        } Else {
            write-output "$server,Healthy,0,0" | out-file $file -append
        }
    }
}l
