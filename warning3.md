# warning when deploying

Watch your deployment at https://fly.io/apps/soal-csugm/monitoring

Provisioning ips for soal-csugm
  Dedicated ipv6: 2a09:8280:1::9c:ca39:0
  Shared ipv4: 66.241.124.170
  Add a dedicated ipv4 with: fly ips allocate-v4

This deployment will:
 * create 2 "app" machines

No machines in group app, launching a new machine

WARNING The app is not listening on the expected address and will not be reachable by fly-proxy.
You can fix this by configuring your app to listen on the following addresses:
  - 0.0.0.0:8080
Found these processes inside the machine with open listening sockets:
  PROCESS        | ADDRESSES                              
-----------------*----------------------------------------
  /.fly/hallpass | [fdaa:2d:a501:a7b:469:5f7a:9bad:2]:22  

Creating a second machine to increase service availability
Finished launching new machines
-------
NOTE: The machines for [app] have services with 'auto_stop_machines = "stop"' that will be stopped when idling

-------
Checking DNS configuration for soal-csugm.fly.dev

Visit your newly deployed app at https://soal-csugm.fly.dev/