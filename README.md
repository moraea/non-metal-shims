# Moraea non-Metal Frameworks
The core of the non-Metal patches: wrappers for downgraded frameworks, consisting of a mixture of autogenerated stubs and handwritten shims.

## build
Run `Dependencies.tool` to fetch dependencies from GitHub, or set `MORAEA_LOCAL_DEPENDENCIES=1` to use local versions. Run `Build.tool` to generate binaries in the `Build` subfolder. Set `USE_CAT_QC` to use Catalina's QuartzCore; otherwise Mojave's will be used (unstable).

Most users will want to just use [OCLP](https://dortania.github.io/OpenCore-Legacy-Patcher/), which includes stable versions of these fixes.

## credits
- [EduCovas](https://github.com/educovas)
    - QuartzCore downgrade idea and shims (fixes numerous graphical bugs and improves performance)
	- refresh rate shims (fixes Catalyst scrolling and WebKit freezing)
	- swipe between pages workaround discovery
	- window rim improvement code
	- auto appearance switching reimplementation
	- Safari extensions help
	- display backlight insights
	- countless other code contributions, insights, and testing
	- **TODO: Edu, edit this yourself however you want and add anything i forgot - Amy**
- [ASentientHedgehog](https://moosethegoose2213.github.io)
    - QuartzCore downgrade idea
	- swipe between pages workaround code
	- window rim improvement code
	- auto appearance switching reimplementation
	- keyboard backlight workaround code
	- TeraScale 2 insights
	- OpenCL downgrade
	- Night Shift prefpane fix code
	- countless other code contributions, insights, and testing
	- **TODO: Hedgy, edit this yourself however you want and add anything i forgot - Amy**
- [ASentientBot](https://asentientbot.github.io)
    - most fixes for Catalina/Big Sur (empty windows, empty menu bar, menu bar styling, sidebar glyphs, user input, sessions, display sleep, accessibility zoom, several app and WindowServer crashes)
	- most build scripts and stubbing/binpatching [utils](https://github.com/moraea/non-metal-common)
	- fixes for problems caused by downgraded QuartzCore (animations, Catalyst issues, Siri issues, black videos)
	- Cycle Through Windows reimplementation
	- various other code and research
- [khronokernel](https://github.com/khronokernel)
    - OpenCore Legacy Patcher development and leadership
	- TeraScale 2 insights
	- excellent hackintosh guides
	- countless other explanations, insights, help, patience, and testing
	- **TODO: Mykola, edit this yourself however you want and add anything i forgot - Amy**
- [dosdude1](http://dosdude1.com)
    - 10.14.4+ OpenGL/GPUSupport downgrade (fixes mysterious WindowServer crash)
	- Mojave/Catalina patcher development and leadership
	- countless other macOS insights and help
- [SpiraMira](https://github.com/SpiraMira) ([pkouame](https://forums.macrumors.com/members/pkouame.1036080/)), [testheit](https://forums.macrumors.com/members/1133139/)
    - various SkyLight insights and explanations
	- previous light mode transparency workarounds
- [fabioiop](https://github.com/fabioiop)
    - window rim improvements
- [jackluke](https://github.com/jacklukem)
    - 10.14+ Penryn panic fix (telemetry plugin)
	- Tesla insights
- [Minh Ton](https://minh-ton.github.io)
	- display brightness workaround (fixes greyed Control Center slider with downgraded QuartzCore)
	- many other macOS insights and testing
- [parrotgeek1](https://parrotgeek.com)
    - numerous macOS and graphics insights regarding Tesla, TeraScale 2, SIP, OpenGL and more
- [Flagers](https://github.com/flagersgit)
    - numerous macOS insights, explanations, and help
- IronApple
    - OpenCL downgrade testing
- [dhinakg](https://github.com/dhinakg)
- [Syncretic](https://forums.macrumors.com/members/syncretic.1173816/)
- [Acidanthera](https://github.com/acidanthera)
- [Julian Fairfax](https://julianfairfax.gitlab.io)

Thank you as well to other contributors, moderators, and testers on [Unsupported Macs Discord](https://discord.gg/XbbWAsE), [OCLP Discord](https://discord.gg/rqdPgH8xSN), and [MacRumors Forums](https://forums.macrumors.com). Please contact us or open an issue if we forgot to mention you!

## changes

### 2022-4-21
- fix Catalyst app instability with Mojave QuartzCore
- disable Night Shift patch by default since OCLP handles that
- fix upside-down Catalyst UI elements with Mojave QC

### 2022-4-20
- fix Siri regression with Stubber 2

### 2022-4-19
- reduce Display prefpane icon pixelation
- reimplement Cycle Through Windows
- replace last `ASB_` and `NonMetal_` prefixes with `Moraea_`

### 2022-4-18
- improve rim detection heuristic

### 2022-4-17
- improve auto appearance stability

### 2022-4-10
- fix swipe between pages automatically
- improve auto appearance stability

### 2022-4-5
- significantly improve window rim appearance

### 2022-4-4
- add window rim blacklist
- automatically disable fake window rims in light mode
- add Fabio's window rim tweak
- improve build scripts
- fix 1200 second Catalyst crash

### 2022-4-3
- add initial auto appearance reimplementation

### earlier history
Previous history is available in the [old repository](https://github.com/ASentientBot/monterey).

## todo
- fix beachball with hardware cursor (workaround: downgrade `IOHIDFamily` to Catalina and edit WindowServer's sandbox file to allow `HIDWaitCursorFrameInterval`, or use [this](https://github.com/ASentientBot/monterey/releases/download/2022-3-20/you.can.edit.the.defines.to.make.it.spin.extremely.fast.or.even.backward.lol.zip) beta SkyLight plugin)
- rewrite blur fix to work with Mojave QC and fix flickering/performance issues
- fix unresponsive password dialogs with downgraded QuartzCore
- fix unresponsive Catalyst buttons
- investigate rare binaries not seeing re-exported symbols (Dropbox-specific workaround: [SkyLight plugin](https://github.com/ASentientBot/monterey/releases/download/2021-12-17/throw.this.in.the.SkyLight.plugins.folder.to.fix.Dropbox.in.a.really.non.ideal.way.zip))
- investigate slow compositing in all browsers (at least partially fixed with Mojave QC)
- investigate broken WebGL in some browsers (workaround: use Chrome's `ignore-gpu-blocklist`)
- improve status bar item resizing, replicant handling
- investigate Maps crash
- fix Photo Booth (workaround: use Big Sur version)
- fix Books (workaround: use Big Sur version)
- automatically color menu bar text (workaround: `defaults write -g Moraea_DarkMenuBar -bool true`)
- fix full-screen transition
- fix Migration Assistant
- fix "Move to Display"