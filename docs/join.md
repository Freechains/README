# Freechains: Join our Community

`TODO: update to v0.8.0`

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
        - `@A2885F4570903EF5EBA941F3497B08EB9FA9A03B4284D9B27FF3E332BA7B6431`

- Hosts:
    - `francisco-santanna.duckdns.org`
    - `lcc-uerj.duckdns.org`

## Join Freechains

- Prepare your host:
    - start local host
    - join chains of interest

```
$ freechains host start '<local-path>' &    # every time on startup
$ freechains chains join '#'   'A2885F4570903EF5EBA941F3497B08EB9FA9A03B4284D9B27FF3E332BA7B6431'
$ freechains chains join '#br' 'A2885F4570903EF5EBA941F3497B08EB9FA9A03B4284D9B27FF3E332BA7B6431'
$ freechains chains join '@A2885F4570903EF5EBA941F3497B08EB9FA9A03B4284D9B27FF3E332BA7B6431'
$ freechains chains join '@<your-pubkey>'
```

- Receive existing posts from peers:

```
$ freechains peer '<remote-host-1>' recv '#'  # periodically for each chain you follow...
...
$ freechains peer '<remote-host-N>' recv '#'  # ...and for each host on your peer list
```

- Post your hosts, chains of interest and identities to `#`:

```
$ vi /tmp/message
Introduce yourself...
----------------------------------------
From: <your-name>
Pub:  <your-pubkey>
Host: <your-host>

$ freechains chain '#' post file /tmp/message --sign='<your-pvtkey>'
```

- Send new posts to peers:

```
$ freechains peer '<remote-host-1>' send '#'   # periodically for each chain you follow...
...
$ freechains peer '<remote-host-N>' send '#'   # ... and for each host on your peer list
```

- Keep track of your local state:
    - listen in real time
        - `freechains chain '#' listen`
    - check periodically
        - `freechains chain '#' heads`
