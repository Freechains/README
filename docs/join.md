# Freechains: Join our Community

Publicly available resources to find users and interact with the community.

Send a message to us!

## Public Resources

- Chains:
    - `#`:     miscellaneous content
    - `#br`:   miscellaneous content in brazilian portuguese
<!--
    - `#mail`: miscellaneous content using the [e-mail](https://github.com/Freechains/mail/) format
-->

- Public Identities:
    - Francisco Sant'Anna
        - `@7EA6E8E2DD5035AAD58AE761899D2150B9FB06F0C8ADC1B5FE817C4952AC06E6`

- Hosts:
    - `francisco-santanna.duckdns.org`
    - `lcc-uerj.duckdns.org`

## Join Freechains

- Prepare your host:
    - start local host
    - join chains of interest

```
$ freechains host start <local-path> &      # every time on startup
$ sleep 1                                   # give some time for the start
$ freechains chains join "#"                # just once for each chain to follow
$ freechains chains join "@<your-pubkey>"
```

- Receive existing posts from peers:

```
$ freechains peer <remote-host-1> recv "#"  # periodically for each chain you follow...
...
$ freechains peer <remote-host-N> recv "#"  # ...and for each host on your peer list
```

- Post your hosts, chains of interest and identities to `"#"`:

```
$ vi /tmp/message
Introduce yourself...
----------------------------------------
From: <your-name>
Pub:  <your-pubkey>
Host: <your-host>

$ freechains --host=<public-host> chain "#" post file /tmp/message --sign=<your-pvtkey>
```

- Send new posts to peers:

```
$ freechains peer <remote-host-1> send "#"   # periodically for each chain you follow...
...
$ freechains peer <remote-host-N> send "#"   # ... and for each host on your peer list
```

- Keep track of your local state:
    - listen in real time
        - `freechains chain "#" listen`
    - check periodically
        - `freechains chain "#" heads all`
