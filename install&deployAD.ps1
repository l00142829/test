Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force

Import-Module "ServerManager" 

$Param_Details = @{
    CreateDnsDelegation = $false
    DatabasePath = 'C:\Windows\NTDS'
    DomainMode = 'Windows Server 2016'
    DomainName = 'Management-Project.local'
    DomainNetbiosName = 'MIKEFROBBINS'
    ForestMode = 'Windows Server 2016'
    InstallDns = $true
    LogPath = 'C:\Windows\NTDS'
    NoRebootOnCompletion = $false
    SafeModeAdministratorPassword = $P@ssw0rd
    SysvolPath = 'C:\Windows\SYSVOL'
    Force = $true
    
}

Get-NetAdapter
New-NetIPAddress -InterfaceIndex -IPAddress 192.168.227.140 -DefaultGateway 192.168.227.2 -PrefixLength 24

Set-DNSClientServerAddress -InterfaceIndex 18 -ServerAddresses ('192.168.227.140','127.0.0.1')

Disable-NetAdapterBinding -Name 'Ethernet0' -ComponentID 'ms_tcpip6'

Install-WindowsFeature AD-Domain-Services -IncludeAllSubFeature -IncludeManagementTools
Install-WindowsFeature DNS -IncludeAllSubFeature -IncludeManagementTools


Import-Module ADDSDeployment
Import-Module DnsServer


Install-ADDSForest @Param_Details


