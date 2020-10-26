prop.version=64
### ----------------------------------------------------------------------------------------
### x X x  -  N O L I M I T S
### Fast - Snappy - Smooth - Stable - Battery
### ----------------------------------------------------------------------------------------
### Magisk Module ROM
### Developer: xXx
### Compatible with: OnePlus 8, 7, 6, 5 device family
### Supported Devices: OnePlus 8 Pro only
### Supported ROMs: Oxygen or H2OS based on Android 10(/11)
### No active NoLimits development anymore for Android 11 and beyond
###
### ----------------------------------------------------------------------------------------
### P R O F I L E  I N S T R U C T I O N S
### ----------------------------------------------------------------------------------------
### This profile is used to configure xXx - NoLimits.
###
### Save Directory: /sdcard/xXx/
### If the profile is not stored in the above directory, the default profile will be used.
###
### This profile must be edited in Plain Text.
###
### For editing this file on Windows OS you MUST use Notepad++ for this.
###
### ----------------------------------------------------------------------------------------
### H O W  T O
### ----------------------------------------------------------------------------------------
### Example 1: For binary selection.
###   0 = Stock/Ignore (do nothing)
###   1 = Do this
###
###   Everywhere you don't find value options listed, you need to set either 0 or 1 
###
### -----------------------------
###
### Example 2: For multi-options.
###	  0 = don't change AnimationScale values
###	  1 = Fastest - No Animation: 0
###	  2 = Very Fast Animations: 0.25
###	  3 = Fast Animations: 0.5
###   4 = Faster Animations: 0.75
###   5 = Android Stock Animations: 1
###
###   For example to get "Faster Animations: 0.75" simply set AnimationScale = 4 
###
### ----------------------------------------------------------------------------------------
### E N D   O F   I N S T R U C T I O N S   S E C T I O N
### ----------------------------------------------------------------------------------------



# ----------------------------------------------------------------------------------------
# S Y S T E M  T W E A K S
# ----------------------------------------------------------------------------------------
# Windows Animation Scales
# The lower the number, the faster the animation scales.
# Attention! Some apps like gaming apps don't support animation speeds other than android default
#            also, horizon light or edge notification lights require a minimum animation speed.  
#
#	0 = don't change AnimationScale values
#	1 = Fastest - No Animation: 0
#	2 = Very Fast Animations: 0.25
#	3 = Fast Animations: 0.5
#	4 = Faster Animations: 0.75
#	5 = Android Stock Animations: 1

AnimationScale = 3

# ----------------------------------------------------------------------------------------
# Enable OnePlus Navigation Gestures
# Since OP8, this option is not available anymore with the user interface 
#	0 = Don't touch anything
#	1 = OnePlus Navigation Gestures

OnePlusNavigationGestures = 0

# ----------------------------------------------------------------------------------------
# Google Play Wakelocks/Analytics (thanks to @MeggaMortY)
# This tweak blocks all non-critical Google Play wakelocks 
#
#	0 = Stock/Ignore
#	1 = Standard blocking
#	2 = Standard + Extended blocking (affect Google Pay and Google Fit functionallity)

DisableGooglePlayWakelocks = 1

# ----------------------------------------------------------------------------------------
# Google Analytics
#	This tweak will block all non-critical Google analytics for all apps.
#   WARNING! A red framework will be displayed in the ads place due to lack of connectivity to the Google analytics API.

DisableGoogleAnalytics = 0

# ----------------------------------------------------------------------------------------
# Universal GMS Doze - thanks to @gloeyisk
#	Helps to increase battery life, as your device will be dozing most of the time, rather than waking up all the time.
#   ATTENTION: Apps like Google Hangouts, Facebook Messenger, WhatsApp, Telegram, etc. might not notify in time anymore.
#   If you want to ensure real-time WhatsApp notifications for example, go to your WhatsApp notification settings and enable high priority notifications. 
#   By default, "High priority" notifications like from Alarm clocks, SMS or incoming phone calls are not affected at all.
#   More explanations here: https://forum.xda-developers.com/apps/magisk/module-universal-gms-doze-t3853710

Universal.GMS.Doze = 1

# ----------------------------------------------------------------------------------------
# Disable zram
# zram is a kernel feature that uses on-the-fly compression to increase overall RAM.
# OnePlus have set a swap disk to improve memory management.
# By disabling these you may experience less battery consumption due to less CPU/Disk usage.
#
#   0 = Stock/Ignore (Recommended for 6GB RAM devices on Android 10)
#   1 = Disable the OnePlus swap-disk (min. 8GB+ RAM on Android 10)
#   2 = Completely disable zram (min. 8GB+ RAM on Android 10)

DisableZRAM = 0

# ----------------------------------------------------------------------------------------
# LMK RAM Management
# This setting will keep more apps in RAM longer.
#
#   0 = Stock/Ignore
#   1 = Improved - More Apps are kept longer in RAM
#   2 = Aggressive - Keep as many apps as long as possible in RAM

