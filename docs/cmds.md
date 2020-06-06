# Freechains: Command-Line Interface

```
freechains v0.6

Usage:
    freechains host start <dir> [<port>]
    freechains host stop
    freechains host now <time>

    freechains crypto create (shared | pubpvt) <passphrase>

    freechains chains join  <chain> [<shared>]
    freechains chains leave <chain>
    freechains chains list
    freechains chains listen

    freechains chain <chain> genesis
    freechains chain <chain> heads (all | linked | blocked)
    freechains chain <chain> get (block | payload) <hash>
    freechains chain <chain> post (file | inline | -) [<path_or_text>]
    freechains chain <chain> (like | dislike) <hash>
    freechains chain <chain> reps <hash_or_pub>
    freechains chain <chain> remove <hash>
    freechains chain <chain> traverse (all | linked) <hashes>...
    freechains chain <chain> listen

    freechains peer <host:port> ping
    freechains peer <host:port> chains
    freechains peer <host:port> (send | recv) <chain>

Options:
    --help              [none]            displays this help
    --version           [none]            displays version information
    --host=<addr:port>  [all]             sets address and port to connect [default: localhost:${PORT_8330}]
    --sign=<pvt>        [post|(dis)like]  signs post with given private key
    --encrypt           [post]            encrypts post with public key (only in public identity chains)
    --decrypt=<pvt>]    [get]             decrypts post with private key (only in public identity chains)
    --why=<text>        [(dis)like]       explains reason for the like

More Information:

    http://www.freechains.org/

    Please report bugs at <http://github.com/Freechains/jvm>.
```

Except for `host start`, all other commands accept an optional host to use:

- `--host=<addr:port>`: `[optional]` use daemon running at given address and port  (default: `localhost:8330`)

## Host

### `host start`

Starts a deamon to serve in the given directory and port.

```
freechains host start <dir> [<port>]
```

- `<dir>`: path to local directory to serve
- `<port>`: `[optional]` alternative listening port (default: `8330`)

- Examples:

```
freechains host start /var/freechains
freechains host start /tmp/freechains 8331
```

### `host stop`

Stops a running deamon.

```
freechains host stop
```

- Examples:

```
freechains host stop
freechains host stop --host=localhost:8331
```

## Crypto

### `crypto create`

Creates symmetric and asymmetric cryptographic keys.

```
freechains crypto create (shared | pubpvt) <passphrase>
```

- `(shared | pubpvt)`
    - `shared`: creates a symmetric key to encrypt posts
    - `pubpvt`: creates a pair of public/private keys to sign and encrypt posts
- `<passphrase>`: password to generate keys deterministically

- Examples:

```
freechains crypto create shared "My very strong password"
freechains crypto create pubpvt "My very strong password"
```

## Chains

### `chains join`

Prepares host to serve a chain.

```
freechains chains join <chain> [<shared>]
```

- `<chain>`: name of the chain, type is determined by its starting characters:
  - `#`: public forum
  - `$`: private group
  - `@`: public identity
    - if second character is `!`, only the chain owner can post
    - the rest of the name is the owner's public key
- `<shared>`: shared key for a private group

- Examples:

```
freechains chains join "#"
freechains chains join "#sports"
freechains chains join "@B2853F4570903EF3ECC941F3497C08EC9FB9B03C4154D9B27FF3E331BC7B6431"
freechains chains join "\$friends" 8889BB68FB44065BBEC8D7441C53D50362737782445ADF0EB167A5DEF354D638
freechains chains join "@!C1733F457A90DEF3ECC941F349DCA8EC9FB9CA3C41D4D9B27FF3EDD1CC3B6431"
```

### `chains leave`

Leaves a chain removing all of its data.

```
freechains chains leave <chain>
```

- `<chain>`:  name of the chain

- Examples:

```
freechains chains leave "#"
freechains chains leave "@B2853F4570903EF3ECC941F3497C08EC9FB9B03C4154D9B27FF3E331BC7B6431"
```

### `chains list`

Lists all local chains.

```
freechains chains list
```

- Examples:

```
freechains chains list
```

### `chains listen`

Listens for incoming blocks from all chains.

```
freechains chains listen
```

The command never terminates and outputs the chain and number of new blocks as
they arrive.

- Examples:

```
freechains listen
```

## Chain

### `chain genesis`

Gets the genesis block for the chain.

```
freechains chain <name> genesis
```

- `<name>`: name of the chain

- Examples:

```
freechains chain "#" genesis
```

### `chain heads`

Gets the hash of the heads in the chains.

```
freechains chain <name> heads (all | linked | blocked)
```

- `<name>`: name of the chain
- `(all | linked | blocked)`
    - `all`:     gets all heads
    - `linked`:  gets only heads linked (accepted or hidden) in the chain
    - `blocked`: gets only heads blocked in the chain

```
freechains chain "#" heads all
freechains chain "#mail" heads blocked
freechains chain "#sports" heads linked
```

### `chain get`

Gets the block with the given hash.

```
freechains chain <name> get (block | payload) <hash>
```

- `<name>`: name of the chain
- `(block | payload)`
    - `block`:   gets information about the block
    - `payload`: gets the actual message in the block
