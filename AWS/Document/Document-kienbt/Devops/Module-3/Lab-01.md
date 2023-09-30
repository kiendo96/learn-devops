## Getting Started with Ansible

In this hands-on lab, we'll install Ansible on a control node and configure two managed servers for use with Ansible. We will also create a simple inventory and run an Ansible command to verify our configuration is correct.

![topologylab1](images/topologylab1.png)

Install Ansible on the Control Node
```
vagrant ssh `HOSTNAME`
```
To install Ansible on the control node:
```
sudo yum install ansible
```
Configure the ansible User on the Control Node

Next, we'll configure the ansible user on the control node for ssh shared key access to managed nodes.

Note: Do not use a passphrase for the key pair.

Create a key pair for the ansible user on the control host, accepting the defaults when prompted:
```
sudo su - ansible
ssh-keygen
```
Copy the public key to both node1 and node2:
```
ssh-copy-id node1
ssh-copy-id node2
```
Create a Simple Ansible Inventory

Next, we'll create a simple Ansible inventory on the control node in /home/ansible/inventory containing node1 and node2.

On the control host:
```
sudo su - ansible
touch /home/ansible/inventory
echo "node1" >> /home/ansible/inventory
echo "node2" >> /home/ansible/inventory
```
Configure sudo Access for Ansible

Now, we'll configure sudo access for Ansible on node1 and node2 such that Ansible may use sudo for any command with no password prompt.

Log in to node1 as `vagrant` and edit the sudoers file to contain appropriate access for the ansible user:
```
ssh vagrant@node1
sudo visudo
```
Add the following line to the file and save:
```
ansible    ALL=(ALL)       NOPASSWD: ALL
```
Enter:


logout
Repeat these steps for node2, and then back out to the control node.

Verify Each Managed Node Is Accessible

Finally, we'll verify each managed node is able to be accessed by Ansible from the control node using the ping module.

Redirect the output of a successful command to /home/ansible/output.

To verify each node, run the following as the ansible user from the control host:
```
ansible -i /home/ansible/inventory node1 -m ping
ansible -i /home/ansible/inventory node2 -m ping
```
To redirect output of a successful command to /home/ansible/output:
```
ansible -i /home/ansible/inventory node1 -m ping > /home/ansible/output
```
Conclusion

Congratulations on completing this lab!