LMK_RAM_Management = 0


# ----------------------------------------------------------------------------------------
# b u i l d . p r o p  T W E A K S
# some tweaks to improve scrolling, add VoLTE/VoWifi options, more volume steps, etc.
#
#   0 = Don't apply tweaks
#   1 = Applies all build.prop tweaks

TweaksMasterSelector = 1


# ----------------------------------------------------------------------------------------
# Kernel Tweaks
# A carefully optimised set of kernel tweaks to increase the performance of your device.
# Some OP6 Users experience issues. Then simply disable it.

KernelTweaks = 0

# ----------------------------------------------------------------------------------------
# Force xXx - NoLimits Tweaks
# This setting will force xXx - NoLimits tweaks to be used over any other tweaks on your device.

ForceTweakApplication = 0


# ----------------------------------------------------------------------------------------
# Force a fixed low or high display refresh rate
#   0 = Do nothing
#   1 = 60hz on OP8 & OP7 device family
#   2 = 120hz on OP8pro / 90hz on OP7T & OP7pro

DisplayRefreshRate = 0


# ----------------------------------------------------------------------------------------
# Rebuild Dalvik Cache
# Dalvik cache is cached odex files from installed apps on your device to prevent the app being optimised every time it runs.
# This needs to be done in many circumstances to avoid issues.
# Currently this is only rebuilt when the device is charging and reached 100%.
# Enabling this will rebuild the cache upon rebooting. (one time action after flashing NoLimits, OOS, or wiping dalvik cache)
#
# Note: This can take up to 12 mins.

RebuildDalvikCache = 0


# ----------------------------------------------------------------------------------------
# Irreversible Debloat (End of Live since NoLimits 12.0)
#
# Irreversible delete selected bloat from System Partition
# Not recommended anymore for Android 10 or higher!!
# Watch out! If you uninstall or reflash NoLimits with different debloat selection,
# already debloated stuff will be gone until you reflash OOS or custom Rom

IrreversibleDebloat = 0


# ----------------------------------------------------------------------------------------
# Hide NoLimits Version in Settings > About
# This will hide the NoLimits version info on the About screen

HideNoLimitsVersionInABOUTinfo = 0

# ----------------------------------------------------------------------------------------
# 2.4GHz WiFi Channel Bonding
# Useful if your router only support the 2.4GHz frequency but not the faster 5Ghz
# Should theoretically double your wireless throughput (as long as your router supports channel bonding)

2.4GHzWiFichannelbonding = 0


# ----------------------------------------------------------------------------------------
# BusyBox by osm0sis
# Recommended
# It's a set of powerful tools which are used by some root applications and don't affect battery life

BusyBox = 1


# ----------------------------------------------------------------------------------------
# SELinux Enforce/Permissive Switch
#
# If you don't know what this is, just leave it 0
#   0 = Do nothing
#   1 = Enforced
#   2 = Permissive

SELinuxSwitch = 0


# ----------------------------------------------------------------------------------------
# DaydreamVR Enabler
#
# this will add necessary system files to add support for Daydream thanks to @skyball2
# you still need to install required Daydream apps

DaydreamVR = 0


# ----------------------------------------------------------------------------------------
# Fix SDcard permissions
# Fix ownership & permissions of files and folders on the SDcard to Android OS's original state.

FixSDcardpermissions = 0



# ----------------------------------------------------------------------------------------
# A P P L I C A T I O N S ,  T H E M E S  &  I M P R O V E M E N T S
# ----------------------------------------------------------------------------------------
# A P P L I C A T I O N S
# ----------------------------------------------------------------------------------------
# Launcher Selection
#
# Nova Launcher - One of the most popular launchers currently.
# Action Launcher - Based on the Pixel Launcher and Android Oreo.
# Pixel Launcher - The original Nexus Launcher packed full of features, including the Google Now side drawer
# Lawnchair Launcher - Based on the Pixel launcher with increased functionality.

NovaLauncher = 0
ActionLauncher = 0
PixelLaucher = 0
LawnchairLaucher = 0

# ----------------------------------------------------------------------------------------
# Sound Mods (Android 10 and below only!)
#
# Attention! 
#   On the OP7pro enabling Dolby Digital might break the Proximity sensor functionallity.
#   Dolby Atmos UI is for OP8x/OP7x only and DON'T work side by side with any of the other sound mods. If you set this to 1 all other sound mod selections will be ignored
#
# ViPER4Android - Thanks to Team Arise, Team DeWitt, Ahrion, Zackptg5, ViPER520, ZhuHang
#	1 = Legacy Black/Red Themed Arise Version 2.5.x
#	2 = Team DeWitt Version 2.7.x - default theme White/Purple, but also themeable by Swift Installer etc.
#
# Dolby
#	DolbyDigital = Dolby Digital thanks to @repey6.
#	DolbyAtmosUI = For OP8x/OP7x only! Replace the simple stock Atmos SoundTuner with an Atmos App providing you with a graphic equalizer. Thanks to jamal2367 for discovery and red theming.
#
# JamesDSP - Thanks to james34602, ahrion, zackptg5
#
# Stereo Speaker Mod (for OP5x/OP6x only!) - Adds the earpiece as an additional speaker. Earpiece audio might not be as clear as main speaker.
# Viper Profile Collection - Profile collection for Viper4Arise, thanks to @A.R.I.S.E. Team.

