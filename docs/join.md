# Freechains: Join our Community

There are some publicly available resources to find other users and interact in
the community.

Send a message to us!

## Public Resources

- Chains:
    - `/`:     miscellaneous content
    - `/mail`: miscellaneous content using the [e-mail](mail.md) format

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
        - must be always executed on start up
    - join chains of interest

```
$ freechains host create <local-path>
$ freechains host start <local-path> &
$ sleep 1
$ freechains chain join /
$ freechains chain join /<your-pubkey> <your-pubkey>
```

- Receive existing posts from peers:

```
$ freechains chain recv / <remote-host-1>
...
$ freechains chain recv / <remote-host-N>
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
$ freechains chain send / <remote-host-1>
...
$ freechains chain send / <remote-host-N>
```

- Keep track of your local state:
    - listen in real time
        - `freechains chain listen /`
    - check periodically
        - `freechains chain heads all /`