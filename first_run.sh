# first_run.sh
#!/bin/bash
flag_path=/data
flag_file=$flag_path/first_run

echo "Running setup script"

if [ ! -f "$flag_file" ]; then    
    curl https://install.zerotier.com/ | bash 

    sleep 2 && zerotier-cli join $1
    
    echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf
    export ZT_IF=$(ip link show |  grep -Po '^\d+: \K[^:]+' | grep zt)
    export WAN_IF=$2

    iptables -t nat -A POSTROUTING -o $WAN_IF -j MASQUERADE
    iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
    iptables -A FORWARD -i $ZT_IF -o $WAN_IF -j ACCEPT

    netfilter-persistent save
    iptables-save && iptables-legacy-save
    mkdir -p "$flag_path" && touch "$flag_file"
fi

zerotier-one -d
sleep 5 && zerotier-cli listnetworks
echo "Sleeping infinitely"
sleep infinity
