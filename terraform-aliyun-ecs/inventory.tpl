[masters]
${master_public_ip} ansible_user=root ansible_ssh_private_key_file=/root/.ssh/id_rsa

[workers]
%{ for ip in worker_public_ips ~}
${ip} ansible_user=root ansible_ssh_private_key_file=/root/.ssh/id_rsa
%{ endfor ~}

[k8s_nodes:children]
masters
workers
