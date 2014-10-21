
$fvp_server = "pernixmgmtserver"
$fvp_username = "domain\user"
$vms = "vm1", "vm2"
$passwordfile = "c:\users\me\fvp_enc.txt"

import-module prnxcli



if (!(Test-path $passwordfile))
{
	$securestring = get-credential
	$secureString.password | ConvertFrom-SecureString | set-content $passwordfile
}

Try { 
	write-host "Opening $passwordfile"	
	$fvp_enc_pass = Get-Content $passwordfile | ConvertTo-SecureString
	}
Catch { 
		write-host "Error retrieving encrypted password"
		Exit 1
	}

Try { 
		$credential = New-Object System.Management.Automation.PsCredential($fvp_username, $fvp_enc_pass)
	}
Catch {
		write-host "Error creating credential object"
		Exit 1
	}

write-host "Connecting to FVP Management Server: $fvp_server"
Try {
		Connect-PrnxServer $fvp_server -Credentials $credential -ea Stop > $null
	}
Catch {
		write-host "Error connecting to FVP Management Server: $($_.Exception.Message)"
		exit 1
    }
#Loop through the list of VMs and set each to be blacklisted, wait 10 seconds then add them back to cluster in WB
foreach ($vm in $vms) 
{
	write-host "Blacklisting $vm to invalidate cache"
	Set-PrnxProperty $vm -Name cachePolicy –value 1
	Start-Sleep -Seconds 10
	write-host "Adding VM $vm back to FVP cluster in write back"
	Set-PrnxProperty $vm -Name cachePolicy -Value 3
	Set-PrnxAccelerationPolicy -name $vm -WB -NumWBPeers 1 -NumWBExternalPeers 0
}

Disconnect-PrnxServer