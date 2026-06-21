# Ansible

## Information

Ansible is an agentless IT automation tool that uses SSH (or WinRM for Windows) to configure systems, deploy
applications, and orchestrate multi-step workflows. Playbooks are written in YAML, making them human-readable and
easy to version-control. No agent software is required on managed nodes — only Python and an SSH server.

Key concepts:

* **Inventory** — list of managed hosts, organized into groups.
* **Playbook** — ordered list of plays; each play targets a host group and runs tasks.
* **Task** — a single call to an Ansible module (e.g. install a package, copy a file, start a service).
* **Module** — reusable unit of work (`dnf`, `apt`, `copy`, `template`, `service`, `user`, etc.).
* **Role** — reusable, self-contained playbook component with its own tasks, handlers, variables, and templates.

## Installation

### CentOS / Rocky Linux

```shell
sudo dnf install -y ansible
```

### Fedora

```shell
sudo dnf install -y ansible
```

### Debian / Ubuntu

```shell
sudo apt-get install -y ansible
```

### pip (any platform)

```shell
pip install ansible
ansible --version
```

## Configuration

### ansible.cfg

```ini
[defaults]
inventory      = ./hosts
remote_user    = deploy
private_key_file = ~/.ssh/id_rsa
host_key_checking = False
```

### Inventory file (`hosts`)

```ini
[webservers]
web1.example.com
web2.example.com

[dbservers]
db1.example.com ansible_user=dbadmin
```

### Vault for secrets

```shell
export EDITOR=nano
ansible-vault create secret.yml
ansible-vault edit secret.yml
```

Example `secret.yml` content:

```yaml
ansible_sudo_pass: "secretpassword"
ansible_ssh_pass: "sshpassword"
ansible_user: someusername
```

## Usage, tips and tricks

### Playbook structure

```yaml
---
- name: Configure web servers
  hosts: webservers
  become: true
  vars:
    app_port: 8080
  tasks:
    - name: Install nginx
      ansible.builtin.dnf:
        name: nginx
        state: present

    - name: Start and enable nginx
      ansible.builtin.service:
        name: nginx
        state: started
        enabled: true

    - name: Copy config file
      ansible.builtin.template:
        src: nginx.conf.j2
        dest: /etc/nginx/nginx.conf
      notify: Restart nginx

  handlers:
    - name: Restart nginx
      ansible.builtin.service:
        name: nginx
        state: restarted
```

### Run a playbook

```shell
ansible-playbook --ask-pass playbook.yml
ansible-playbook -i hosts --vault-password-file .vault_pass playbook.yml
```

### Ad-hoc commands

```shell
# Ping all hosts
ansible all -m ping
# Run a command
ansible webservers -a "uptime"
# Install a package
ansible dbservers -m dnf -a "name=postgresql state=present" --become
```

### Common modules

| Module                  | Purpose                                        |
|-------------------------|------------------------------------------------|
| `ansible.builtin.dnf`   | Manage packages on RPM-based distros           |
| `ansible.builtin.apt`   | Manage packages on Debian-based distros        |
| `ansible.builtin.copy`  | Copy files to remote hosts                     |
| `ansible.builtin.template` | Render Jinja2 templates to remote hosts     |
| `ansible.builtin.service` | Start, stop, enable systemd services         |
| `ansible.builtin.user`  | Create and manage user accounts                |
| `ansible.builtin.file`  | Manage files, directories, and symlinks        |

## See also

* [Ansible documentation](https://docs.ansible.com/)
* [Ansible Galaxy (roles)](https://galaxy.ansible.com/)
* [Become (privilege escalation)](https://docs.ansible.com/ansible/2.7/user_guide/become.html)
* [Shell](shell.md)
