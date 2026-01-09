# Executed through systemd-run as a transient unit just before a reboot

# Change vagrant account uid/gid to avoid conflicts with SWH accounts
if [ "$(id -u vagrant)" -ge 1000 ] || [ "$(id -g vagrant)" -ge 1000 ] ; then
    sleep 1  # needed to avoid a race condition with vagrant logout
    pkill -9 -u vagrant  # just in case.

    prev_uid=$(id -u vagrant)
    prev_gid=$(id -g vagrant)
    usermod --uid 990 vagrant
    groupmod --gid 990 vagrant

    find / -uid "$prev_uid" -xdev -exec chown 990 '{}' +
    find / -gid "$prev_gid" -xdev -exec chown :990 '{}' +
fi
