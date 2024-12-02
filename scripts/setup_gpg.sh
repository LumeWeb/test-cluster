#!/bin/bash

killall -9 gpg-agent || true


ls ~/.gnupg
ls ~/.config/akash
cat ~/.gnupg/gpg.conf
cat ~/.gnupg/gpg-agent.conf

gpg-connect-agent reloadagent /bye

exit 0