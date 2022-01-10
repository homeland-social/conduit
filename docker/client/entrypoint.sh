#!/bin/sh

if [ ! -f "${SSH_KEY}" ]; then
    echo "Generating keys..."
    mkdir -p $(dirname ${SSH_KEY})
    dropbearkey -t ecdsa -f ${SSH_KEY} -s 384
    dropbearkey -y -f ${SSH_KEY} | grep "^ssh-ecdsa " > ${SSH_KEY}.pub
fi

# Options:
# -T don't allocate a pty
# -i identity file
# -K keepalive (seconds?)
# -y accept host key
# -N don't run a remote command
# -R remote port forwarding

while true; do
    echo "Starting ssh client..."
    ssh -TNy -K 300 -i ${SSH_KEY} -R 0.0.0.0:0:${SSH_FORWARD_HOST}:${SSH_FORWARD_PORT} \
        ${SSH_USER}@${SSH_HOST}/${SSH_PORT}
    echo "SSH client died, restarting..."
    sleep 3
done