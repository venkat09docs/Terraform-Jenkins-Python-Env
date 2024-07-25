#!/bin/bash

hostnamectl set-hostname jenkins-slave

yum update -y

echo "Welcome" | passwd --stdin ec2-user

sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
systemctl stop sshd.service
systemctl start sshd.service

yum install docker fontconfig java-17-amazon-corretto-devel git -y
yum install gcc libffi-devel python3-devel openssl-devel -y

systemctl start docker
systemctl enable docker

usermod -aG docker ec2-user

su - ec2-user -c "curl https://pyenv.run | bash"

cat << 'EOF' >> /home/ec2-user/.bashrc
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
EOF

su - ec2-user -c "source /home/ec2-user/.bashrc"
su - ec2-user -c "pyenv install pypy3.8-7.3.11"
su - ec2-user -c "pyenv install pypy3.10-7.3.16"