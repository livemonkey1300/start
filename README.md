<h1>OpenStack Speed Spin</h1>
<strong>Purpose</strong><br>
Spin up and openstack environment really fast<br>
Without having to relying on packstack from red had , the kolla project , tripplo or Ansible Openstack project<br>
<br>



<h1>Usage</h1>
1. modify the ip address in the folder /SysData/host

2. Run the script 1-passwordscript.sh This will generate random password for the configuration of your openstack environement

3. run the script from 2 - 8
   Those script will install the necessary services required create an openstack environment

4. To install your openstack environment the following order has to be followed
   1. Keystone - identidy service
   2. Glance - Image Services
   3. Nova - Compute and resources management 
   4. Neutron - Networking service - Processing Layer 2 ( Interface - Physical Mac Address ) and Processing Layer 3 ( IP - Subnet and Networking Address )
   5. Optional
      1. Horizon Dashboard - Python Flask Running Openstack Api - GUI to communicate with service end point
      2. Cinder Block - Manage Volume Storage for virtual machines


<h1>Project Status</h1>
<strong>Stopped</strong>

