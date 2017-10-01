#!/bin/bash

set -e

# Edit these constants to change the test case this script runs.
ansiblePipSpec="ansible"
platform="ubuntu_16_04"
sshPublicKey="$(eval echo ~)/.ssh/id_rsa.pub"

# These only needs to be changed if this script is copied to another project.
roleName="karlmdavis.bind_dns"
containerNamePrefix="ansible_test_bind_dns"

# Determine the directory that this script is in.
scriptDirectory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${scriptDirectory}/.."

# Create and activate the Python virtualenv needed by Ansible.
if [[ ! -d "${scriptDirectory}/../venv" ]]; then
  virtualenv -p /usr/bin/python2.7 venv
fi
source venv/bin/activate
pip install "${ansiblePipSpec}"
pip install -r .travis/requirements.txt

# Prep the Ansible roles that the test will use.
if [[ ! -d .travis/roles ]]; then mkdir .travis/roles; fi
if [[ ! -x ".travis/roles/${roleName}" ]]; then ln -s `pwd` ".travis/roles/${roleName}"; fi

# Prep the Docker container that will be used.
sudo PLATFORM="${platform}" ./.travis/docker_launch.sh ${containerNamePrefix}
cat "${sshPublicKey}" | sudo docker exec --interactive ${containerNamePrefix}.${platform} /bin/bash -c "mkdir /home/ansible_test/.ssh && cat >> /home/ansible_test/.ssh/authorized_keys"

# Ensure that Ansible treats this folder as the project's base.
cd .travis/

# Basic role syntax check
ansible-playbook basic_test.yml --inventory-file=inventory --syntax-check

# Run the Ansible test case.
ansible-playbook basic_test.yml --inventory-file=inventory

# Remove the Docker instance used in the tests.
sudo docker rm -f ${containerNamePrefix}.${platform}
