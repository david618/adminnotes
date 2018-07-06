# Ansible

## Retrieve list of Setup Vars

```
ansible --private-key ../az -i hosts bootstrap -m setup

ansible --private-key ../az -i hosts private-agents -l a1 -m setup


```


### Accept Keys without Asking

```
export ANSIBLE_HOST_KEY_CHECKING=False
```

or add to /etc/ansible/ansible.cfg or ~/.ansible.cfg

Create file: 
```
[defaults]
host_key_checking = False
```
