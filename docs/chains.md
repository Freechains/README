# Freechains: Chains

A chain represents a topic in the publish-subscribe model of Freechains.
Peers synchronize their chains to disseminate content in the network.
A chain is a tree of messages or [blocks](blocks.md) linked from a set of heads
down to the genesis block:

<img src="chain.png">

The heads are the youngest blocks received by the peer, and might not be the
same in all peers in the network due to connectivity and latency issues.
Each block has a set of back links pointing to previous blocks.
The oldest block is the *genesis block* and is the same in all peers, since it
is derived from the name of the chain.
The chain structure forms a [Merkle Tree](https://en.wikipedia.org/wiki/Merkle_tree),
which is tamper proof.
This means that if two peers both have `H1` and `H2` on their trees, then the
subtrees starting from these blocks and going back to the genesis block must be
the same in both peers.
As an additional restriction discussed in the [reputation system](reps.md), a
chain can only have single block of height one.

A chain is univocally identified by a unique hash code from four parameters:

- `name`:       name of the chain (string starting with `/`)
- `trusted`:    if formed of trusted peers only (a boolean value)
- `pub`:        public key of the chain owner (hexadecimal string, `empty` if unowned)
- `owner-only`: if only the owner is allowed to post (a boolean value, `false` if unowned)

<!-- BLAKE2b Curve25519 -->

For example, a chain with parameters
    `chain = { name="/myself", trusted=false, pubkey="A2885F...", oonly=false }`
has identifier `HASH(chain) = D7E6808CF1DF8D4A2D5B93A1590874464BC91B54245EDBA31F0482660EF229F1`.

The genesis block of the chain has the same identifier of the chain itself.
This means that any peer in the network using the same parameters to join a
chain are sharing the same chain.
The [command](cmds.md#chains-join) to join a chain is as follows:

```
freechains chains join <name> [trusted] [ [owner-only] <pub> ]
```

Note that Freechains provides a `join` instead a `create` command.
The reason is that chains have no "creators", since different users in
different hosts at different moments can issue the same command to reach
exactly the same initial state.
Joining a chain means to reserve a local space for blocks and become available
to synchronize with other peer.

Based on the chain parameters, Freechains supports three types of chains with
different purposes:

- *Public Identity Chain:*
    - Parameter `pub` is nonempty.
    - `1->N` and `1<-N` communication.
    - A public identity broadcasts content to an audience (`1->N`) with
      optional feedback (`1<-N`, if parameter `oonly` is `false`).
    - Examples: news site, streaming service, public profile in social media.
- *Private Group Chain:*
    - Parameter `trusted` is `true`.
    - `1<->1`, `N<->N`, `1<-` private communication.
    - Trusted communication between pairs, groups, and alone (with itself).
    - Examples: e-mail, family WhatsApp group, backup.
- *Public Forum Chain:*
    - `N<->N` public communication.
    - Public communication among untrusted participants.
    - Examples: Q&A forums, chats, consumer-to-consumer sales.

## Public Identity Chain

A public identity represents a person or organization that wants to publish
content to a target audience (`1->N` communication).
A person can be a blogger communicating ideas, an artist performing live, a
politician announcing actions, etc.
An organization can be a newspaper publishing news, a company advertising its
products, a streaming service broadcasting shows, or even a government
sanctioning laws.

A public identity chain is a chain with a nonempty `pub` parameter which is the
public key of the chain owner holding the associated private key.
The chain owner has infinite [reputation](reps.md) and other users may be
allowed or prohibited to post depending on the `owner-only` parameter.
If other users are allowed to post, they may encrypt messages with the owner's
public key so that only s/he can read it (`1<-N` communication).

A public identity is identified by its public key
[created](cmds.md#crypto-create) from a secret passphrase along with the
associated private key:

```
$ freechains crypto create pubpvt <my-very-strong-passphrase>
A941F3... 27FF3E332BAB...  # output from the command: public-key private-key
```

The public identity should keep its private key in secret and disclose the
public key to the target audience.
Then, both the public identity and target audience should use the same
parameters to join the chain.

As an example, suppose the company *ACME* wants to advertise its products with
disabled feedback from consumers:

```
freechains chains join /acme owner-only A941F3...
```

To post in the chain, the public identity should always sign its posts:

```
freechains --sign=27FF3E332BAB... chain post /acme inline 'Hello World!"
```

As a convention, public identities from ordinary users should use its public
key as the chain name.
For example, my own chain is instantiated as follows:

```
freechains chains join /A2885F4570903EF5EBA941F3497B08EB9FA9A03B4284D9B27FF3E332BA7B6431 A2885F4570903EF5EBA941F3497B08EB9FA9A03B4284D9B27FF3E332BA7B6431
```

## Private Group Chain

In a private group chain, messages circulate among trusted peers only.
It can be used in `1<-1` communication such as e-mail conversations, `N<->N`
communication in small groups such as for family and close friends, and also
in `1<-` "self communication" such as a personal to-do list and backups.

A private chain uses the `trusted` parameter when joining:

```
freechains chains join /friends trusted
```

In a private group chain, all users have infinite reputation and they are not
even required to sign messages.
Since peers communicate over the Internet, it is recommended to use end-to-end
encryption for the messages:

```
freechains chain post /friends inline "Crypted message to my friends" --crypt=<shared-key>
```

The key has to be shared among the trusted friends by other means, such as
through their public identity chains.

## Public Forum Chain

In a public forum chain, messages circulate among untrusted possibly malicious
users and peers (`N<->N` communication).
For this reason, chains of this type must rely on the
[reputation system](docs/reps.md) of Freechains to be viable in a completely
decentralized setting.
Without any control, the contents of a public forum chain are at mercy of
excess, SPAM, fake news, illegal content, and abusive behavior.
