# Freechains: Using an E-Mail Client

- Setting up:
    - open Thunderbird
        - cancel account creation initial popup
        - click on `Set up an account: -> Movemail`
            - Identity
                - `Your Name: name`
                - `Email Address: name@localhost`
                - the `name` you choose is irrelevant
            - `Outgoing Serter: localhost`
            - `Account Name: Freechains`
        - right click on `Freechains` account
            - `Settings -> Outgoing Server (SMTP) -> Default -> Edit`
                - `Port: 2525`
        - configure `Inbox` to threaded display mode
    - create local e-mail

```
$ sudo touch /var/mail/chico
$ sudo chown chico /var/mail/chico
$ sudo chmod 600 /var/mail/chico
```

- Sending e-mail:
    - start `send` server in the background

```
$ cd <...>/freechains/mail/
$ ./send <pvt> &
```

    - compose e-mail on Thunderbird (`CTRL-N`)
        - `To: /mail@localhost`
        - `Subject: whatever`
        - `Body: whatever`

- Receiving e-mail:
    - execute periodically

```
$ cd <...>/freechains/mail/
$ ./recv
```



-
    `:/data/freechains/mail$ ./send.py`

    `data/freechains/mail$ ./recv.py`
        - put in synch

- Sending e-mail:

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

$ freechains --host=<public-host> chain post / file utf8 /tmp/message --sign=<your-pvtkey>
```

- Send new posts to peers:

```
$ freechains chain send / <remote-host-1>
...
$ freechains chain send / <remote-host-N>
```

- Keep track of your local state:
    - listen in realtime
        - `freechains chain listen /`
    - check periodically
        - `freechains chain heads all /`
