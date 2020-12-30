# Address/FQDN Resolution Script
# Made by aa@aztek.xyz
# Please send any bugs/questions to aa@aztek.xyz

# Clears Output file and creates file if it doesnt exist
Clear-Content -Path .\output.csv -ErrorAction SilentlyContinue
Add-Content -Path .\output.csv -Value "Address/FQDN,Resolution"

# Keeps Track of any resolution errors
$error_count = 0

$file_lines = (Get-Content -Path .\addresses_fqdns.txt | Measure-Object -Line).lines

IF($file_lines -eq 1){
    Write-Host "There is $file_lines Address/FQDN in addresses_fqdns.txt"
    Read-Host "Press enter to continue"
}
ELSE{
    Write-Host "There is $file_lines Addresses/FQDNs in addresses_fqdns.txt"
    Read-Host "Press enter to continue"
}


Get-content -path .\addresses_fqdns.txt | foreach-object {
    Write-Host "Working on $_..."
    $address = resolve-dnsname $_  -ErrorAction SilentlyContinue -ErrorVariable ProcessError -QuickTimeout

    IF($ProcessError) {
        Write-Host "Resolution error with $_!" -ForegroundColor Red
        Add-Content -path .\output.csv -value "$_,RESOLUTION_ERROR"
        $name = "IPERROR"

        # adds +1 for each error
        $error_count += 1
    }
    IF($name -ne "IPERROR") {
        $name = $address.name
        $ipaddress = $address.ipaddress
        $hostname = $address.NameHost

        IF($ipaddress -eq $null){
            Add-Content -path .\output.csv -value "$_,$hostname"
        }
        ELSE{
            Add-Content -path .\output.csv -value "$name,$ipaddress"
        }
        
    }
}
Write-Host
If($error_count -eq 1){
    Write-Host "Done! There was $error_count DNS resolution error"
    }
elseif($error_count -gt 1){
    Write-Host "Done! There was $error_count DNS resolution errors"
    }
else {
    Write-Host "Done!"
}
Write-Host