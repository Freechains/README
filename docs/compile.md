# Compile from sources

1. Clone the source repository:

```
$ git clone https://github.com/Freechains/freechains.kt/
```

2. Open `IntelliJ IDEA` (version `2020.3.2`):
    - (First ensure you have a JDK installed: `apt install default-jdk`)
    - Open project/directory `freechains.kt/`
    - Wait for all imports (takes long...)
    - Run self tests:
        - On the left pane, click tab `Project`:
            - Double click file `freechains.kt -> src -> test -> kotlin -> Test.kt`
        - Press `CTRL-SHIFT-F10` to run all tests (takes long...)
    - Generate artifacts:
        - Click `File -> Project Structure -> Artifacts -> + -> JAR -> From modules with dependencies`
        - Click `Module -> tests.main`
        - Click `OK`
        - Verify that `tests.main:jar` appears
    - Rebuild artifacts:
        - Click `Build -> Build artifacts -> Rebuild`

3. Install & Test binaries:

```
$ cd freechains.kt/tests/src/main/shell/
$ sudo make install     # copy to /usr/local/bin
$ cd test/
$ ./tests.sh
```

4. Use Freechains:

```
$ freechains-host --version
$ freechains --version
```