# Either this...
DolbyAtmosUI = 0

# ...or...
Viper4Android = 0
DolbyDigital = 0
JamesDSP = 0

# Independent from above selections
StereoSpeakerMod = 0
ViperProfileCollection = 0


# ----------------------------------------------------------------------------------------
# Pixel Sounds
# add all sounds from Pixel devices for alarms, notifications, ringtones and ui

PixelSounds = 0


# ----------------------------------------------------------------------------------------
# AdAway
# AdAway is an open source ad blocker for Android using the hosts file.
#	0 = Stock/Ignore
#	1 = latest 5.x beta version 
#	2 = latest 4.x stable version 
AdAway = 2


# ----------------------------------------------------------------------------------------
# Caffeine Tile
# Caffeine Tile thanks to Hansog Zhang. Simple Tile to keep your Screen awake. Can be customized via app

Caffeine = 1


# ----------------------------------------------------------------------------------------
# YouTube Vanced (old 14.21.54 version)
# This is a modded version of YouTube by the vanced team, which contains a lot of features like Ad Blocking, Background Playback and many more.
#
# Attention! v14.21.54 is the last single apk version, which DON'T require disabling apk signature verification but requires detaching from Playstore
# if you already manual installed the latest YT vanced ROOT version 15.x, you can use option 3 to detach Youtube to prevent Playstore from reverting it to the Google YT version.
#
# Note: By default, YouTube Vanced is white themed. To use the black theme you will need to change it in Vanced settings.
#	0 = Stock/Ignore
#	1 = v14.21.54 - White/Dark themed
#	2 = v14.21.54 - White/Black themed
#	3 = Debloats Google Youtube and detach it from Playstore, but without installing the Youtube vanced app

#!! Latest Vanced framework and Updates are available now through a simple app to be downloaded here:
#!! https://vancedapp.com/
#!! YouTubeVanced = 0 is required for this case
   
YouTubeVanced = 0


# ----------------------------------------------------------------------------------------
# Google Dialers
#	0 = Ignore / Keep Stock Dialer
#
# (OOS Dialer REMOVED) - Improves your calling experience and gain control over calls with features like spam protection, caller ID, call blocking and more.
#	1 = Latest Dialer App version with option for white or dark theming (white is default)
#	2 = Old Dialer v22 with fixed white/blue theme)
#
# (OOS Dialer REMAINS) - Google Dialer experience, but several features are not working when combined with OOS Dialer. Native call recording still works with OOS dialer.
#	3 = Latest Dialer App version with option for white or dark theming (white is default)
#	4 = Old Dialer v22 with fixed white/blue theme)

GoogleDialer = 0


# ----------------------------------------------------------------------------------------
# Google Camera
# A modded GCam version by @Urnyx05.
# 
#	0 = Ignore/uninstall previous installed version
#	1 = Standard installation as user app
#	2 = Ability to switch between the auxiliary back cameras which enables multi-lense switching between auxiliary back cameras.
#       Attention! You need to enable the auxiliary cameras in the camaera settings!

GoogleCamera = 1


# ----------------------------------------------------------------------------------------
# Always On Display
# Simple AOD app by @domi04151309 keeps your screen on while the clock and battery percentage are displayed
# Can be switched on/off via AlwaysOn QuickTile
# Make sure to allow "Notification Access" in android special app settings to get a notification counter displayed
# Attention! This will increase your standby battery drain by additional about 5%/hour

AlwaysOn = 0



# ----------------------------------------------------------------------------------------
# T H E M I N G
# ----------------------------------------------------------------------------------------
# Emoji Fonts
#	0 = Keep stock Emojis
#	1 = Android O Emoji's - Thanks to xda recognized contributor, linuxct.
#	2 = iOS 13.2 Emoji's - Thanks to @tych_tych.
#	3 = Emoji One - JoyPixels (formerly Emoji One).
#	4 = Samsung Emoji's - Samsung device glossy emoji's.

EmojiFont = 0

# ----------------------------------------------------------------------------------------
# Standard Font
#	0 = Keep stock
#	1 = Google Sans
#	2 = Storopia

StandardFont = 0

