## PernixData PowerShell Script to Invalidate Cache

## Version

1.0

## About
Created to clear a VM's cached data in a PernixData FVP cluster. May be necessary when the data cached by the VM has polluted the working set. 

## Instructions

* Clone repo and copy to PernixData management server or VM with PernixData PowerShell cmdlets
* Edit variables for:

* FVP Server Name
* FVP Username
* List of VMs
* Path to password file that you're going to use for authentcation
* NumWBPeers (0-2) and NumWBExternalPeers (if using fault domains)

* Run in PowerShell command prompt or add as a scheduled task if fitting for use case.

## TODO

* Get VMs in write back from FVP cluster
* Transition these VMs to write through
* Verify state changes