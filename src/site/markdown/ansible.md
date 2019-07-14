# Ansible

## Information

## Installation

### CentOS

    yum -y install ansible

## Configuration

    export EDITOR=nano
    ansible-vault create secret
    ansible-vault edit secret
    ---
    ansible_sudo_pass: xxxxxxxxx
    ansible_ssh_pass: xxxxxxxxxx
    ansible_user: SOMEUSERNAME
    ---

## Usage

    ansible-playbook --ask-pass play-book.yml

## See also

    [User usage](https://docs.ansible.com/ansible/2.7/user_guide/become.html)
