# PowerShell
This repository features some of my PowerShell code and my wee ps-reference

**Enable PS Script execution on Windows**

If your powershell on Windows complains that it is not allowed to run scripts, then follow these steps:
1) Run Powershell as Administrator
2) Determine what the execution policy is set to:
Get-ExecutionPolicy
(By default, it is set to "restricted")
3) To loosen this condition, run this command:
Set-ExecutionPolicy remotesigned
(This change can only be conducted by admins)
4) Restart powershell (doesn't have to be as Admin)
5) Run a powershell script (Now it should work)
