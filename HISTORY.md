v0.5.x (jun/20)
-------------

- New set of `peer` commands: `ping`, `chains`, `send`, `recv` (`send`/`recv` removed from `chain`).
- New set of `chains` commands: `join`, `leave`, `list`, `listen` (`join` removed from `chain`).
- Changed local file system structure to avoid directory hierarchy: internally, `/` is substituted by `_`.

v0.4.x (may/20)
-------------

- Block payload is now saved in a separate file.
- Command `get` now requires `block` or `payload` argument.
- Bug fix: `heads` calculation.
- Bud fix: `listen` timeout.
- Bud fix: `send` blocked blocks.

v0.3.x (apr/20)
---------------

- (no history)
