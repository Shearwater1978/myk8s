#!/bin/bash

#mykey="put_here_content_your_id_rsa_pub_key"

if [[ -z "$mykey" ]]; then
  echo 'You not using id_rsa.pub, and can deploy you ssh key later'
else
  echo 'Insert you id_rsa.pub key'
  mkdir -p {/home/vagrant/.ssh/,/root/.ssh/}
  for i in /home/vagrant/.ssh/ /root/.ssh/; do echo $mykey >> $i/authorized_keys; done
fi

echo vagrant | passwd root --stdin
sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config
systemctl restart sshd