# ----------------------------------------------------------------------------------------
# Boot Animations
# Assign the respective number to the "CustomBootanimation = " option below
#   0 = Disable custom bootanimations - Base Rom Bootanimation will be used
#   1 = xXx NoLimits Boot Animation - Thanks to @Roger.T
#   2 = Oxygen OS Stock Boot Animation
#   3 = Boot Animation in xXx Folder - Copy a raw bootanimation.zip to the xXx directory on your internal SDcard
#   4 = WatchDogs Boot Animation - Thanks to @Robdyx
#   5 = McLaren Boot Animation - Thanks to @Mishaal Rahman
#   6 = Google Pixel 1 Boot Animation - Thanks to xda Senior Member @niwia
#   7 = Google Pixel 2 Boot Animation
#   8 = Google Pixel 3 Boot Animation
#   9 = xXx NoLimit Porsche Edition - Thanks to @Roger.T & @Xenix96

CustomBootAnimation = 1


# ----------------------------------------------------------------------------------------
# I M P R O V E M E N T S
# ----------------------------------------------------------------------------------------


# ----------------------------------------------------------------------------------------
# Ice Box Speedup System Plugin
# Speed up Ice Box's freezing and defrosting.

IceBoxSpeedup = 0

# ----------------------------------------------------------------------------------------
# MoreLocale
# Morelocale can help you to enable your local language in HydrogenOS.
# Does not work on Android itself, but all user apps will switch to the selected language.

MoreLocale = 0





### ----------------------------------------------------------------------------------------
### D E B L O A T I N G    S E C T I O N
### ----------------------------------------------------------------------------------------
### -- How to Debloat ------------
###        0 = No debloating / don't touch
###        1 = Debloat



### -- D E B L O A T   R U L E S    ---------------------------------
#
# Debloat master rule
#	0 = Debloat selected system apps only
#	1 = Debloat selected system apps along with the respective user apps
DebloatUserApps = 1



### -- B U L K   D E B L O A T   O P T I O N S -----------------------------------------------

# ExtremeDebloating is a selection of 60+ items. The device will still run stable.
# In case you miss apps you wanted to keep, better make use of the Individual Debloat Section to decide on item base what to debloat. 
ExtremeDebloating = 0

# OnePlus Analytics Disabler Light
# Disable the OPDeviceManager which was rumored to send personal device information to OnePlus
OnePlusAnalyticsDisablerLight = 1

# OnePlus Analytics Disabler Full
#    Might mess up usefull stuff. Disables more stuff which is rumored to send analytics or potentially open a backdoor.
#    Attention! This option will break secret codes menus like *#800# or *#801# etc. and OK Google.
OnePlusAnalyticsDisablerFull = 0

# GApps Pico level
# This will debloat the GApps Framework down to the GApps Pico level which is the absolut minimum to run the framework
GAppsPicolevel = 0

# Total GApps removal
# BEWARE!! This will completely remove the Google Framework. No GApps like Youtube, Chrome etc will work anymore
TotalGAppsremoval = 0



# -- I N D I V I D U A L   D E B L O A T   O P T I O N S -----------------------------------
#
# Debloats are categrorized in 3 sections
# - Light Debloating        -> Safe to remove, but you might want to keep it
# - Extreme Debloating      -> Removes system apps and services which you might never want to use
# - Experts only Debloating -> Debloating in this section could potentially remove important core system functionality


# MASTER SWITCH for all individual debloat selections
#	0 = Ignore all individual selections
#	1 = Debloat all selections
IndividualDebloatSelection = 1


# -------------------------------------------------------------------------------
# L I G H T   D E B L O A T I N G  (belongs to the individual debloating section)
# Safe to remove, but you might want to keep it
# -------------------------------------------------------------------------------

# india.img >
# This is an image container with several india related apps which is mounted into /system/india
# Debloating this image will be persistant and completely debloat all included apps and services at once
# In order to get the image back, you need to set india.img = 0 and flash OOS and NoLimits again
india.img = 1

# Google Chrome >
# If you debloat Google Chrome, you might experience FCs and Black screens until you update Webview to latest version!
GoogleChrome = 0

# AndroidPay >
# Debloat this means remove ability to do transactions with AndroidPay
AndroidPay = 1

# Amazon Prime Video >
# atv.apk
AmazonPrimeVideo = 0

# Amazon Kindl >
# kindle.apk
AmazonKindl = 0

# Amazon Appmanager >
# mdip.apk
# MaftPreloadManager
AmazonAppmanager = 0

# Amazon Shop >
# mshop.apk
AmazonShop = 0

# Digital WellBeing
# See a complete picture of your digital habits and disconnect when you want to.
DigitalWellBeing = 0

# OPMemberShip >
# /india/app/OPMemberShip
# Some users experience call issues when debloating this
OPMemberShip = 0

# CloudService >
# /india/priv-app/CloudService
CloudService = 0

# TVCast >
# /india/app/TVCast
TVCast = 0

# Nearme >
# /india/app/Nearme
Nearme = 0

