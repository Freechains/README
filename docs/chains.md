# Freechains: Chains

A chain represents a topic in the publish-subscribe model of Freechains.
Peers synchronize their chains to disseminate content in the network.
A chain is a tree of messages or blocks linked from a set of heads down to the
genesis block:

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

- `name`:    name of the chain (string starting with `/`)
- `trusted`: if formed of trusted peers only (a boolean value)
- `pubkey`:  public key of the chain owner (hexadecimal string, `empty` if unowned)
- `oonly`:   if only the owner is allowed to post (a boolean value, `false` if unowned)

<!-- BLAKE2b Curve25519 -->

For example, a chain with parameters
    `chain = { name="/myself", trusted=false, pubkey="A2885F...", oonly=false }`
has identifier `HASH(chain) = D7E6808CF1DF8D4A2D5B93A1590874464BC91B54245EDBA31F0482660EF229F1`.

The genesis block of the chain has the same identifier of the chain itself.
This means that any peer in the network using the same parameters to join a
chain are sharing the same chain.
The [command](cmds.md#chain-join) to join a chain is as follows:

```
freechains chain join <name> [trusted] [ [oonly] <pubkey> ]
```

Based on the chain parameters, Freechains supports three types of chains with
different purposes:

- *Public Identity:*
    - Parameter `pubkey` is nonempty.
    - `1->N` and `1<-N` communication.
    - A public identity broadcasts content to an audience (`1->N`) with
      optional feedback (`1<-N`, if parameter `oonly` is `false`).
    - Examples: news site, streaming service, public profile in social media.
- *Private Group:*
    - Parameter `trusted` is `true`.
    - `1<->1`, `N<->N`, `1<-` private communication.
    - Trusted communication between pairs, groups, and alone (with itself).
    - Examples: e-mail, family WhatsApp group, backup.
- *Public Forum:*
    - `N<->N` public communication.
    - Public communication among untrusted participants.
    - Examples: Q&A forums, chats, consumer-to-consumer sales.

## Public Identity

<!--
In a public identity chain, a person or organization registers its public key
as

freechains chain join /obama B2853F4570903EF3ECC941F3497C08EC9FB9B03C4154D9B27FF3E331BC7B6431
-->

## Private Group

## Public Forum
