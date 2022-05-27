This SMF allows you to unlock an encrypted ZFS dataset with a key obtained
from a webserver. It runs before the zones service on OmniOS which allows
you to have your zones on an encrypted dataset.

### Installation

```
$ pfexec mkdir -p /opt/zfs-load-key/method
$ pfexec cp .../zfs-load-key.sh /opt/zfs-load-key/method/
$ pfexec chmod 555 /opt/zfs-load-key/method/zfs-load-key.sh
$ pfexec svccfg import zfs-load-key.xml
```

### Define the URL

```
$ pfexec zfs set ch.kzone:keylocation=http://example.com:8080/ pool/dataset
```
