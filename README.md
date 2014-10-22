## PernixData PowerShell Script to Invalidate Cache

## Version

1.0

## About
Created to clear a VM's cached data in a PernixData FVP cluster. 

## Instructions

Clone repo and copy to PernixData management server or VM with PernixData PowerShell cmdlets

```sh
git clone [git-repo-url] prnx-invalidate-cache
cd prnx-invalidate-cache
```
Edit variables for:

* FVP Server Name
* FVP Username
* List of VMs
* Path to password file that you're going to use for authentcation
* NumWBPeers (0-2) and NumWBExternalPeers (if using fault domains)

## TODO

* Get VMs in write back from FVP cluster
** Transition these VMs to write through
** Verify state changes