##########################
#Made By: Ariel Mark
#Date: 25/07/2021
#Company: IBM
#
##########################



#what the script does:
#download exe file and install the PostgreSQL.
#add user aidocapp with Password aidcopass


# download PostgreSQL exe file
$TempInstall = 'C:\Users\Administrator\Downloads\postgresql-9.3.5-1-windows-x64.exe'
$url = 'http://get.enterprisedb.com/postgresql\postgresql-9.3.5-1-windows-x64.exe'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

write-host "Start Download PostgreSQL.exe file " -ForegroundColor Green

Start-Sleep -Seconds 2

Invoke-WebRequest -Uri $url -OutFile $TempInstall -UseBasicParsing


#serach the file
$Install = Get-ChildItem -Path C:\users\Administrator\Downloads | Where-Object -Property name -Like "postgresql*.exe" | Select-Object name



$app = Test-Path -Path C:\Users\Administrator\Downloads\postgresql-9.3.5-1-windows-x64.exe 

Write-Host -ForegroundColor Yellow "Waiting for the file to finish download ..."

# Waiting for the file to finish download
Do  
{

write-host $app 
         
} until($app -eq "true")  

Write-Host -ForegroundColor Yellow "The file has finished downloading"

Start-Sleep -Seconds 2


Write-Host "Start The Installation ... " -ForegroundColor Green

Start-Sleep 2

#install command 
C:\users\Administrator\Downloads\postgresql*.exe --mode unattended --superaccount aidocapp --superpassword aidcopass 



 $started = $false

Do {

    $status = Get-Process postgres -ErrorAction SilentlyContinue

    If (!($status)) { Write-Host 'Waiting for process to start' ; Start-Sleep -Seconds 1 }
    
    Else { Write-Host 'Process has started' ; $started = $true }

}
Until ( $started )


#Checks if the installation was installed successfully 
$software = "PostgreSQL*";
$installed = (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where { $_.DisplayName -like $software })


if ($Install -match $software) {
Write-Host "PostgreSQL has been installed" -ForegroundColor Green
}

else{
Write-Host "PostgreSQL not installed" -ForegroundColor Red
}
