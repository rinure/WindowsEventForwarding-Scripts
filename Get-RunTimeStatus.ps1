Clear-Host

Set-Location D:\XSEC\Scripts\PowerShell\Get-RuntimeStatus\

$Subscriptions = Invoke-Command -ScriptBlock {wecutil es}

$Server = $env:COMPUTERNAME

$Results = @()

foreach($Subscription in $Subscriptions)
    {
        $SubscriptionData = Invoke-Command -ScriptBlock {wecutil gr $Subscription}
        
        $SubscriptionData = $SubscriptionData[5..($SubscriptionData.Count)] | ForEach-Object { ($_.Trim()).ToUpper() }

        for($x = 0; $x -le $SubscriptionData.Count; $x++)
            {
                Write-Host "Evaluating Line..." $SubscriptionData[$x] -ForegroundColor Green

                if($SubscriptionData[$x] -match "^.*\..*\.live$")
                    {
                        $Hostname = $SubscriptionData[$x]

                        $RunTimeStatus = ""
                        $LastError = ""
                        $LastHeartbeatTime = ""

                        for($y = $x + 1; $y -le $SubscriptionData.Count; $y++)
                            {
                                if($SubscriptionData[$y] -match "^RunTimeStatus\:.*$")
                                    {
                                        $RunTimeStatus = ($SubscriptionData[$y].Split(" "))[1]
                                    }
                                elseIf($SubscriptionData[$y] -match "^LastError\:.*$")
                                    {
                                        $LastError = ($SubscriptionData[$y].Split(" "))[1]
                                    }
                                elseIf($SubscriptionData[$y] -match "^LastHeartbeatTime\:.*$")
                                    {
                                        $LastHeartbeatTime = ($SubscriptionData[$y].Split(" "))[1]
                                    }
                                else
                                    {
                                        break
                                    }
                            }

                        $RunTimeObject = New-Object PSObject
                            $RunTimeObject | Add-Member -Name "SERVER" -MemberType NoteProperty -Value $Server
                            $RunTimeObject | Add-Member -Name "SUBSCRIPTION" -MemberType NoteProperty -Value $Subscription
                            $RunTimeObject | Add-Member -Name "HOSTNAME" -MemberType NoteProperty -Value $Hostname
                            $RunTimeObject | Add-Member -Name "RUNTIMESTATUS" -MemberType NoteProperty -Value $RunTimeStatus
                            $RunTimeObject | Add-Member -Name "LASTERROR" -MemberType NoteProperty -Value $LastError
                            $RunTimeObject | Add-Member -Name "LASTHEARTBEATTIME" -MemberType NoteProperty -Value $LastHeartbeatTime

                        $Results += $RunTimeObject 
                    }
            }
    }
    
    $FileDate = Get-Date -Format _yyyy_MM_dd
    $FileName = "\\bn1mincosmih503\e$\ArcSight\data\RuntimeStatus\$Server$FileDate.csv"
    $Results | Export-Csv -NoTypeInformation -Path $FileName