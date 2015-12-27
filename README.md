sublime-project-logger
======================

Keeps track which project you have open in Sublime Text. If you have multiple projects open, the one with the topmost window is counted.

## Requirements

- OS X with JavaScript for Automation support (i.e. OS X Yosemite or newer).

## Installation

1. Modify the `ProgramArguments` path in `fi.viiksipojat.sublime-project-watcher.plist` to where you have copied `sublime-project-watcher.sh`. Note that you can't use `~`.
2. Copy the plist into `~/Library/LaunchAgents`.
3. Activate the agent `launchctl load ~/Library/LaunchAgents/fi.viiksipojat.sublime-project-watcher.plist`, or wait for it to be activated automatically on reboot.
4. Last step. Take a breath, this might get a bit rough. Accessibility access needs to be enabled for the script. There's two ways, either OS X pops a dialog and asks for it (TODO: screenshots) or you have to manually edit the database, like this:
  - El Capitan: `sudo sqlite3 /Library/Application\ Support/com.apple.TCC/TCC.db "REPLACE INTO access values ('kTCCServiceAccessibility', '/PATH/TO/sublime-project-logger.sh', 0, 1, 1, NULL, NULL);"`
  - Yosemite: `sudo sqlite3 /Library/Application\ Support/com.apple.TCC/TCC.db "REPLACE INTO access values ('kTCCServiceAccessibility', '/PATH/TO/sublime-project-logger.sh', 0, 1, 1, NULL);"`

   … or you could use the [tccutil.py](https://github.com/jacobsalmela/tccutil) to do the deed.

Ta-da!

## Configuration 

By default sublime-project-watcher keeps its logs in `~/spl-logs`, but you can change it by altering `LOGS_DIR` variable in the script. 

If you don't feel like running the script every minute, edit `StartInterval` in the plist to your liking.

## Log file format

Logs keep track when they're started and when the last modification was made, those are the first and the last line. In the middle is a list of projects, that were open during that day, and for how many minutes. 

Example:

```
# LOG OPENED 2015-12-23 09:22:05
foo: 84
bar: 255
# LOG CLOSED 2015-12-23 17:52:11
```