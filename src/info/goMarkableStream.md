# goMarkableStream

[goMarkableStream](https://github.com/owulveryck/goMarkableStream) is a program which "streams" the contents of your tablet's screen to a web browser on your workstation. This can be useful if you need to record something from the tablet, or if you need to share the tablet's screen as part of an online meeting.

&#x21D2; [Quick demo](https://jms1.pub/goMarkableStream-demo.mov) - screen capture of Safari streaming my tablet's screen

### Image Format

Different versions of the reMarkable firmware store the screen using different formats. It *sounds like* so far there are only two formats, which I'm calling the old and new formats. I don't know which version introduced the newer image format, however my own tablet, with firmware 3.0.5.56, uses the old format.

According to [the author](https://github.com/owulveryck/goMarkableStream/issues/52), each version of goMarkableStream supports one format or the other, and the current version (which is `v0.9.0` as of 2023-07-15) supports the new version. Using this on a tablet which stores the images in the old version results in a stream whose image is scrambled (see [here](https://jms1.pub/goMarkableStream-issue.mov) for an example).

[This page](https://github.com/owulveryck/goMarkableStream/releases) is a list of goMarkableStream releases.

&#x2139;&#xFE0F; After testing with several versions, I have found that **`v0.8.5` is the last version which supports the "old" image format.** This is what I'm using on my own tablet, at least until I update the firmware (which may not happen at all, unless I can find a way to do so without connecting it to wifi).

### Which version?

If you're interested in using this program, my recommendation is ...

* If your tablet's firmware is **3.0.5.56 or lower**, your tablet uses the older image format.

    * Use [v0.8.5](https://github.com/owulveryck/goMarkableStream/releases/tag/v0.8.5).

* If your tablet's firmware is newer, it could use either image format. I don't know which version was the first to support the newer format, so until I find out, all I can suggest is to try them both.

    * [`v0.8.5`](https://github.com/owulveryck/goMarkableStream/releases/tag/v0.8.5) works with the older image format.
    * The "latest" release, at the top of the [list of releases](https://github.com/owulveryck/goMarkableStream/releases), works with the newer image format.

I do ask one favour - if you figure out which version works with your firmware, and your firmware is in the "unknown" range below, please let me know your firmware version and which goMarkableStream version(s) do and don't work for you. I'll use this information to update the table below, so people won't *have* to try them both.

| Firmware      | Format    | goMarkableStream
|:--------------|:---------:|:------------------
| Prior         | OLD       | [`v0.8.5`](https://github.com/owulveryck/goMarkableStream/releases/tag/v0.8.5)
| `3.0.5.56`    | OLD       | [`v0.8.5`](https://github.com/owulveryck/goMarkableStream/releases/tag/v0.8.5)
| (unknown)     | (???)     | ???
| ???           | NEW       | [Latest](https://github.com/owulveryck/goMarkableStream/releases)

I've also suggested to the author that a future version could somehow detect which image format (old or new) is needed for the tablet's firmware, and be able to work with either.

> If they are not able to do this, I *might* dig into the code myself and see if I can figure out how to do it myself ... **no guarantees though**. While I've been programming for over 40 years now (*man* I feel old sometimes), golang is not a language I know very well.

## Install goMarkableStream on the tablet

### On your workstation

After downloading the appropriate version, expand the tarball.

```
$ tar xvzf goMarkableStream_0.8.5_linux_arm.tar.gz
x goMarkableStream_0.8.5_linux_arm/LICENSE
x goMarkableStream_0.8.5_linux_arm/README.md
x goMarkableStream_0.8.5_linux_arm/goMarkableStream
$
```

Copy the `goMarkableStream` executable to the tablet.

```
$ scp goMarkableStream_0.8.5_linux_arm/goMarkableStream root@10.11.99.1:
```

SSH into the tablet.

```
$ ssh root@10.11.99.1
reMarkable: ~/
```

### On the tablet

Make sure the permissions are correct.

```
reMarkable: ~/ chmod 0755 goMarkableStream
reMarkable: ~/
```

## Using goMarkableStream

### On the tablet

Run the program.

```
reMarkable: ~/ ./goMarkableStream
Local IP address: 10.11.99.1
```

Leave this running.

### On your workstation

Use a browser and visit `https://10.11.99.1:2001/`.

* Username: `admin`
* Password: `password`

You should see the contents of your tablet's display. If you do something which changes the contents of the display (i.e. drawing, pulling up a menu, etc.) you should see those changes mirrored in the browser window almost immediately.

One thing I've noticed is that, when I first connect, the display in the browser window will be in landscape mode, even if the display is currently in portrait mode. If this is the case ...

* At the left edge of the browser window is a grey bar.
* Move your mouse over this bar, it should expand and have two buttons.
* Click the "Rotate" button.

The image should now be in portrait mode, and match the tablet's display.

### When you're finished

When you're finished streaming the screen ...

* Close the browser window/tab where you're watching the screen.

* Return to the terminal window where you SSH'd into the tablet and ran `./goMarkableStream`.

* Press CONTROL-C. You will see `^C`, and then it will return to the command prompt.

    ```
    reMarkable: ~/ ./goMarkableStream-v0.8.5
    Local IP address: 10.11.99.1
    2023/07/15 15:56:23 http: TLS handshake error from 10.11.99.2:59885: EOF
    2023/07/15 15:56:23 http: TLS handshake error from 10.11.99.2:59886: EOF
    ^C
    reMarkable: ~/
    ```

If you're finished in the tablet, type `exit` and hit ENTER to shut down the SSH connection.
