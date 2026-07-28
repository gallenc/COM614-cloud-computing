# testing dhcp

see https://serverfault.com/questions/171744/command-line-program-to-test-dhcp-service


sudo apt install nmap

sudo nmap --script broadcast-dhcp-discover


nmap --script broadcast-dhcp-discover -e eth0


