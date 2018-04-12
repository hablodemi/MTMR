
<p align="center">
    <img src="Resources/logo.png" width="120">
</p>

# My TouchBar. My rules
[![GitHub release](https://img.shields.io/github/release/toxblh/MTMR.svg)](https://github.com/Toxblh/MTMR/releases)

<p align="center">
    <img src="Resources/TouchBar-v0.6.png">
</p>

My the idea is to create the program like a platform for plugins for customization TouchBar. I very like BTT and a full custom TouchBar (my [BTT preset](https://github.com/Toxblh/btt-touchbar-preset)). And I want to create it. And it's my the first Swift project for MacOS :)

### Roadmap
- [x] Create the first prototype with TouchBar in Storyboard
- [x] Put in stripe menu on startup the application
- [x] Find how to simulate real buttons like brightness, volume, night shift and etc.
- [x] Time in touchbar!
- [x] First the weather plugin
- [x] Find how to open full-screen TouchBar without the cross and stripe menu
- [x] Find how to add haptic feedback
- [x] Add icon and menu in StatusBar
- [x] Hide from Dock
- [x] Status menu: "preferences", "quit"
- [x] JSON or another approch for save preset, maybe in `~/Library/Application Support/MTMR/`
- [x] Custom buttons size, actions by click
- [ ] Layout: [always left, NSSliderView for center, always right]
- [ ] Overwrite default values from item types (e.g. title for brightness)
- [ ] System for autoupdate (maybe https://sparkle-project.org/)

Settings:
- [ ] Intarface for plugins and export like presets
- [ ] Startup at login
- [ ] Show on/off in Dock
- [ ] Show on/off in StatusBar
- [ ] On/off Haptic Feedback

Maybe:
- [ ] Refactoring the application on packages (AppleScript, JavaScript? and Swift?)


## Installation
1. Download last release
2. Unzip
3. Open MTMR
4. Open preset `open ~/Library/Application Support/MTMR/items.json` and customize it. Restart MTMR to apply changes.

## Preset

File for customize your preset for MTMR: `open ~/Library/Application Support/MTMR/items.json`

## Built-in button types:

- escape
- exitTouchbar
- brightnessUp
- brightnessDown
- volumeDown
- volumeUp

> Media Keys
- previous
- play
- next

> AppleScript plugins
- weather
- battery
- sleep
- displaySleep

### You can also make a custom buttons using these types
- `staticButton`
```json
 "type": "staticButton",
 "title": "esc",
```

- `staticImageButton`
```json
 "type": "staticImageButton",
 "image": "StringInbase64"
 "title": "Finder",
```

- `appleScriptTitledButton`
```js
    "type": "appleScriptTitledButton",
    "refreshInterval": 60, //optional
    "source": {
      "filePath": "/Users/toxblh/Library/Application Support/MTMR/iTunes.nowPlaying.scpt",
      // or
      "inline": "tell application \"Finder\"\rmake new Finder window\rset target of front window to path to home folder as string\ractivate\rend tell",
      // or
      "base64": "StringInbase64"
    },
```

- `timeButton`
```js
  "type": "timeButton",
  "formatTemplate": "HH:mm" //optional
```

- `flexSpace` – to easily split touch bar in two parts: left and right
```json
  "type": "flexSpace"
```

## Actions:
- `hidKey`
```json
 "action": "hidKey",
 "keycode": 53,
```

- `keyPress`
```json
 "action": "keyPress",
 "keycode": 1,
```

- `appleSctipt`
```js
 "action": "appleSctipt",
 "actionAppleScript": {
     "inline": "tell application \"Finder\"\rmake new Finder window\rset target of front window to path to home folder as string\ractivate\rend tell"
    // "filePath" or "base64" will work as well
 },
```

- `shellScript`
```js
 "action": "shellScript",
 "executablePath": "/usr/bin/pmset",
 "shellArguments": "sleepnow", // optional

```

## Additional paramaters:

- `width` allow to easily restrict how much room a particular button will take
```json
  "width": 34
```

## Example configuration:
```json
[
  { "type": "escape", "width": 110 },
  { "type": "exitTouchbar" },
  {
    "type": "brightnessUp",
    "width": 36
  },
  {
    "type": "staticButton",
    "title": "🔆",
    "action": "keyPress",
    "keycode": 113,
    "width": 36
  },

  {
    "type": "appleScriptTitledButton",
    "source": {
      "filePath": "/Users/toxblh/Library/Application Support/MTMR/iTunes.nowPlaying.scpt"
    },
    "refreshInterval": 1
  },
 {
    "type": "staticImageButton",
    "title": "Finder",
    "image": "%base64Finder%",
    "action": "appleScript",
    "actionAppleScript": {
        "inline": "tell application \"Finder\"\rmake new Finder window\rset target of front window to path to home folder as string\ractivate\rend tell"
    },
    "width": 36
  },
  {
    "type": "appleScriptTitledButton",
    "source": {
      "inline": "if application \"Safari\" is running then\r\ttell application \"Safari\"\r\t\trepeat with t in tabs of windows\r\t\t\ttell t\r\t\t\t\tif URL starts with \"https:\/\/music.yandex.ru\" and name does not end with \"на Яндекс.Музыке\" then\r\t\t\t\t\treturn name of t as text\r\t\t\t\tend if\r\t\t\tend tell\r\t\tend repeat\r\tend tell\rend if\rreturn \"\""
    },
    "refreshInterval": 1
  },
  { "type": "flexSpace" },
  { "type": "previous", "width": 36 },
  { "type": "play", "width": 36 },
  { "type": "next", "width": 36 },
  { "type": "sleep", "width": 36 },
  { "type": "displaySleep" },
  { "type": "weather", "refreshInterval": 1800, "width": 70 },
  { "type": "volumeDown", "width": 36 },
  { "type": "volumeUp", "width": 36 },
  { "type": "battery", "refreshInterval": 60 },
  { "type": "appleScriptTitledButton", "refreshInterval": 1800, "source": { "filePath": "/Users/redetection/Library/Application Support/MTMR/Weather.scpt"} },
  { "type": "timeButton", "formatTemplate": "HH:mm", "width": 64 }
]
```


### Author's presets

[@Toxblh preset](Resources/toxblh.json)

[@ReDetection preset](Resources/ReDetection.json):
```json
[
{ "type": "escape", "width": 110 },
{ "type": "exitTouchbar" },
{ "type": "brightnessDown", "width": 40 },
{ "type": "brightnessUp", "width": 40 },
{ "type": "appleScriptTitledButton", "refreshInterval": 15, "source": { "inline": "if application \"Safari\" is running then\r\ttell application \"Safari\"\r\t\trepeat with t in tabs of windows\r\t\t\ttell t\r\t\t\t\tif URL starts with \"https:\/\/music.yandex.ru\" and name does not end with \"на Яндекс.Музыке\" then\r\t\t\t\t\treturn name of t as text\r\t\t\t\tend if\r\t\t\tend tell\r\t\tend repeat\r\tend tell\rend if\rreturn \"\"" },
"action": "appleScript", "actionAppleScript": {"inline": "if application \"Safari\" is running then\r\ttell application \"Safari\"\r\t\trepeat with w in windows\r\t\t\trepeat with t in tabs of w\r\t\t\t\ttell t\r\t\t\t\t\tif URL starts with \"https:\/\/music.yandex.ru\" and name does not end with \"на Яндекс.Музыке\" then --последнее условие проверяет, запущена ли музыка\r\t\t\t\t\t\tactivate\r\t\t\t\t\t\tset index of w to 1\r\t\t\t\t\t\tdelay 0.1\r\t\t\t\t\t\tset current tab of w to t\r\t\t\t\t\tend if\r\t\t\t\tend tell\r\t\t\tend repeat\r\t\tend repeat\r\tend tell\rend if"},
},
{ "type": "appleScriptTitledButton", "source": { "inline": "tell application \"Reminders\"\r\tset activeReminders to name of (reminders of list \"Напоминания\" whose completed is false)\r\tif activeReminders is not {} then\r\t\treturn first item of activeReminders\r\telse\r\t\treturn \"\"\r\tend if\rend tell" }, "refreshInterval": 30},
{ "type": "flexSpace" },
{ "type": "appleScriptTitledButton", "source": { "inline": "if application \"iTunes\" is running then\r\ttell application \"iTunes\"\r\t\tif player state is not stopped then return \"\"\r\tend tell\rend if\rif application \"Safari\" is running then\r\ttell application \"Safari\"\r\t\trepeat with t in tabs of windows\r\t\t\ttell t\r\t\t\t\tif URL starts with \"https:\/\/music.yandex.ru\" and name does not end with \"на Яндекс.Музыке\" then\r\t\t\t\t\treturn \"\"\r\t\t\t\tend if\r\t\t\tend tell\r\t\tend repeat\r\tend tell\rend if\rreturn \"▶\"" }, "refreshInterval": 30, "width": 40},
{ "type": "volumeDown", "width": 44 },
{ "type": "volumeUp", "width": 44 },
{ "type": "displaySleep" },
{ "type": "appleScriptTitledButton", "refreshInterval": 1800, "source": { "filePath": "/Users/redetection/Library/Application Support/MTMR/Weather.scpt"} },
{ "type": "timeButton" },
]
```

## Credits

Built by [@Toxblh](https://patreon.com/toxblh) and [@ReDetection](http://patreon.com/ReDetection).
