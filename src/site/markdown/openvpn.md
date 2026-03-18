# OpenVPN

## Information

### Introduction

OpenVPN is a versatile, open-source Virtual Private Network (VPN) software that provides secure, encrypted connections
over the internet. It can be used for site-to-site or point-to-point connections, allowing users to securely access
private networks from anywhere. It's known for its flexibility, strong security, and ability to traverse NAT and
firewalls.

### What is it for?

OpenVPN is primarily used for:

* **Remote Access:** Allowing employees or individuals to securely connect to a corporate or home network from a remote
  location.
* **Site-to-Site VPN:** Connecting two separate office networks over the internet as if they were one.
* **Privacy and Security:** Encrypting internet traffic to protect against snooping, especially on public Wi-Fi
  networks.
* **Bypassing Geo-restrictions:** Accessing content that might be restricted to specific geographic regions.

## Server Setup (Rocky Linux)

This guide describes how to set up an OpenVPN server on a Rocky Linux 8 or 9 machine without Docker.

### 1. Prerequisites

* A Rocky Linux server with root or sudo access.
* The EPEL repository must be enabled.

```bash
sudo dnf install epel-release -y
```

### 2. Install OpenVPN and Easy-RSA

Easy-RSA is a tool used to manage the Public Key Infrastructure (PKI) required for certificate-based authentication.

```bash
sudo dnf install openvpn easy-rsa -y
```

### 3. Set up the PKI (Public Key Infrastructure)

As a non-root user (for security), prepare the Easy-RSA directory:

```bash
mkdir ~/openvpn-ca
cd ~/openvpn-ca
ln -s /usr/share/easy-rsa/3/* .
chmod 700 ~/openvpn-ca
```

Initialize the PKI and build the Certificate Authority (CA):

```bash
./easyrsa init-pki
./easyrsa build-ca nopass
```

Generate the server certificate and private key:

```bash
./easyrsa gen-req server nopass
./easyrsa sign-req server server
```

Generate Diffie-Hellman parameters (this takes some time):

```bash
./easyrsa gen-dh
```

Generate a HMAC signature (TLS-Auth) key for extra security:

```bash
openvpn --genkey --secret ta.key
```

### 4. Configure the OpenVPN Server

Copy the generated certificates and keys to the OpenVPN directory:

```bash
sudo cp pki/ca.crt pki/issued/server.crt pki/private/server.key pki/dh.pem ta.key /etc/openvpn/server/
```

Create the server configuration file `/etc/openvpn/server/server.conf`:

```bash
sudo cp /usr/share/doc/openvpn/sample/sample-config-files/server.conf /etc/openvpn/server/
# Or create a minimal one:
cat <<EOF | sudo tee /etc/openvpn/server/server.conf
port 1194
proto udp
dev tun
ca ca.crt
cert server.crt
key server.key
dh dh.pem
auth SHA256
tls-auth ta.key 0
topology subnet
server 10.8.0.0 255.255.255.0
ifconfig-pool-persist ipp.txt
push "redirect-gateway def1 bypass-dhcp"
push "dhcp-option DNS 8.8.8.8"
push "dhcp-option DNS 8.8.4.4"
keepalive 10 120
cipher AES-256-GCM
user nobody
group nobody
persist-key
persist-tun
status openvpn-status.log
verb 3
explicit-exit-notify 1
EOF
```

### 5. Enable IP Forwarding

Enable IPv4 forwarding in the kernel:

```bash
echo 'net.ipv4.ip_forward = 1' | sudo tee /etc/sysctl.d/99-openvpn.conf
sudo sysctl --system
```

### 6. Firewall Configuration

Allow the OpenVPN port and enable masquerading:

```bash
sudo firewall-cmd --add-service=openvpn --permanent
sudo firewall-cmd --add-masquerade --permanent
sudo firewall-cmd --reload
```

### 7. Start and Enable OpenVPN

```bash
sudo systemctl enable --now openvpn-server@server
```

## Client Setup (Linux)

### 1. Install OpenVPN

On the client machine (e.g., another Rocky Linux, Fedora, or Ubuntu):

```bash
sudo dnf install openvpn -y  # Rocky/Fedora
# or
sudo apt install openvpn -y  # Ubuntu/Debian
```

### 2. Generate Client Certificate (On Server)

Back on the server (in your `~/openvpn-ca` directory):

```bash
cd ~/openvpn-ca
./easyrsa gen-req client1 nopass
./easyrsa sign-req client client1
```

### 3. Prepare the Client Configuration File

Gather the necessary files from the server:

* `ca.crt`
* `client1.crt`
* `client1.key`
* `ta.key`

Create a `.ovpn` configuration file for the client:

```bash
client
dev tun
proto udp
remote YOUR_SERVER_IP 1194
resolv-retry infinite
nobind
persist-key
persist-tun
remote-cert-tls server
auth SHA256
cipher AES-256-GCM
verb 3
<ca>
# Paste content of ca.crt here
</ca>
<cert>
# Paste content of client1.crt here
</cert>
<key>
# Paste content of client1.key here
</key>
<tls-auth>
# Paste content of ta.key here
</tls-auth>
key-direction 1
```

### 4. Connect to the Server

Run OpenVPN with your configuration file:

```bash
sudo openvpn --config client1.ovpn
```

Or, copy it to `/etc/openvpn/client/` and use systemd:

```bash
sudo cp client1.ovpn /etc/openvpn/client/
sudo systemctl start openvpn-client@client1
```

## Usage, tips and tricks

### Monitoring Connections

Check the status log to see who is connected:

```bash
sudo cat /etc/openvpn/server/openvpn-status.log
```

### Revoking Certificates

If a client's key is compromised:

```bash
cd ~/openvpn-ca
./easyrsa revoke client1
./easyrsa gen-crl
sudo cp pki/crl.pem /etc/openvpn/server/
```

Then add `crl-verify crl.pem` to your `server.conf`.

## See also

* [OpenVPN Official Website](https://openvpn.net/)
* [OpenVPN Community Wiki](https://community.openvpn.net/openvpn/wiki)
* [Rocky Linux Documentation](https://docs.rockylinux.org/)
