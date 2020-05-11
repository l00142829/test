Import-Module "Servermanager" 
Add-WindowsFeature AD-Domain-Services, DNS -IncludeManagementTools

$netbiosname = 'MMproject'
$fqdomname = 'MMproject.local'
$NTDSPath = 'c:\ntds'
$NTDSLogPath = 'c:\ntdslogs'
$SYSVOLPath = 'c:\sysvol'

$SafePassPlain = 'Pa55word'
$SafePass = ConvertTo-SecureString -string $SafePassPlain `
    -AsPlainText -force

Install-ADDSForest -DomainName $fqdomname -DomainNetBIOSName $netbiosname `
    -SafemodeAdministratorPassword $SafePass -SkipPreChecks `
    -InstallDNS:$true -SYSVOLPath $SysvolPath -DatabasePath $NTDSPath -LogPath $NTDSLogpath `
    -Force


