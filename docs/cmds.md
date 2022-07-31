# Freechains: Command-Line Interface

- `freechains-host`

```
freechains-host v0.8.0

Usage:
    freechains-host start <dir>
    freechains-host stop

Options:
    --help          displays this help
    --version       displays software version
    --port=<port>   sets port to connect [default: 8330]

More Information:

    http://www.freechains.org/

    Please report bugs at <http://github.com/Freechains/README/>.

```

- `freechains`

```
freechains v0.8.0

Usage:
    freechains chains join  <chain> [<key>...]
    freechains chains leave <chain>
    freechains chains list
    freechains chains listen

    freechains chain <name> genesis
    freechains chain <name> heads [blocked]
    freechains chain <name> get (block | payload) <hash> [file <path>]
    freechains chain <name> post (file | inline | -) [<path_or_text>]
    freechains chain <name> (like | dislike) <hash>
    freechains chain <name> reps <hash_or_pub>
    freechains chain <name> consensus
    freechains chain <name> listen

    freechains peer <addr:port> ping
    freechains peer <addr:port> chains
    freechains peer <addr:port> (send | recv) <chain>

    freechains keys (shared | pubpvt) <passphrase>

Options:
    --help              [none]            displays this help
    --version           [none]            displays software version
    --host=<addr:port>  [all]             sets host address and port to connect [default: localhost:8330]
    --port=port         [all]             sets host port to connect [default: 8330]
    --sign=<pvt>        [post|(dis)like]  signs post with given private key
    --encrypt           [post]            encrypts post with public key (only in public identity chains)
    --decrypt=<pvt>     [get]             decrypts post with private key (only in public identity chains)
    --why=<text>        [(dis)like]       explains reason for the like

More Information:

    http://www.freechains.org/

    Please report bugs at <http://github.com/Freechains/README/>.
```

## `freechains-host`

All commands accept an optional port to connect:

```
    --port=<port>   sets port to connect [default: 8330]
```

### `start`

Starts a deamon to serve in the given directory.

```
freechains-host start <dir>
```

- `<dir>`: path to local directory to serve

- Examples:

```
freechains-host start /var/freechains
freechains-host start /tmp/freechains --port=8331
```

### `stop`

Stops a running deamon.

```
freechains host stop
```

- Examples:

```
freechains-host stop
freechains-host stop --port=8331
```

## `freechains`

All commands accept an optional host or port to connect:

```
    --host=<addr:port>  sets host address and port to connect [default: localhost:8330]
    --port=<port>       sets port to connect [default: 8330]
```

### Keys

#### `keys`

Creates symmetric and asymmetric cryptographic keys.

```
freechains keys (shared | pubpvt) <passphrase>
```

- `(shared | pubpvt)`
    - `shared`: creates a symmetric key to encrypt posts
    - `pubpvt`: creates a pair of public/private keys to sign and encrypt posts
- `<passphrase>`: password to generate keys deterministically

- Examples:

```
freechains keys shared "My very strong password"
freechains keys pubpvt "My very strong password"
```

### Chains

#### `chains join`

Prepares host to serve a chain.

```
freechains chains join <chain> [<key>...]
```

- `<chain>`: name of the chain, type is determined by its starting characters:
  - `#`: public forum
  - `$`: private group
  - `@`: public identity
    - if second character is `!`, only the chain owner can post
    - the rest of the name is the owner's public key
- `<key>...`: shared key for a private group or pioneer keys for public forums

- Examples:

```
freechains chains join '#' '96700ACD1128035FFEF5DC264DF87D5FEE45FF15E2A880708AE40675C9AD039EEB172ED6C782145B8D4FD043252206192C302E164C0BD16D49EB9D36D5188070'
freechains chains join '#sports' '96700A..' 'F5BB1A..'
freechains chains join '@B2853F4570903EF3ECC941F3497C08EC9FB9B03C4154D9B27FF3E331BC7B6431'
freechains chains join '$friends' '8889BB68FB44065BBEC8D7441C53D50362737782445ADF0EB167A5DEF354D638'
freechains chains join '@!C1733F457A90DEF3ECC941F349DCA8EC9FB9CA3C41D4D9B27FF3EDD1CC3B6431'
```

