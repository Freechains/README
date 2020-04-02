# Freechains: peer-to-peer content dissemination

- Persistent publish-subscribe topic-based model
- Unstructured peer-to-peer gossip dissemination
- Happened-before best-effort partial order
- Per-topic reputation system
- Social consensus for healthiness

A peer posts a message to a topic (a chain) and all other connected peers
interested in the same topic eventually receive the message.

Freechains is (intended to be) decentralized, fair, free (*as-in-speech*), free
(*as-in-beer*), privacy aware, secure, persistent, SPAM resistant, and
scalable.

## Install

Java:    https://github.com/Freechains/jvm
Android: https://github.com/Freechains/android

## Use

### Command Line

- Create a `freechains` host:

```
$ freechains host create /tmp/myhost
```

- Start host:

```
$ freechains host start /tmp/myhost
```

- Switch to another terminal.

- Join the `/chat` chain:

```
$ freechains chain join /chat
```

- Create an identity:

```
$ freechains crypto create pubpvt "My very strong passphrase"
EB172ED6C782145B8D4FD043252206192C302E164C0BD16D49EB9D36D5188070 96700ACD1128035FFEF5DC264DF87D5FEE45FF15E2A880708AE40675C9AD039EEB172ED6C782145B8D4FD043252206192C302E164C0BD16D49EB9D36D5188070
$ PVT=96700ACD1128035FFEF5DC264DF87D5FEE45FF15E2A880708AE40675C9AD039EEB172ED6C782145B8D4FD043252206192C302E164C0BD16D49EB9D36D5188070
```

- Post some content:

```
$ freechains chain post /chat inline utf8 "Hello World!" --sign=$PVT
$ freechains chain post /chat inline utf8 "I am here!"   --sign=$PVT
```

- Communicate with other peers:
   - Create another `freechains` host.
   - Start new host.
   - Join the `/chat` chain.
   - Synchronize from the first host.

```
$ freechains host create /tmp/othost 8331
$ freechains host start /tmp/othost
# switch to another terminal
$ freechains --host=localhost:8331 chain join /chat
$ freechains --host=localhost:8330 chain send /chat localhost:8331
```

The last command sends all new posts from `8330` to `8331`, which can
then be traversed as follows:
    - Identify the predefined "genesis" post of `/chat`.
    - Acquire it to see what comes next.
    - Iterate over its `fronts` posts recursively.

```
$ freechains --host=localhost:8331 chain genesis /chat
0_A80B5390F7CF66A8781F42AEB68912F2745FC026A71885D7A3CB70AB81764FB2
$ freechains --host=localhost:8331 chain get /chat 0_A80B5390F7CF66A8781F42AEB68912F2745FC026A71885D7A3CB70AB81764FB2
{
    ...
    "fronts": [
        "1_1D5D2B146B49AF22F7E738778F08E678D48C6DAAF84AF4128A17D058B6F0D852"
    ],
    ...
}
$ freechains --host=localhost:8331 chain get /chat 1_1D5D2B146B49AF22F7E738778F08E678D48C6DAAF84AF4128A17D058B6F0D852
{
    "immut": {
        ...
        "payload": "Hello World!",
        "backs": [
            "0_A80B5390F7CF66A8781F42AEB68912F2745FC026A71885D7A3CB70AB81764FB2"
        ]
    },
    "fronts": [
        "2_DFDC784B4609F16F4487163CAC531A9FE6A0C588DA39D597769DA279AB53C862"
    ],
    ...
}
```

- Visualize the chain:

```
$ freechains-dot /tmp/othost/chains/chat/ | dot -Tpng -o /tmp/chat.png
$ eog /tmp/chat.png
```
