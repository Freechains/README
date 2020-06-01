# Freechains: Join our Community

Publicly available resources to find users and interact with the community.

Send a message to us!

## Public Resources

- Chains:
    - `/`:     miscellaneous content
    - `/mail`: miscellaneous content using the [e-mail](https://github.com/Freechains/mail/) format

- Public Identities:
    - Francisco Sant'Anna
        - `A2885F4570903EF5EBA941F3497B08EB9FA9A03B4284D9B27FF3E332BA7B6431`
        - Chains:
            - `/A2885F4570903EF5EBA941F3497B08EB9FA9A03B4284D9B27FF3E332BA7B6431`

- Hosts:
    - `francisco-santanna.duckdns.org`
        - Chains:
            - `/`
            - `/mail`
            - `/A2885F4570903EF5EBA941F3497B08EB9FA9A03B4284D9B27FF3E332BA7B6431`
    - `lcc-uerj.duckdns.org`
        - Chains:
            - `/`
            - `/mail`
            - `/A2885F4570903EF5EBA941F3497B08EB9FA9A03B4284D9B27FF3E332BA7B6431`

## Join Freechains

- Prepare your host:
    - create local host
    - start local host
    - join chains of interest

```
$ freechains host create <local-path>       # just once
$ freechains host start <local-path> &      # every time on startup
$ sleep 1                                   # give some time for the start
$ freechains chains join /                  # just once for each chain to follow
$ freechains chains join /<your-pubkey> <your-pubkey>
```

- Receive existing posts from peers:

```
$ freechains peer recv <remote-host-1> /   # periodically for each chain you follow...
...
$ freechains peer recv <remote-host-N> /   # ...and for each host on your peer list
```

- Post your hosts, chains of interest and identities to `/`:

```
$ vi /tmp/message
Introduce yourself...
----------------------------------------
From: <your-name>
Pub:  <your-pubkey>
Host: <your-host>

$ freechains --host=<public-host> chain post / file /tmp/message --sign=<your-pvtkey>
```

- Send new posts to peers:

```
$ freechains peer send <remote-host-1> /   # periodically for each chain you follow...
...
$ freechains peer send <remote-host-N> /   # ... and for each host on your peer list
```

- Keep track of your local state:
    - listen in real time
        - `freechains chain listen /`
    - check periodically
        - `freechains chain heads all /`