# heytab_mcs >
# /india/app/heytab_mcs
# Some users experience call issues when debloating this
heytab_mcs = 0

# HeytapIdProvider >
# /india/app/HeytapIdProvider
# Some users experience call issues when debloating this
HeytapIdProvider = 0

# Device Health Service >
# Device Health Service priodicts how long your phone's battery will last based on your usage
DeviceHealthService = 0

# Google Assistant >
# Google's version of Amazon's Alexa, Apple's Siri and Microsoft's Cortana.
# Offers voice commands, voice searching, and voice-activated device control, letting you complete a number of tasks after you've said the "OK Google" or "Hey, Google" wake words.
GoogleAssistant = 0

# Google News >
# If you debloat this, the OnePlus Launcher don't show news anymore
GoogleNews = 0

# Google Podcasts >
# Discover free & trending podcasts
GooglePodcasts = 0

# GooglePay >
# Debloat this means remove ability to do transactions with GooglePay
# Some 7T Series users experience no sound issues during calls when debloating this
GooglePay = 0

# Google Space - OPGamingSpace >
# Google Space brings all your games together and provides relevant gaming optimization features
GoogleSpace = 0

# Google ARCore >
# Debloat this means remove ability to use AR Stickers & Playmoji on Google Camera
ARCore = 1

# CalendarGoogle >
# Debloat this means remove Google Calendar app
CalendarGoogle = 1

# Drive >
# Debloat this means remove Google Drive app
Drive = 1

# Facebook >
# Debloat this means remove the preinstalled Facebook Framework including Facebook Messenger
Facebook = 0

# Gboard - Google Keyboard >
# Make sure you have any keyboard installed. Otherwise you will end up with NO keyboard available
Gboard-GoogleKeyboard = 0

# Gmail2 >
# Debloat this means remove Gmail app
Gmail2 = 1

# Hangouts >
# Debloat this means remove Hangouts app
Hangouts = 1

# Instagram >
# Debloat this means removing Instagram
Instagram = 0

# LiveWallpapersPicker >
# Debloat this means remove ability to choose Live Wallpapers
LiveWallpapersPicker = 0

# OPWallpaperResources >
# OnePlus Live Wallpapers
OPWallpaperResources = 0

# OPsports >
# Cricket scores
OPsports = 0

# OnePlus Buds - OnePlusPods
OnePlusPods = 0

# Maps >
# Debloat this means remove Google Maps app
Maps = 0

# Messages App >
# Debloat this means you need an alternative app in place to receive SMS/MMS messages
OPMms = 0

# Music2 >
# Debloat this means remove Google Play Music app
Music2 = 1

# OPDialer+Contacts >
# Make sure you have an alternative dialer in place. Otherwise you can't do or take any calls
OPDialer+Contacts = 0

# OnePlus Switch >
# Debloat this means remove OnePlus Switch app. Usually used for transferring data from old to new phone
OnePlusSwitch = 1

# OPFilemanager >
# Debloat this means remove OnePlus default File Manager app. When debloating, make sure you have another File Manager app
OPFilemanager = 0

# OPForum >
# Debloat this means remove OnePlus Forum app
OPForum = 1

# OPMusic >
# Debloat this means remove OnePlus Music app
OPMusic = 1

# OPPush >
OPPush = 1

# OP Icons >
# Debloat this means remove OnePlus Icons that's used in launcher
OPIcons = 1

# OPGamingSpace >
# OnePlus custom launcher for your Android games
# Attention: Debloating this, breaks android settings > utility menu
OPGamingSpace = 0

# OPWorkLifeBalance >
# This help balance work and family life, with special focus on digital health and consciousness.
# Whatever the author of this description is trying to tell us :-)
OPWorkLifeBalance = 1

# Photos >
# Debloat this means remove Google Photos app
Photos = 1

# SoundRecorder >
# Debloat this means remove the voice Recording app.
SoundRecorder = 1

# SwiftKey >
# Debloat this means remove SwiftKey Keyboard
SwiftKey = 1

# talkback >
# Talkback is used for guiding partial or total blind people to navigate the touchscreen
talkback = 1

# Velvet - Google App >
# Required for Google Assist, OK Google, Pixel Launcher…
Velvet-GoogleApp = 0

# Videos >
# Debloat this means remove Google Play Movies app
Videos = 1

# Weather >
# Debloat this means remove OnePlus Weather app
Weather = 1

# YouTube >
# Debloat this means remove YouTube app
YouTube = 1

# YouTube Music >
# Debloat this means removing the YouTube Music app
YTMusic = 1

# OnePlus Card >
# Debloat this means remove OnePlus Card app. Usually used for store your train card, prepaid card, etc
Card = 1

# Google Backup Transport >
GoogleBackupTransport = 0

# BackupRestoreRemoteService >
BackupRestoreRemoteService = 1

# DeskClock >
DeskClock = 0

