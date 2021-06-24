# Freechains: Peer-to-peer Content Dissemination

Freechains is a peer-to-peer publish-subscribe content dissemination protocol:

- Local-first publish-subscribe topic-based model
- Unstructured peer-to-peer gossip dissemination
- **Multiple flavors of public and private communication** (`1->N`, `1<-N`, `N<->N`, `1<-`)
- **Per-topic reputation system for healthiness**
- **Consensus via authoring reputation (human work)**
- Free in all senses

*(In bold we highlight what we believe is particular to Freechains.)*

A user posts a message to a chain (a topic) and all other users subscribed to
the same chain eventually receive the message.
Users spend their reputation to post new messages and gain reputation from
consolidated posts.
Users can like and dislike messages from other users, which transfer reputation
between them.

<!---
Freechains is (intended to be) decentralized, fair, free (*as-in-speech*), free
(*as-in-beer*), privacy aware, secure, persistent, SPAM resistant, and
scalable.
-->

- Main concepts:
    - [Chain](docs/chains.md): list of blocks (aka topic or feed]
    - [Block](docs/blocks.md): unit of information (aka post or message)
    - [Reps](docs/reps.md): reputation system of chains
- [Commands](docs/cmds.md): list of all protocol commands
- [Other systems](docs/others.md): comparison with other systems
- [Google group](https://groups.google.com/forum/#!forum/freechains):
    discussion group about Freechains
- [Resources](docs/join.md):
    publicly available chains, identities and peers
- [Source code](https://github.com/Freechains/freechains.kt/)
- Tools (`outdated`):
    - [Store](https://github.com/Freechains/store):
        interprets a chain as a dataset
    - [Sync](https://github.com/Freechains/sync):
        persist and replicate peers and chains of interest
    - [Android dashboard](https://github.com/Freechains/android-dashboard/):
        manage/navigate your peers/chains
    - [E-mail client](https://github.com/Freechains/mail/):
        communicate through an e-mail client (very hacky, abandoned?)
- Introductory videos:
    [1/3](https://www.youtube.com/watch?v=7_jM0lgWL2c) |
    [2/3](https://www.youtube.com/watch?v=bL0yyeVz_xk) |
    [3/3](https://www.youtube.com/watch?v=APlHK6YmmFw)

## Install

First, you need to install `java` and `libsodium`:

```
$ sudo apt install default-jre libsodium23
```

Then, you are ready to install `freechains`:

```
$ wget https://github.com/Freechains/README/releases/download/v0.8.5/install-v0.8.5.sh

# choose one:
$ sh install-v0.8.5.sh .                    # either unzip to current directory (must be in the PATH)
$ sudo sh install-v0.8.5.sh /usr/local/bin  # or     unzip to system  directory
```

## Basics

The basic API of Freechains is very straightforward:

- `freechains-host start ...`:     starts the local peer to serve requests (execute on every restart)
- `freechains crypto ...`:         creates a cryptographic identity
- `freechains chains join ...`:    joins a chain locally to post and read content
- `freechains chain post ...`:     posts to a chain locally
- `freechains chain get ...`:      reads a post locally
- `freechains chain traverse ...`: iterates over (discovers) local posts
- `freechains peer send/recv ...`: synchronizes a local chain with a remote peer

Follows a step-by-step execution:

- Start host:

```
$ freechains-host start /tmp/myhost
```

- Switch to another terminal.

- Create an identity:

```
$ freechains crypto shared "My very strong passphrase"  # returns shared key
96700ACD1128035FFEF5DC264DF87D5FEE45FF15E2A880708AE40675C9AD039E
```

- Join the private chain `$chat`:

```
$ freechains chains join '$chat' 96700A...  # type the full shared key above
C40DBB...
```

- Post some content:

```
$ freechains chain '$chat' post inline "Hello World!"
1_DE2EF0...
$ freechains chain '$chat' post inline "I am here!"
2_317441...
```

- Communicate with other peers:
   - Start another `freechains` host.
   - Join the same private chain `$chat`.
   - Synchronize with the first host.

```
$ freechains-host --port=8331 start /tmp/othost
# switch to another terminal
$ freechains --host=localhost:8331 chains join '$chat' 96700A... # type same key
C40DBB...
$ freechains --host=localhost:8330 peer localhost:8331 send '$chat'
2 / 2
```

The last command sends all new posts from `8330` to `8331`, which can
then be traversed as follows:

```
$ freechains --host=localhost:8331 chain '$chat' traverse 0_C40DBB...
1_DE2EF0... 2_317441...
$ freechains --host=localhost:8331 chain '$chat' get payload 1_DE2EF0...
Hello World!
$ freechains --host=localhost:8331 chain '$chat' get payload 1_DE2EF0...
I am here!
```

<!--
- Visualize the chain:

```
$ freechains-dot /tmp/othost/chains/chat/ | dot -Tpng -o /tmp/chat.png
$ eog /tmp/chat.png
```
-->
