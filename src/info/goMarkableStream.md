# goMarkableStream

[goMarkableStream](https://github.com/owulveryck/goMarkableStream) (or "goMS") is a program which "streams" the contents of your tablet's screen to a web browser on your workstation. This can be useful if you need to record something from the tablet, or if you need to share the tablet's screen as part of an online meeting.

&#x21D2; [Quick demo](https://jms1.pub/goMarkableStream-demo.mov) - screen capture of Safari streaming my tablet's screen

## Image Format

**Version 3.4 of the reMarkable firmware stores the screen using a different format than earlier versions.** I don't know the technical details, something about how many bits are used for each pixel, I'm just going to call them the old and new formats.

* My own tablet, with firmware 3.0.5.56, uses the old format.

* goMS `v0.8.6` and later, use the new format.

Using the `v0.9.0` software (the "latest" version as I'm writing this on 2023-07-15) on a tablet using pre-3.4 firmware results in a stream whose image is scrambled (see [here](https://jms1.pub/goMarkableStream-issue.mov) for an example).

&#x2139;&#xFE0F; After testing with several versions, I have found that **`v0.8.5` is the last version which supports the "old" image format.** This is what I'm using on my own tablet, at least until I update the firmware (which may not happen at all, unless I can find a way to do so without connecting it to wifi).

### Which version?

If you're interested in using goMarkableStream ...

* **If your tablet's firmware is earlier than 3.4**, use [v0.8.5](https://github.com/owulveryck/goMarkableStream/releases/tag/v0.8.5).

* **If your tablet's firmware is 3.4 or later**, use the "latest" release, at the top of the [list of releases](https://github.com/owulveryck/goMarkableStream/releases).

I've suggested to the author that a future version could somehow detect which image format (old or new) is needed for the tablet's firmware, and be able to work with either.

## Install goMarkableStream on the tablet

You will need to do this once, and then again whenever you want to upgrade to a newer version of goMS.

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

### Optional

**On my own tablet**, which never connects to any network other than the USB cable, I disable HTTPS (so I don't have to "accept" an otherwise untrusted SSL certificate) and the username/password requirement. I also explicitly set the IP where goMS listens, so that if I ever *do* connect it to a wifi network in the future, the stream would only be accessible via the USB cable.

To make this easier, I wrote a little shell script on the tablet which sets some environment variables before running the program, and runs the command with the `--unsafe` option to *not* require a username and password.

```
reMarkable: ~/ cat stream
#!/bin/bash

export RK_SERVER_BIND_ADDR="10.11.99.1:2000"
export RK_HTTPS="false"
export RK_COMPRESSION="false"

cat <<EOF

Visit http://$RK_SERVER_BIND_ADDR/

EOF

./goMarkableStream --unsafe
```

And then when I want to stream the display, I run the script, like so:

```
reMarkable: ~/ ./stream

Visit http://10.11.99.1:2000/

Local IP address: 10.11.99.1
```

I added the "Visit ..." message to the script because I use [iTerm](https://iterm2.com/), and if I hold down &#x2318; the URL becomes clickable. It's just easier than having to type the URL.

### On your workstation

Once the `goMarkableStream` program is running on the tablet, visit `https://10.11.99.1:2001/` in a browser. (If you used environment variables or options to change how the program listens, the URL, username, or password may be different.)

* Username: `admin`
* Password: `password`

You should see the contents of your tablet's display. If you do something on the tablet which changes the contents of the display (i.e. drawing, pulling up a menu, etc.) you should see those changes mirrored in the browser window almost immediately.

When I first connect, the display in the browser window will be in landscape mode, even if the display is currently in portrait mode. If this is the case ...

* At the left edge of the browser window is a grey bar.
* Move your mouse over this bar, it should expand and have two buttons.
* Click the "Rotate" button.

The image should now be in portrait mode, and match the tablet's display.

### When you're finished

When you're finished streaming the screen ...

* Close the browser window/tab where you're watching the screen.

* Return to the terminal window where you SSH'd into the tablet and ran the command.

* Press CONTROL-C. You will see `^C`, and then it will return to the command prompt.

    ```
    reMarkable: ~/ ./goMarkableStream-v0.8.5
    Local IP address: 10.11.99.1
    2023/07/15 15:56:23 http: TLS handshake error from 10.11.99.2:59885: EOF
    2023/07/15 15:56:23 http: TLS handshake error from 10.11.99.2:59886: EOF
    ^C
    reMarkable: ~/
    ```

If you're finished in the tablet, type `exit` and hit ENTER to close the SSH connection.