# HTMLViewer >
# Filters html to be more compatible, also enables to view files like html, txt etc.
HTMLViewer = 0

# NVBackupUI >
# OnePlus Backup solution. goes with OPBackup
NVBackupUI = 1

# BackupRestoreConfirmation >
BackupRestoreConfirmation = 1

# CallLogBackup >
# helps to backup up your call logs. But there’s no good option to restore.
CallLogBackup = 1

# GoogleRestore >
GoogleRestore = 1

# ManagedProvisioning >
# Work Profile Setup apk. Don't remove it if your company gave you this phone
ManagedProvisioning = 0

# OPAppLocker >
# Debloat this means remove ability to use app locker
OPAppLocker = 0

# SharedStorageBackup >
SharedStorageBackup = 1

# Calculator >
# Debloat this means remove Calculator app. Safe to remove, but you most probably want to keep it
Calculator = 0

# OPBreathMode aka Zen Mode>
# This is the Zen Mode app which should help Cell Phone addicted users to concentrate 
# by turning screen pitch black and disable clock and notifications during defined schedule.
OPBreathMode = 0

# OPCommonLogTool >
OPCommonLogTool = 0

# OPLongshot >
# Debloat this means remove ability to take long screenshots. Safe to remove, but you most probably want to keep it
OPLongshot = 0

# OPRoamingAppRelease >
# Debloat this means remove ability to use OnePlus roaming services
OPRoamingAppRelease = 0

# OPRoamingServiceRelease >
# Debloat this means remove ability to use OnePlus roaming services
OPRoamingServiceRelease = 0

# OPSafe >
# Debloat this means remove ability to see cellular data usage in Settings
OPSafe = 0

# DocumentsUI >
# Safe to remove, but you most probably want to keep it
DocumentsUI = 0

# OnePlusCamera >
# Debloat this means remove OnePlus camera app. Make sure you have another camera app like Google Camera. Safe to remove, but you most probably want to keep it
OnePlusCamera = 0

# OnePlusCameraService >
# Safe to remove, but you most probably want to keep it
OnePlusCameraService = 0

# OnePlusGallery >
# Debloat this means remove OnePlus Gallery app. Make sure you have another Gallery app like Google Photos. Safe to remove, but you most probably want to keep it
OnePlusGallery = 0

# OPLauncher2 >
# Debloating this will, enable the old vertical recents view known from Oreo and will also break OP gestures
# BEWARE! If you debloat this launcher, you MUST make sure that you have an alternative launcher in place, or you will end up with a black screen!
OPLauncher2 = 0

# WallpaperCropper >
# Safe to remove, but you most probably want to keep it
WallpaperCropper = 0



# -------------------------------------------------------------------------------------
# E X T R E M E    D E B L O A T I N G   (belongs to the individual debloating section)
# Removes system apps and services which you might never want to use
# -------------------------------------------------------------------------------------

# Account >
# OnePlus Account login
# !! Watch out! Debloating the Account might cause some weird issues on some devices like apps disappear and debloating don't work correct anymore 
Account = 0

# Android Auto >
# Android Auto is your smart driving companion that helps you stay focused, connected, and entertained with the Google Assistant.
AndroidAuto = 0

# AntHalService >
# App allows to connect to, and make use of various other ANT or ANT+ devices like...
# ...ANT+ sport/fitness/health devices such as heart rate sensors, fitness equipment, cycling products, weight scales and more
AntHalService = 0

# BookmarkProvider >
# App provides the list of installed apps to Market
BookmarkProvider = 1

# bugreport >
# Debloat this means remove ability to report bug to OnePlus
bugreport = 1

# CNEService >
# necessary in order to make VoWIFI work. Don't delete it if you're in the US and using it. I don't know
CNEService = 0

# Duo >
# Debloat this means remove Google Duo app
Duo = 1

# DiracManager >
# Debloat this means remove ability to use OnePlus default equalizer
DiracManager = 0

# DiracAudioControlService >
# Debloat this means remove ability to use OnePlus default equalizer
DiracAudioControlService = 0

# datastatusnotification >
# allows to cap data when you've reached the limit of your plan
datastatusnotification = 0

# EmergencyInfo >
# could break double tap power button to launch camera, as well as being the app necessary to setup emergency info (obviously)
EmergencyInfo = 0

# Files - Google Document File Manager >
# File Manager app on Android Q
GoogleDocumentsUIPrebuilt = 0

# GoogleFeedback >
# Debloat this means remove ability to report bug to Google
GoogleFeedback = 1

# GoogleOneTimeInitializer >
# This is setup wizard helping you to base setup after a clean flash
GoogleOneTimeInitializer = 0

# GooglePartnerSetup >
# This is required if you want to setup a Google account
GooglePartnerSetup = 0

# GoogleTTS >
# Debloat this means remove ability to use Google Text to Speech
GoogleTTS = 1

