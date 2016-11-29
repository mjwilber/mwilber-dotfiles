[ -z "$PS1" ] || echo -n "(ssh-agent.bash) "
#
# Start one agent common to all environments and re-use when possible
# http://rabexc.org/posts/pitfalls-of-ssh-agents
#
# List identities if possible
ssh-add -l &>/dev/null

# exit=2 mean that no agent was accessible so try and start one
if [ "$?" == 2 ]; then
  # If an agent script file exists already use that and eval it (for old editions of this
  # we will catch that in the check below)
  test -r ~/.ssh/agent && \
    eval "$(<~/.ssh/agent)" >/dev/null

  # We attempted to use an existing agent script if this fails, then it is probably an
  # old agent file, re-create one and start the agent.
  ssh-add -l &>/dev/null
  if [ "$?" == 2 ]; then
    (umask 066; ssh-agent > ~/.ssh/agent)
    eval "$(<~/.ssh/agent)" >/dev/null
    # Default add - ssh-add
  else
    echo "SSH Agent started!"
  fi
else
  echo "Existing SSH Agent found!"
fi
