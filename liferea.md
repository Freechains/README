## Freechains-Liferea GUI

`TODO - INCOMPLETE`

Liferea is an RSS reader adapted to Freechains.

## Install Required Packages

```
$ sudo apt-get install liferea lua5.3 lua-json lua-socket pandoc zenity
```

## Setup

- Create your host and identity:

```
$ freechains-liferea freechains://host.create
```

- Open `liferea`.
    - Delete default feeds:

```
Example Feeds -> Delete
```

    - Configure preferences
        - Intercept links in posts:

```
Tools -> Preferences -> Browser -> Browser -> Manual -> Manual ->
    freechains-liferea %s
```

    -
        - Enable automatic refreshing:

```
Tools -> Preferences -> Feeds -> Refresh Interval ->
    5 minutes
```

<!--

- Start Freechains at `localhost:8330`.

In some versions, clicking a link still opens the browser.
Alternativelly, use the command line:

```
$ gsettings set net.sf.liferea browser 'freechains-liferea %s'
```

- Add the `/` chain:

```
+ New Subscription -> Advanced -> Command -> Source
    freechains-liferea freechains://localhost:8330//?cmd=atom
```

- Click on the `/` feed and then on the `Menu` headline to start using it!

-->
