#!/bin/bash

##############################################################################
# USER CONFIGURATION
##############################################################################

main () {
	echo "============================================================================================="
	echo "                                          USER DATA                                          "
	echo "============================================================================================="

	sudo echo "ECS_CLUSTER=${cluster_name}" >> /etc/ecs/ecs.config
	sudo yum update
	sudo yum upgrade -y
	sudo yum install -y\
		amazon-efs-utils\
		nfs-utils\
		jq\
		htop\
		python38.x86_64\
		python38-debug.x86_64\
		python38-devel.x86_64\
		python38-libs.x86_64\
		python38-pip.noarch\
		python38-setuptools.noarch\
		python38-test.x86_64\
		python38-tools.x86_64\
		rsync\
		tree\
		unzip\
		vim
	sudo python3 -m pip install -U pip setuptools
	sudo pip3 install boto3 ansible ansible-lint
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.0.30.zip" -o "awscliv2.zip"
	unzip ./awscliv2.zip
	sudo ./aws/install && rm -rf ./aws
	sudo mkdir -p /mnt/efs
	sudo chmod -R go+rw /mnt/efs
	sudo chown -R 1000:1000 /mnt/efs
	sudo mount -a
	mount_file_system
	sudo mount -a

	echo "============================================================================================="
	echo "                                        END USER DATA                                        "
	echo "============================================================================================="
}

function create_efs_mount_point {
	local check_cmd

	check_cmd=$(ls -d ${efs_mount_point})

	if [[ -z $check_cmd ]]; then
		echo "Creating mount point"
		mkdir -p ${efs_mount_point}
	else
		echo "Mount point exists"
	fi
}

function mount_file_system() {
	local check_cmd
	local check_mounted
	local check_jenkins_dir

	check_cmd=$(grep -i "fs-" /etc/fstab | awk '{ print $1 }')
	if [[ -z $check_cmd ]]; then
		echo "Configuring /etc/fstab and mounting efs"
		echo "${efs_file_system_id}:/ ${efs_mount_point} efs _netdev,tls,accesspoint=${efs_access_point_id} 0 0" >> /etc/fstab
	fi

	check_mounted=$(df -h | grep efs | awk '{ print $6 }')
	if [[ -z $check_mounted ]]; then
		create_efs_mount_point
		echo "Mounting EFS"
		sudo umount ${efs_mount_point}
		sudo mount -a
		echo "EFS is mounted now"
	else
		sudo umount ${efs_mount_point}
		sudo mount -a
		echo "EFS Already mounted"
	fi
	
	echo "Fixing permissions"
	sudo chmod go+rw ${efs_mount_point}
	if [[ ! -d "${efs_mount_point}/jenkins" ]]; then
		echo "Creating jenkins dir"
		sudo mkdir -p ${efs_mount_point}/jenkins
		echo "Fixing permission to Jenkins User"
		sudo chown -R 1000:1000 ${efs_mount_point}/jenkins/
	else
		echo "EFS directory exists"
		echo "Fixing permission to Jenkins User"
		sudo chown -R 1000:1000 ${efs_mount_point}/jenkins/
	fi
}

time main