#### `chains leave`

Leaves a chain removing all of its data.

```
freechains chains leave <chain>
```

- `<chain>`:  name of the chain

- Examples:

```
freechains chains leave '#'
freechains chains leave '@B2853F4570903EF3ECC941F3497C08EC9FB9B03C4154D9B27FF3E331BC7B6431'
```

#### `chains list`

Lists all local chains.

```
freechains chains list
```

- Examples:

```
freechains chains list
```

#### `chains listen`

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

### Chain

#### `chain genesis`

Gets the genesis block for the chain.

```
freechains chain <name> genesis
```

- `<name>`: name of the chain

- Examples:

```
freechains chain '#' genesis
```

#### `chain heads`

Gets the hash of the heads in the chains.

```
freechains chain <name> heads [blocked]
```

- `<name>`: name of the chain
- `blocked`: gets only heads blocked in the chain

```
freechains chain '#' heads
freechains chain '#mail' heads blocked
```

#### `chain get`

Gets the block with the given hash.

```
freechains chain <name> get (block | payload) <hash> [file <path>]
```

- `<name>`: name of the chain
- `(block | payload)`
    - `block`:   gets information about the block
    - `payload`: gets the actual message in the block
- `<hash>`:  hash of the block to get
- `file <path>`: `[optional]` outputs contents to given file instead of standard output
- `--decrypt=<pvt>`: `[optional]` decrypts post in public identity chain with the owner's private key

Posts in private chains are always decrypted regardless of the `--decrypt`
option.

- Examples:

```
freechains chain '#' get block '1_CAC69BBC21388FA75F808B9AF0D652D059DEFF49FEE6B2E7E432C3F6DFD72C7A'
freechains chain '@B2853F...' get payload '2_CBBBE2CB4'... --decrypt='8889BB68FB44...' file '/tmp/x.pay'
```

#### `chain post`

Posts a new block in the chain.

```
freechains chain <name> post (file | inline | -) [<path_or_text>]
```

- `<name>`: name of the chain
- (inline | file | -)
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
freechains chain '#' post inline 'Hello World!'
freechains chain '#chat' post inline 'Message from myself!' --sign='<my-pvtkey>'
freechains chain '@<some-person-pubkey>' post inline 'Crypted message from myself!' --encrypt --sign='<my-pvtkey>'
freechains chain '$trusted-friends' post inline 'Crypted message to my friends'
echo 'Hello World!' | freechains chain post '#' -
freechains chain '@<my-pubkey>' post file 'mypic.jpg' --sign='<my-pvtkey>'
```

#### `chain (like | dislike)`

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
freechains chain '#jokes' like '3_51C7BD...' --sign='<my-pvtkey>' --why='Very funny'
freechains chain '#' dislike '4_29A673...' --sign='<my-pvtkey>'
```

#### `chain reps`

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
freechains chain '#' reps '4_29A673...'
freechains chain '#' reps 'B2853F45...'
```

#### `chain consensus`

Gets the consensus order in the chains.
Lists all block hashes starting from the genesis block.

```
freechains chain <name> consensus
```

- `<name>`: name of the chain

- Examples:

```
freechains chain '#' consensus
```

#### `chain listen`

Listens for incoming blocks in the given chain.

```
freechains chain <name> listen
```

- `<name>`: name of the chain

The command never terminates and outputs the number of new blocks as they arrive.

- Examples:

```
freechains chain '#' listen
```

### Peer

#### `peer ping`

Counts the round-trip time to a given peer.

```
freechains peer <host:port> ping
```

- `<host:port>`: remote peer to ping

- Examples:

```
freechains peer '10.1.1.2' ping
```

#### `peer chains`

Gets the available chains from a given peer.

```
freechains peer <host:port> chains
```

- `<host:port>`: remote peer to get the chains

- Examples:

```
freechains peer '10.1.1.2' chains
```

#### `peer (send | recv)`

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
freechains peer '10.1.1.2' send '#'
freechains --host='10.1.1.2' peer '10.1.1.1' recv '#'
```
