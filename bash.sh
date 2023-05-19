grep -r "werk" /home


ping_sweep.sh
for i in $(seq 254); do ping 172.16.0.$i -c1 -W1 & done | grep from


userlist_sharp.sh
cat 20230503201311_users.json | grep -oP '(?<="name":")[^"]{0,25}' > user 
sed 's/@.*//' user > users

