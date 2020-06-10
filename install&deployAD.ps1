Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force
Import-Module "ServerManager" 


$netbiosname = 'MMproject'
$fqdomname = 'MMproject.local'
$NTDSPath = 'c:\ntds'
$NTDSLogPath = 'c:\ntdslogs'
$SYSVOLPath = 'c:\sysvol'

$SafePassPlain = 'Pa55word'
$SafePass = ConvertTo-SecureString -string $SafePassPlain `
    -AsPlainText -force

Install-WindowsFeature AD-Domain-Services -IncludeAllSubFeature -IncludeManagementTools
Install-WindowsFeature DNS -IncludeAllSubFeature -IncludeManagementTools


Import-Module ADDSDeployment
Import-Module DnsServer


Install-ADDSForest -DomainName $fqdomname -DomainNetBIOSName $netbiosname `
    -SafemodeAdministratorPassword $SafePass -SkipPreChecks `
    -InstallDNS:$true -SYSVOLPath $SysvolPath -DatabasePath $NTDSPath -LogPath $NTDSLogpath `
    -Force


