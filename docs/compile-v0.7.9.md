# Compile from sources

1. Create a working directory:

```
$ mkdir repos/
$ cd repos/
```

2. Clone all repositories:

```
$ git clone https://github.com/Freechains/common/
$ git clone https://github.com/Freechains/host/
$ git clone https://github.com/Freechains/cli/
$ git clone https://github.com/Freechains/tests/
```

3. Open `IntelliJ IDEA` (version `2020.3.2`):
    - Open project/directory `repos/tests/`
    - Wait for all imports (takes long...)
    - Run self tests:
        - On the left pane:
            - Double click file `tests -> src -> test -> kotlin -> Test.kt`
            - `TMP`: remove files `Simul.kt` and `Sync.kt`
        - Press `CTRL-SHIFT-F10` to run all tests (takes long...)
    - Generate artifacts:
        - Click `File -> Project Structure -> Artifacts -> + -> JAR -> From modules with dependencies`
        - Click `Module -> tests.main`
        - Click `OK`
        - Verify that `tests.main:jar` appears
    - Rebuild artifacts:
        - Click `Build -> Build artifacts -> Rebuild`

4. Install & Test binaries:

```
$ cd repos/tests/src/main/shell/
$ sudo make install                 # copy to /usr/local/bin
$ cd test/
$ ./tests.sh
```

5. Use Freechains:

```
$ freechains-host --version
$ freechains --version
```
