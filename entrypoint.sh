#!/bin/sh

set -eu

# Set deploy key
SSH_PATH="$HOME/.ssh"
mkdir "$SSH_PATH"
echo "$DEPLOY_KEY" > "$SSH_PATH/deploy_key"
chmod 600 "$SSH_PATH/deploy_key"


# Do deployment
sh -c "rsync ${INPUT_RSYNC_OPTIONS} -e 'ssh -i $SSH_PATH/deploy_key -o StrictHostKeyChecking=no' $GITHUB_WORKSPACE/${INPUT_SRC:-""} ${INPUT_USER_AND_HOST}:${INPUT_DEST}"

sh -c "ssh -i $SSH_PATH/deploy_key xuopoj@ali.vps 'cd workspace/doumi;npm install;sudo systemctl restart doumi'"