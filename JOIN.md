# Freechains: Join our Community

## Public Resources

- Chains:
    - `/`: miscellaneous content

- Public Identities:
    - Francisco Sant'Anna
        - `A2885F4570903EF5EBA941F3497B08EB9FA9A03B4284D9B27FF3E332BA7B6431`
        - Chains:
            - `/A2885F4570903EF5EBA941F3497B08EB9FA9A03B4284D9B27FF3E332BA7B6431`

- Hosts:
    - `francisco-santanna.duckdns.org`
        - Chains:
            - `/`
            - `/A2885F4570903EF5EBA941F3497B08EB9FA9A03B4284D9B27FF3E332BA7B6431`
    - `lcc-uerj.duckdns.org`
        - Chains:
            - `/`
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

- Post your hosts, chains of interest and identities to `/`:

```
$ vi /tmp/message
Introduce yourself...
----------------------------------------
From: <your-name>
Pub:  <your-pubkey>
Host: <your-host>

$ freechains --host=<public-host> chain post / file utf8 /tmp/message --sign=<your-pvtkey>
```

- Keep track of your local state:
    - listen in realtime
        - `freechains chain listen /`
    - check periodically
        - `freechains chain heads linked /`
        - `freechains chain heads blocked /`



