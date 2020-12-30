# Address/FQDN Resolution Script
This script is to help resolve multiple IPs and FQDNs using powershell and place the output into a CSV.
This script works on both IP Addresses and FQDNs.

## How to run
* Clone this and cd into the dir.
* In the file addresses_fqdns.txt, place each address or FQDN into one line, one line per entry.
* Run the PowerShell script from the terminal example - `.\addresses_fqdns_resolution_script.ps1`
* This will make a new Output.csv with the completed output
  * If you run the script again with the Output.csv file in this dir, the script will clean the Output.csv file and replace teh contents with the new output

## Questions
Please send any questions about this script to aa@aztek.xyz