- `<hash>`:  hash of the block to get
- `--decrypt=<pvt>`: `[optional]` decrypts post in public identity chain with the owner's private key

Posts in private chains are always decrypted regardless of the `--decrypt`
option.

- Examples:

```
freechains chain "#" get block 1_CAC69BBC21388FA75F808B9AF0D652D059DEFF49FEE6B2E7E432C3F6DFD72C7A
freechains chain "@B2853F..." get payload 2_CBBBE2CB4... --decrypt=8889BB68FB44...
```

### `chain post`

Posts a new block in the chain.

```
freechains chain <name> post (file | inline | -) [<path_or_text>]
```

Freechains only accepts posts in `UTF-8`.
Binary files must be encoded as text, for example, with `uuencode` or `base64`.

- `<name>`: name of the chain
- (file | inline | -)
    - `file`:   post contents of given file
    - `inline`: post given text
    - `-`:      post contents from standard input
- `<path_or_text>`:  `[file | inline]` file name or text to post
- `--sign=<pvtkey>`: `[optional]`      signs post with given private key
- `--encrypt`: `[optional]` encrypts post in public identity chain with the owner's public key

Posts in private chains are always encrypted regardless of the `--encrypt`
option.

- Examples:

```
freechains chain "#" post inline "Hello World!"
freechains chain "#chat" post inline "Message from myself!" --sign=<my-pvtkey>
freechains chain "@<some-person-pubkey>" post inline "Crypted message from myself!" --encrypt --sign=<my-pvtkey>
freechains chain "$trusted-friends" post inline "Crypted message to my friends"
echo "Hello World!" | freechains chain post "#" -

uuencode mypic.jpg mypic.jpg > mypic.uu
freechains chain "@<my-pubkey>" post file mypic.uu --sign=<my-pvtkey>
```

### `chain (like | dislike)`

Likes or dislikes block in the chain.

```
freechains chain <name> (like | dislike) <hash>
```

- `<name>`: name of the chain
- `(like | dislike)`
    - `like`:    likes    given block
    - `dislike`: dislikes given block
- `<hash>`:  hash of the block to (dis)like
- `--sign=<pvtkey>`: signs (dis)like with given private key
- `--why=<text>`:    `[optional]` reason for the like or dislike

- Examples

```
freechains chain "#jokes" like 3_51C7BD... --sign=<my-pvtkey> --why="Very funny"
freechains chain "#" dislike 4_29A673... --sign=<my-pvtkey>
```

### `chain reps`

Gets the reputation of post (block hash) or author (public key).

```
freechains chain <name> reps <hash_or_pub>
```

- `<name>`: name of the chain
- `<hash_or_pub>`
    - `<hash>`: hash of block
    - `<pub>`:  public key of author

- Examples:

```
freechains chain "#" reps 4_29A673...
freechains chain "#" reps B2853F45...
```

### `chain remove`

Removes blocked block laying in the host.

```
freechains chain <name> remove <hash>
```

- `<name>`: name of the chain
- `<hash>`:  hash of the block to remove

Freechains limits the number of blocked blocks in the host to prevent excess.
Blocks that are not accepted should be removed by hand after some period.

- Examples:

```
freechains chain "#" remove 6_A56F33...
```

### `chain traverse`

Traverses and gets the hashes of a sub-tree of blocks in the chain.
Starts from the heads and traverses down to the given block hashes (excluded).

```
freechains chain <name> traverse (all | linked) <hashes>...
```

- `<name>`: name of the chain
- `(all | linked)`
    - `all`:    traverses all blocks
    - `linked`: traverses only linked blocks
- `<hashes>...`: list of hashes to stop traversing

The given hashes are typically the previous heads in the chain that were
already processed by an application.
To process new blocks in the chain, these old heads are used to stop the
traversal.

- Examples:

```
freechains chain "#" traverse all /1_CAC69B...
freechains chain "#" traverse linked /2_CBBBE2... /3_D3DB32...
```

### `chain listen`

Listens for incoming blocks in the given chain.

```
freechains chain <name> listen
```

- `<name>`: name of the chain

The command never terminates and outputs the number of new blocks as they arrive.

- Examples:

```
freechains chain "#" listen
```

## Peer

### `peer ping`

Counts the round-trip time to a given peer.

```
freechains peer <host:port> ping
```

- `<host:port>`: remote peer to ping

- Examples:

```
freechains peer 10.1.1.2 ping
```

### `peer chains`

Gets the available chains from a given peer.

```
freechains peer <host:port> chains
```

- `<host:port>`: remote peer to get the chains

- Examples:

```
freechains peer 10.1.1.2 chains
```

### `peer (send | recv)`

Synchronizes a chain with a given peer.

```
freechains peer <host:port> (send | recv) <chain>
```

- `<host:port>`: remote peer to synchronize
- `(send | recv)`
    - `send`: sends   missing blocks to   remote peer
    - `recv`: receive missing blocks from remote peer
- `<chain>`: name of the chain

A `send` started in host `A` passing host `B` is equivalent to a
  `recv` started in host `B` passing host `A`.

- Examples:

```
freechains peer 10.1.1.2 send "#"
freechains --host=10.1.1.2 peer 10.1.1.1 recv "#"
```
