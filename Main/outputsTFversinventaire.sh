#!/bin/bash
terraform output -raw Cle_privee > id_rsa
sudo chmod 400 id_rsa
sudo echo -e "[manager]\n\nmanager ansible_host=$(terraform output -raw IP_manager) ansible_user=group4\nmanager ansible_ssh_private_key_file=id_rsa\n\n[workers]\n\nworker0 ansible_host=$(terraform output -raw IP_worker_0) ansible_user=group4\nworker0 ansible_ssh_private_key_file=id_rsa\n\nworker1 ansible_host=$(terraform output -raw IP_worker_1) ansible_user=group4\nworker1 ansible_ssh_private_key_file=id_rsa" > hosts.ini