# HotwordEnrollmentOKGoogleWCD9340 >
# makes OK Google work.
HotwordEnrollmentOKGoogleWCD9340 = 0

# HotwordEnrollmentXGoogleWCD9340 >
# makes OK Google work.
HotwordEnrollmentXGoogleWCD9340 = 0

# OnePlus Launcher >
# Debloating this will, enable the old vertical recents view known from Oreo but will also break OP gestures
# BEWARE! If you debloat this launcher, you MUST make sure that you have an alternative launcher in place, or you will end up with a black screen!
OnePlus_Launcher = 0

# OPBackup >
# System Updater for OOS Updates
OPBackup = 0

# OPContacts >
# OnePlus Contacts app. 
# Make sure you have an alternative Contacts app in place before you debloat this
OPContacts = 0

# OpSkin >
# apparently necessary for substratum and required to change OnePlus accents or themes without rebooting.
OpSkin = 0

# OPAod >
# Debloat this means remove ability to use ambient display feature
OPAod = 0

# OPFaceUnlock >
# Debloat this means remove ability to use Face Unlocking
OPFaceUnlock = 0

# OPSimContacts >
# Debloating this will remove the ability to switch to call history and contacts in the OOS dialer.
OPSimContacts = 0

# OPCellBroadcastReceiver >
# so you get alerts when there's a big issue like a natural disaster...
OPCellBroadcastReceiver = 1

# PartnerBookmarksProvider >
# App provides the list of partner installed apps to the Market
PartnerBookmarksProvider = 1

# PicoTts >
# Debloat this means remove ability to use Google Text to Speech
PicoTts = 1

# PlayAutoInstallConfig >
# basically allows the OEM or the carrier to download application behind your back, great feature :)
PlayAutoInstallConfig = 1

# QdcmFF >
# some Qualcomm software to make the screen better. I don't think it's used on the OP6 and it would probably make colors less accurate.
QdcmFF = 0

# SeempService >
# Solution from Qualcomm meant to possibly fight against Malware... Don't trust it.
SeempService = 1

# SetupWizard >
# This is a Setup Wizard which comes up when you create a new user account. Of course also your base account.
SetupWizard = 0

# Stk >
# Provides management of SIM provider contents on phone just as help etc. It’s useful if you want to use sim contents otherwise it’s not.
Stk = 1

# Tag >
# NFC Tags (it's not used by 99,9% of the population)
Tag = 0

# tts >
# Debloat this means remove ability to use Google Text to Speech
tts = 1

# Turbo >
# Device Health Services predicts how long your phone's battery will last based on your usage
# Attention! On the OP7pro enabling this will break the Proximity sensor functionallity
Turbo = 0

# uimremoteclient >
# qualcomm bullshit
uimremoteclient = 1

# usb_drivers.iso >
# Debloat this means remove USB Driver installation popup when connecting to PC
usb_drivers.iso = 1


# Extreme Debloating options without description
AutoRegistration = 1
BasicDreams = 1
BluetoothMidiService = 0
BTtestmode = 1
BuiltInPrintService = 1
DMAgent = 1
EasterEgg = 1
EngSpecialTest = 1
fmfactorytest = 1
LogKitSdService = 1
NFCTestMode = 1
OemAutoTestServer = 1
OpenWnn = 1

OPNotes = 1
OPSesAuthentication = 1
OPWidget = 1
PhotosOnline = 0
ProxyHandler = 0
RFTuner = 0
SecureSampleAuthService = 0
SensorTestTool = 1
SoterService = 0
VrCore = 1
WallpaperBackup = 0
WapiCertManage = 0
WifiLogger_app = 1
WifiRfTestApk = 1


# ------------------------------------------------------------------------------------------------
# E X P E R T S   O N L Y   D E B L O A T I N G   (belongs to the individual debloating section)
# Caution! Debloating in this section could potentially remove important core system functionality
# ------------------------------------------------------------------------------------------------

# ---- /system/app ----
Bluetooth = 0
BluetoothExt = 0
CallFeaturesSetting = 0
CaptivePortalLogin = 0
CarrierDefaultApp = 0
CertInstaller = 0
CompanionDeviceManager = 0
ConfURIDialer = 0
ConfUrlDialer = 0
CtsShimPrebuilt = 0
DeviceInfo = 0
DynamicDDSService = 0
DynamicDSService = 0
embms = 0
GoogleContactsSyncAdapter = 0
GoogleExtShared = 0
GooglePrintRecommendationService = 0
ims = 0
imssettings = 0
KeyChain = 0
NxpNfcNci = 0
NxpSecureElement = 0
oem_tcma = 0
OPIpTime = 0
OPMmsLocationFramework = 0
OPOnlineConfig = 0
OPTelephonyDiagnoseManager = 0
OPTelephonyCollectionData = 0
OPTelephonyOptimization = 0
SecureElement = 0
workloadclassifier = 0
OPYellowpage = 0
PacProcessor = 0
PrintSpooler = 0
QtiSystemService = 0
QtiTelephoneService = 0
QtiTelephonyService = 0
remotesimlockservice = 0
remotessimlockservice = 0
SCardService = 0
SdCardService = 0
SimAppDialog = 0
SimSettings = 0
smcinvokepkgmgr = 0
SmscPlugger = 0
SmsPlugger = 0
Traceur = 0
uimlpaservice = 0
WallpaperPicker = 0
WAPPushManager = 0
WebViewStub = 0
app_Backup = 0
app_colorservice = 0
app_FidoCryptoService = 0
app_Netflix_Activation = 0
app_Netflix_Stub = 0
app_OPSoundTuner = 0
app_Qmmi = 0
app_remoteSimLockAuthentication = 0
app_uceShimService = 0
app_workloadclassifier = 0


