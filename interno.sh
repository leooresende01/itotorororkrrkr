rm -f interno.logs
IP1=$(curl -s "192.168.0.1/cgi-bin-igd/netcore_get.cgi"  -u admin:1977 | tr -s "," "\n" | grep '"dmz_ip"' | cut -d '"' -f4)

IP2=$(ifconfig ens32 | grep "inet " | grep -o inet............................... | cut -d' ' -f2 | cut -d':' -f2)

CheckIP=$(echo "$IP1" | grep -c "$IP2")

case $CheckIP in
   1)echo "IP INTERNO OK" >> interno.logs
   ;;
   
   0)NADA=$(curl -s "192.168.0.1/cgi-bin-igd/netcore_set.cgi" -d "mod_name=netcore_set&dmz_enable=1&dmz_ip=$IP2&dmz_set=1" -u admin:1977)
   echo "IP INTERNO CORRIGIDO" >> interno.logs
   ;;
esac
   
