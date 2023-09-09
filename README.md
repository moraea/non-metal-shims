# Moraea non-Metal Frameworks
The core of the non-Metal patches: wrappers for downgraded frameworks, consisting of a mixture of autogenerated stubs and handwritten shims.

## build
Run `Dependencies.tool` to fetch dependencies from GitHub, or set `MORAEA_LOCAL_DEPENDENCIES=1` to use local versions. Run `Build.tool` to generate binaries in the `Build` subfolder.

Most users will want to just use [OCLP](https://dortania.github.io/OpenCore-Legacy-Patcher/), which includes stable versions of these fixes.

## credits
- [EduCovas](https://github.com/educovas)
    - QuartzCore downgrade idea and shims (fixes numerous graphical bugs and improves performance)
	- refresh rate shims (fixes Catalyst scrolling and WebKit freezing)
	- swipe between pages workaround discovery
	- window rim improvement code
	- auto appearance switching reimplementation
	- occlusion research (Safari extensions, disabled buttons, frozen apps)
	- display backlight insights
	- updating downgraded binaries and binpatch offsets for the latest security updates
	- unification of codebase and build scripts for Big Sur, Monterey, and Ventura
	- extensive Ventura SkyLight research identifying the functions responsible for:
		- flushing a display update transaction
		- updating window positions and sizes
		- updating window shapes/regions, corners, and shadows
		- capturing windows (used in fullscreen animation and screenshots)
		- handling split-screen window management
		- various other changed functionality in Ventura
	- Ventura screenshot inverted colors research
	- patch for downgraded QuartzCore crashes in Ventura
	- CABL/CAPL blur hack research and code
	- producing and testing builds for OCLP
	- Sonoma research and shim development (ongoing)
		- identification of many functions responsible for:
			- window grouping/ordering
			- setting the frontmost process
			- setting window tags (attributes)
			- SkyLight notifications
		- implmentation of shims for some of the above
		- identification of windowing functionality dependent on WindowManager interfaces
		- QuartzCore filter research and fallback idea (fixes monochrome widgets)
		- QuartzCore patch for white UI elements
	- countless other code contributions, insights, and testing
- [ASentientHedgehog](https://moosethegoose2213.github.io)
    - QuartzCore downgrade idea
	- swipe between pages workaround code
	- window rim improvement code
	- auto appearance switching reimplementation
	- keyboard backlight workaround code
	- TeraScale 2 insights
	- OpenCL downgrade
	- Night Shift prefpane fix code
	- Shim to selectively reenable transparency with reduce transparency enabled (ex. `defaults write com.apple.dock Moraea_EnableTransparency 1`)
	- AppKit `issetugid` workaround help
	- countless other code contributions, insights, and testing
- [Flagers](https://github.com/flagersgit)
    - LegacyRVPL for rapid testing of new framework shims/patches
		- preserves snapshots and delta OTAs for developer convenience
	- Ventura SkyLight transactions/softlinks research
	- Ventura/Sonoma WindowManager research
	- Objective-C and dynamic linker cache research
	- Sonoma research and shim development (ongoing)
	- countless other macOS insights, explanations, and help
- [ASentientBot](https://asentientbot.github.io)
	- most build scripts and stubbing/binpatching/swizzling utils
    - misc fixes (defenestrator-on window contents, menu bar contents and styling, sidebar glyphs, user input, sessions, Dock collisions, display sleep, accessibility zoom, greyscale, occlusion detection, CABL/CAPL hacks, Cycle Through Windows, wait cursor, unresponsive Catalyst/SwiftUI buttons, sshd/cryptexd, permissions, various crashes)
	- downgraded QuartzCore fixes (animations, Catalyst issues, Siri issues, black videos)
	- app-specific hacks (Photos, Discord, Safari, Books, Logic)
	- misc Ventura/Sonoma shims (**many based on Edu's research**, see above)
	- various other code and research
- [khronokernel](https://github.com/khronokernel)
    - OpenCore Legacy Patcher development and leadership
	- TeraScale 2 insights
	- excellent hackintosh guides
	- countless other explanations, insights, help, patience, and testing
- [dosdude1](http://dosdude1.com)
    - 10.14.4+ OpenGL/GPUSupport downgrade (fixes mysterious WindowServer crash)
	- Mojave/Catalina patcher development and leadership
	- countless other macOS insights and help
- [SpiraMira](https://github.com/SpiraMira) ([pkouame](https://forums.macrumors.com/members/pkouame.1036080/)), [testheit](https://forums.macrumors.com/members/1133139/)
    - various SkyLight insights and explanations
	- previous light mode transparency workarounds
- [fabioiop](https://github.com/fabioiop)
    - window rim improvements, SkyLight analysis and explanations
- [jackluke](https://github.com/jacklukem)
    - 10.14+ Penryn panic fix (telemetry plugin)
	- Tesla insights
- [Minh Ton](https://minh-ton.github.io)
	- display brightness workaround (fixes greyed Control Center slider with downgraded QuartzCore)
	- many other macOS insights and testing
- [parrotgeek1](https://parrotgeek.com)
    - numerous macOS and graphics insights regarding Tesla, TeraScale 2, SIP, OpenGL and more
- IronApple
    - OpenCL downgrade testing
- [dhinakg](https://github.com/dhinakg)
- [Syncretic](https://forums.macrumors.com/members/syncretic.1173816/)
- [Acidanthera](https://github.com/acidanthera)
- [Julian Fairfax](https://julianfairfax.gitlab.io)

Thank you as well to other contributors, moderators, and testers on [Unsupported Macs Discord](https://discord.gg/XbbWAsE), [OCLP Discord](https://discord.gg/rqdPgH8xSN), and [MacRumors Forums](https://forums.macrumors.com). Please contact us or open an issue if we forgot to mention you!

## changes

### 2023-9-9
- fix popup sheet windows

### 2023-6-16
- fix white artifacts with downgraded QuartzCore

### 2023-6-14
- preliminary Sonoma support
	- build script update (requires `non-metal-common:sonoma`); SkyLight libSystem symbols hack
	- essential SkyLight transactions shims (**as usual, credit EduCovas for most research and significant parts of the shims!!**)
	- WSCA tweaks (`SLSNewWindowWithOpaqueShapeAndContext`, permit layer changing, Dock-specific surface size hack 🤦🏻‍♀️, WallpaperAgent connection ID hack)
	- _menubar is currently broken with the new AppKit path_, force Carbon path with `defaults write -g NSEnableAppKitMenus -bool false`
	- monochrome widgets fix
	- _QuartzCore downgrade currently causes white artifacts_, workaround is to set display profile to sRGB/Unknown Display (as for HD 3000 problem)

### 2023-6-2
- rewrite MenuBar2; improve stability and implement Reduce Transparency/Increase Contrast handling

### 2023-5-29
- replace `SLS*DockRectWithOrientation` implementation (fix incorrect orientation returned to root processes)
- retry occlusion-related swizzles if AppKit is not available at SL init (fix OCLP indeterminate progress bar)

### 2023-5-12
- workaround `cryptexd`/`sshd` crashes due to SkyLight initializers
- stub `SL*Preflight*Access()` functions (fix screen recording regression)

### 2023-3-27
- implement automatic light/dark menubar text based on average wallpaper brightness, rounded selections, and text shadows (`defaults write -g Amy.MenuBar2Beta -bool true` to enable, will be on by default after further testing)

### 2023-3-15
- add Logic Pro playhead hack (`defaults write -g Moraea.LogicPlayheadHack -bool true` to enable)

### 2023-3-11
- workaround Safari 16.4 blank windows when focused

### 2023-3-7
- update fixes version scoping (brings buttons, books, fullscreen, splitscreen, etc. to Big Sur/Monterey)

### 2023-2-15
- replace Catalyst buttons hack with a better (still awful) hack

### 2023-2-6
- improve fullscreen transition reliability
- add wait cursor hack (enable with `sudo defaults write /Library/Preferences/.GlobalPreferences.plist Moraea.EnableSpinHack -bool true`)
- add Books hacks (reimplement cover image generation, disable broken page curl animation)

### 2023-1-31
- fix System Settings hover effects, including Bluetooth connect button

### 2023-1-23
- update menubar styling patches
	- `sudo defaults write /Library/Preferences/.GlobalPreferences.plist Moraea.MenuBar.BackgroundColor 'R,G,B,A'` where 0 ≤ R, G, B, A ≤ 1 (default: 0, 0, 0, 0)
	- `sudo defaults write /Library/Preferences/.GlobalPreferences.plist Moraea.MenuBar.Radius N` where N is horizontal gaussian blur radius (default: 128)
	- `sudo defaults write /Library/Preferences/.GlobalPreferences.plist Moraea.MenuBar.Saturation M` where M is the saturation value described [here](http://www.graficaobscura.com/matrix/index.html), negative = invert, less than 1 = desaturate, 1 = identity, more than 1 = saturate (default: 1.2)

### 2023-1-22
- workaround Safari download hang issue on Ventura

### 2023-1-7
- preliminary support for Ventura

### 2022-12-21
- fix full-screen transition
- partially fix split-window
- improve menubar blur radius

### 2022-12-1
- partially fix unresponsive Catalyst buttons
- Re-enable HardRim and improve rim appearence. White rim is now enabled by default (`defaults write -g Moraea_RimBetaDisabled -bool true` to disable)

### 2022-8-4
- Add `_AXInterfaceGetIncreaseContrastEnabled` interposing to EnableTransparency.m to fix selective re-enabling

### 2022-5-31
- update 10.14.6 and 10.15.7 binaries to latest security update

### 2022-5-27
- workaround VirtualBox AppKit `issetugid` crash with Cycle Through Windows implementation

### 2022-5-23
- fix Discord (app) screen sharing by making it think it's on High Sierra

### 2022-5-22
- allow selectively re-enabling transparency with reduce transparency enabled (`defaults write (bundle identifier) Moraea_EnableTransparency 1`)

### 2022-5-16
- temporarily disable Cycle Through Windows due to VirtualBox issue
- re-add CABackdropLayer scale hack for Cat QC builds

### 2022-5-14
- fix crashes caused by prior occlusion change

### 2022-5-13
- refresh status bar when item length changes

### 2022-5-12
- reduce rim blacklists
- update occlusion workaround to fix unresponsive UNCAlert buttons

### 2022-5-9
- add back `SLSSetWindowType` shim for Big Sur with defenestrator off
- smooth transition for auto appearance

### 2022-5-3
- Change Plugin logging to a default - disabled by default (`Moraea_PluginLogging`)

### 2022-4-23
- disable Cycle Through Windows implementation on Big Sur

### 2022-4-21
- fix Catalyst app instability with Mojave QuartzCore
- disable Night Shift patch by default since OCLP handles that
- fix upside-down Catalyst UI elements with Mojave QuartzCore

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
Also see [here](https://github.com/moraea/non-metal-frameworks/projects/1) and [here](https://github.com/dortania/OpenCore-Legacy-Patcher/issues/108#issuecomment-810634088).

- update unresponsive catalyst buttons fix for Sonoma
- improve loginwindow clock
- reimplement appkit menubar
- fix menubar2 dock server
- reimplement WindowManager communication
- investigate frozen indeterminate `NSProgressIndicator`s in wxWidgets apps?
- fix stuttering/out-of-order frames when seeking in videos with Mojave QuartzCore
- fix blank Wabbitemu, Anka VM windows with Mojave QuartzCore
- fix beachball with hardware cursor (workaround: downgrade `IOHIDFamily` to Catalina and edit WindowServer's sandbox file to allow `HIDWaitCursorFrameInterval`)
- rewrite blur fix to work with Mojave QC and fix flickering/performance issues
- investigate rare binaries not seeing re-exported symbols (Dropbox-specific workaround: [SkyLight plugin](https://github.com/ASentientBot/monterey/releases/download/2021-12-17/throw.this.in.the.SkyLight.plugins.folder.to.fix.Dropbox.in.a.really.non.ideal.way.zip))
- investigate slow compositing in all browsers (at least partially fixed with Mojave QuartzCore)
- investigate broken WebGL in some browsers (workaround: use Chrome's `ignore-gpu-blocklist`)
- fix Maps
- fix Photo Booth (workaround: use Big Sur version)
- fix Migration Assistant
- fix "Move to Display"