# ---- /system/priv-app ----
AndroidPlatformServices = 0
BlockedNumberProvider = 0
BlokedNumberProvider = 0
CalendarProvider = 0
CameraPicProcService = 0
CarrierConfig = 0
com.qualcomm.location = 0
ConfigUpdater = 0
ContactsProvider = 0
CtsShimPrivPrebuilt = 0
DefaultContainerService = 0
DownloadProvider = 0
DownloadProviderUI = 0
dpmserviceapp = 0
ExternalStorageProvider = 0
FusedLocation = 0
GmsCore = 0
GoogleExtServices = 0
GoogleLoginService = 0
GooglePackageInstaller = 0
GoogleServicesFramework = 0
IFAAService = 0
InputDevices = 0
MediaProvider = 0
MmsService = 0
MtpDocumentProvider = 0
MtpDocumentsProvider = 0
oneplus-framework-res = 0
OnePlusWizard = 0
OPAppCategoryProvider = 0
OPConfigurationClient = 0
OPCoreService = 0
OPNetworkSetting = 0
OPSettingProvider = 0
OPSettingsProvider = 0
OPCarrierLocation = 0
OPsystemUI = 0
OPWifiApSettings = 0
OobConfig = 0
Phonesky = 0
PowerOffAlarm = 0
qcrilmsgtunnel = 0
QualcommVoiceActivation = 0
DeviceStatisticsService = 0
com.qualcomm.qti.services.systemhelper = 0
Rftoolkit = 0
seccamservice = 0
Settings = 0
SettingsIntelligence = 0
Shell = 0
StatementService = 0
StorageManager = 0
Telecom = 0
TelephonyProvider = 0
TeleService = 0
UserDictionaryProvider = 0
VpnDialogs = 0
WfdService = 0
priv-app_daxService = 0
priv-app_TSDM = 0



# -------------------------------------------------------------------------------
# H y d r o g e n D e b l o a t i n g
# Safe to remove, but you might want to keep it
# HydrogenDebloating is a collection of 45+ items which only exist in H2OS
# but not in OOS. Most of them are Chinese apps. 
# -------------------------------------------------------------------------------

# H2OS MASTER SWITCH 
#	0 = Ignore all individual H2OS single debloat selections
#	1 = Debloat all selected items
HydrogenDebloating = 0

#---------------
H2OS_alipay = 1
H2OS_amap = 1
H2OS_baidushurufa = 1
H2OS_card = 1
H2OS_ctrip = 1
H2OS_douyin = 1
H2OS_EasterEgg_H2 = 1
H2OS_GameCenter = 1
H2OS_GaodeChuxing = 1
H2OS_hao123news = 1
H2OS_iqiyi = 1
H2OS_JD = 1
H2OS_Meituan = 1
H2OS_NearmeBrowser = 1
H2OS_NeteaseCloudmusic = 1
H2OS_NeteaseMail = 1
H2OS_NewsArticle = 1
H2OS_oneplusbbs = 1
H2OS_OPFindMyPhone = 1
H2OS_OPFindMyPhoneUtils = 1
H2OS_OPIconpackH2Default = 1
H2OS_OPIconpackH2Folio = 1
H2OS_OPIconpackH2Light = 1
H2OS_OPMarket = 1
H2OS_OposAds = 1
H2OS_OPSyncCenter = 1
H2OS_OPWallet = 1
H2OS_PhotosOnline = 1
H2OS_pinduoduo = 1
H2OS_QQBrowser = 1
H2OS_QQreader = 1
H2OS_Reader = 1
H2OS_SinaWeibo = 1
H2OS_taobao = 1
H2OS_TencentNews = 1
H2OS_TencentVideo = 1
H2OS_tmall = 1
H2OS_UCBrowser = 1
H2OS_XimalayaFM = 1
H2OS_YoudaoDict = 1
H2OS_youku = 1

# -------------------------------------------------------------------------------
# E N D of --> H y d r o g e n D e b l o a t i n g
# -------------------------------------------------------------------------------
