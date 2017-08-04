# DND

`dnd` control macOS notification "Do Not Disturb" settings from the command line.

DND uses AppleScript to control System Events. For this to work, your terminal application must be allowed to "control your computer" via Accessibility preferences configured in the "Privacy" tab of the System Preferences.

## Installation

Download the [`dnd` script](https://raw.githubusercontent.com/joeyhoer/dnd/master/dnd.sh) and make it available in your `PATH`.

    curl -o /usr/local/bin/dnd -O https://raw.githubusercontent.com/joeyhoer/dnd/master/dnd.sh && \
    chmod +x /usr/local/bin/dnd

## Example

```bash
# Enable Do Not Disturb
dnd on
```
