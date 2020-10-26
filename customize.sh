#!/sbin/sh
#set -e
#
# Script by xda Senior Member @xXx
#

RCV=ReadConfigValue
NLP=$TMPDIR/xXx.NoLimits.profile
Flags=$TMPDIR/system/etc/xXx/xXx.flags
ProfLog=/sdcard/xXx/logs/NoLimits.profile.log
TmpLog=$TMPDIR/profile.log
date_time=$(date +%Y-%m-%d_%H:%M:%S)

echo " " > $TmpLog
echo " " > $ProfLog

shjob() {
sh -x $TMPDIR/xXx_functions.sh $1 $2 $3 $4 $5 | tee -a $TMPDIR/shjob.log >&2
}

uzip() {
$TMPDIR/99 "x" "-y" "$1" "*" "-o$2/" >&2
rm -f $1
}

ZipWait() {
while [ $(pgrep 7za) ]; do
  sleep 0.1 
done
}

ReadConfigValue() {
value=$(sed -e '/^[[:blank:]]*#/d;s/[\t ]//g;/^$/d' $2 | grep "^$1=" | cut -d'=' -f 2);
if [ "$2" == "$NLP" ] && [ $value -gt 0 ] && [ ${ProfCat} != "nothing" ]; then
	ProfCat=$(printf "%-27s" ${ProfCat})
	echo "$ProfCat : ${1}=${value}" >> $TmpLog
fi
echo $value;
return $value;
}

ProfCat=nothing
ui_print " "; 
ui_print "==================================================";
ui_print " xXx NoLimits 12.3 Magisk ROM for OnePlus Devices ";
ui_print "==================================================";
ui_print " ";
ui_print "-> It may take several minutes, please wait...";
ui_print " ";
ui_print "-> Preparing work folder, be patient...";

SourceDir=$MODPATH/system/xXx
mv -f $SourceDir/99 $TMPDIR/99
set_perm_recursive $TMPDIR 0 0 0777 0777
t1=$(date +"%T")

packs=$(find $SourceDir -type f -print | sort -n | tail -1)
uzip $packs $TMPDIR
set_perm_recursive $TMPDIR 0 0 0777 0777

shjob prop check
ui_print " ";
if [ "$($RCV location $TMPDIR/xXx.prop.location)" == "0" ]; then
	ui_print ">> Using xXx.NoLimits.profile from rom.zip"
fi

if [ "$($RCV location $TMPDIR/xXx.prop.location)" == "/sdcard/xXx.NoLimits.profile" ]; then
	ui_print ">> Using xXx.NoLimits.profile from /sdcard/" 
fi

if [ "$($RCV location $TMPDIR/xXx.prop.location)" == "/sdcard/xXx/xXx.NoLimits.profile" ]; then
	ui_print ">> Using xXx.NoLimits.profile from /sdcard/xXx/" 
fi

if [ "$($RCV location $TMPDIR/xXx.prop.location)" == "/storage/usbotg/xXx.NoLimits.profile" ]; then
	ui_print ">> Using xXx.NoLimits.profile from OTG media" 
fi

if [ "$($RCV update $TMPDIR/xXx.prop.update)" == "1" ]; then
	ui_print ">> Be more patient - merging new profile to old profile"
	ui_print "   - old profile will be archived in /xXx/OldProfiles"
	shjob prop update
fi
ui_print " ";
ui_print "-> Unpack required packages, be patient...";

i=0
if [ "$($RCV CustomBootAnimation $NLP)" != "0" ] && [ "$($RCV CustomBootAnimation $NLP)" != "3" ]; then
   if [ -d /sdcard/xXx/bootanimation.zip ]; then
	  shjob rm d /sdcard/xXx/bootanimation.zip
   fi
   if [ -d /data/system/xXx/bootanimation.zip ]; then
	  shjob rm d /data/system/xXx/bootanimation.zip
   fi
   ui_print "   - unpack Bootanimations package"
   uzip $SourceDir/$i $TMPDIR;
else
   rm -f $SourceDir/$i
fi

i=$((i+1));
if [ "$($RCV YouTubeVanced $NLP)" != "0" ] && [ "$($RCV YouTubeVanced $NLP)" != "3" ]; then
   ui_print "   - unpack YouTube Vanced package"
   uzip $SourceDir/$i $TMPDIR;
else
   rm -f $SourceDir/$i
fi

i=$((i+1));
if [ "$($RCV GoogleDialer $NLP)" != "0" ]; then
   ui_print "   - unpack Google Dialer package"
   uzip $SourceDir/$i $TMPDIR;
else
   rm -f $SourceDir/$i
fi

i=$((i+1));
if [ "$($RCV GoogleCamera $NLP)" != "0" ]; then
   ui_print "   - unpack Google Camera package"
   uzip $SourceDir/$i $TMPDIR;
else
   rm -f $SourceDir/$i
fi

i=$((i+1));
if [ "$($RCV DaydreamVR $NLP)" != "0" ]; then
   ui_print "   - unpack Daydream VR package"
   uzip $SourceDir/$i $TMPDIR;
else
   rm -f $SourceDir/$i
fi

i=$((i+1));
if [ "$($RCV EmojiFont $NLP)" != "0" ] || [ "$($RCV StandardFont $NLP)" != "0" ]; then
   ui_print "   - unpack Fonts package"
   uzip $SourceDir/$i $TMPDIR;
else
   rm -f $SourceDir/$i
fi

i=$((i+1));
if [ "$($RCV PixelSounds $NLP)" != "0" ]; then
   ui_print "   - unpack Pixel Sounds package"
   uzip $SourceDir/$i $TMPDIR;
else
   rm -f $SourceDir/$i
fi

packs=$(find $SourceDir -type f -print)
for zpart in $packs; do
    ui_print "   - unpack last miscellaneous package"
	uzip $zpart $TMPDIR
done

shjob $t1 $(date +"%T")
set_perm_recursive $TMPDIR 0 0 0777 0777
shjob $t1 $(date +"%T")
 

ui_print "-> Basic System Preparations..."
shjob rm d /data/xXx
shjob rm d /data/media/xXx
shjob mkdir /data/system/xXx/
shjob cp d $TMPDIR/apps/Data/xXx /data/xXx/
shjob cp d $TMPDIR/misc/core/system $TMPDIR/system/etc/xXx/
shjob cp d $TMPDIR/misc/xbin/system $TMPDIR/system/
shjob cp d $TMPDIR/misc/SecretCodeEnable/system $TMPDIR/system/
rm -f /data/adb/service.d/india_fix.sh
rm -f /data/adb/service.d/overlay_fix.sh
modname=overlayfix
moddir=$NVBASE/modules/$modname
updir="$(echo $MODPATH | rev | cut -d'/' -f2- | rev)/$modname"
if [ "$(cat /proc/mounts | grep "^overlay " | awk '{print $2}' | tr '\n' ' ')" ] && [ "$($RCV india.img $NLP)" != "1" ]; then
  ui_print "-> Installing Overlay Fix...";
  ui_print "   - thanks to @Zackptg5... -";
  shjob $modname $moddir $updir
else
  if [ -d $moddir ]; then
	echo "Install Flag" > /data/system/xXx/overlayfix.flag;
  fi
fi
shjob debloat f /vendor/etc/init/hw/init.oem.debug.rc; shjob config.flags DisableLogs 1;
shjob debloat f /system/etc/init/traceur.rc;
shjob config.flags Tweaks 1
shjob build.prop sdk
shjob build.prop model
shjob build.prop romtype
shjob extsdrw

ui_print "-> Cleanup SU & BusyBox leftovers..." 
shjob cleaning b /data
shjob cleaning m /data
shjob cleaning s /data
shjob cp d '$sysfolder'/app/LiveWallpapersPicker $TMPDIR/apps/WallpaperPickerGoogle/system/app/LiveWallpapersPicker/


if [ "$($RCV IrreversibleDebloat $NLP)" == "1" ] && [ -f /system_root/system/build.prop ]; then
    ui_print "-> Delete Bloats from System Partition...";
	shjob config.flags IrreversibleDebloat 1
	mount -o rw,remount /system_root
fi

ProfCat=.Tweaks
if [ "$($RCV TweaksMasterSelector $NLP)" == "1" ] || [ "$($RCV TweaksMasterSelector $NLP)" == "2" ]; then
	ProfCat=.Tweaks__build.prop
	ui_print "-> Installing build.prop Tweaks...";
	sh $TMPDIR/btweaks.sh Misc.prop;
fi

if [ "$($RCV LMK_RAM_Management $NLP)" == "1" ]; then
	ui_print "  - Improved LMK RAM Management -";
	shjob config.flags LMK_RAM_Management 1;
fi
if [ "$($RCV LMK_RAM_Management $NLP)" == "2" ]; then
	ui_print "  - Aggressive LMK RAM Management -";
	shjob config.flags LMK_RAM_Management 2;
fi
if [ "$($RCV LMK_RAM_Management $NLP)" == "3" ]; then
	ui_print "  - LMKD RAM Management -";
	sh $TMPDIR/btweaks.sh LMKD.prop;	
	shjob config.flags LMK_RAM_Management 3;
fi


ProfCat=.Tweaks__Scripts
if [ "$($RCV ForceTweakApplication $NLP)" == "1" ]; then
	ui_print "  - Force Tweaks applying -";
	shjob config.flags ForceTweakApplication 1;
fi

if [ "$($RCV KernelTweaks $NLP)" == "1" ]; then
 ui_print "  - Kernel Tweaks -";
 shjob config.flags KernelTweaks 1
fi

if [ "$($RCV SELinuxSwitch $NLP)" == "1" ]; then
 ui_print "-> Set SELinux Enforced ..."; 
 shjob config.flags SELinuxSwitch 1
fi

if [ "$($RCV SELinuxSwitch $NLP)" == "2" ]; then
 ui_print "-> Set SELinux Permissive ...";
 shjob config.flags SELinuxSwitch 2
fi

if [ "$($RCV OnePlusNavigationGestures $NLP)" == "1" ]; then
	ui_print "-> Enable OnePlus Navigation Gestures...";
	shjob config.flags OnePlusNavigationGestures 1;
fi

if [ "$($RCV DaydreamVR $NLP)" == "1" ]; then
 ui_print "-> Add Daydream support ..."; 
 ui_print "   - thanks to skyball2 -";
 shjob cp d $TMPDIR/apps/DaydreamVR/system $TMPDIR/system/;
 shjob cp f $(find $TMPDIR/apps/DaydreamVR/system -type f -name "*DaydreamVR.apk*") /data/xXx/
 shjob cp f $(find $TMPDIR/apps/DaydreamVR/system -type f -name "*DaydreamKB.apk*") /data/xXx/ 
 shjob dalvik DaydreamVR com.google.android.vr.home;
 shjob dalvik DaydreamKB com.google.android.vr.inputmethod;
 shjob apps2data Daydream;
else
  if [ -f /data/system/xXx/Daydream.flag ]; then
    ui_print "-> Uninstalling Daydream support...";
    shjob dalvik DaydreamVR com.google.android.vr.home;
    shjob dalvik DaydreamKB com.google.android.vr.inputmethod;   
 	shjob apps2data DaydreamRM;
  fi 
fi


ProfCat=.Tweaks__Misc
if [ "$($RCV DisableGooglePlayWakelocks $NLP)" == "1" ]; then
 ui_print "-> Disable Google Play Wakelocks ...";
 shjob config.flags Wakelocks disable;
fi

if [ "$($RCV DisplayRefreshRate $NLP)" == "1" ]; then
 ui_print "  - Force Low display refresh rate -";
 shjob config.flags DisplayRefreshRate 1;
fi

if [ "$($RCV DisplayRefreshRate $NLP)" == "2" ]; then
 ui_print "  - Force High display refresh rate -";
 shjob config.flags DisplayRefreshRate 0;
fi

if [ "$($RCV 2.4GHzWiFichannelbonding $NLP)" == "1" ]; then
 ui_print "  - 2.4GHz WiFi channel bonding -";
 shjob wifi CB;
fi

if [ "$($RCV DisableGooglePlayWakelocks $NLP)" == "2" ]; then
 ui_print "-> Disable Google Play Wakelocks Extended ...";
 shjob config.flags Wakelocks disable;
 shjob config.flags ExtWakelocks disable;
fi

if [ "$($RCV DisableGooglePlayWakelocks $NLP)" == "0" ]; then
 shjob config.flags Wakelocks enable;
fi

if [ "$($RCV DisableGoogleAnalytics $NLP)" == "1" ]; then
 ui_print "-> Disable Google Analytics ...";
 shjob config.flags GoogleAnalytics disable;
fi

if [ "$($RCV Universal.GMS.Doze $NLP)" == "1" ]; then
 ui_print "-> Install Universal GMS Doze ...";
 ui_print "   - thanks to @gloeyisk -";
 shjob GMS.doze;
 shjob config.flags GMSdoze enabled;
fi


if [ "$($RCV DisableZRAM $NLP)" == "1" ]; then
 ui_print "-> Disable the OnePlus ZRAM/ZSWAP implementation only ...";
 shjob zram 1;
fi

if [ "$($RCV DisableZRAM $NLP)" == "2" ]; then
 ui_print "-> Disable ZRAM completely...";
 shjob zram 2;
fi

if [ "$($RCV RebuildDalvikCache $NLP)" == "1" ]; then
 ui_print "-> Rebuild Dalvik Cache if required on reboot...";
 shjob config.flags RebuildDalvikCache 1;
fi

if [ "$($RCV DebloatUserApps $NLP)" == "1" ]; then
 shjob config.flags DebloatUserApps 1;
else
 ui_print "-> Debloating don't touch User Apps...";
 shjob config.flags DebloatUserApps 0;
fi


if [ "$($RCV HideNoLimitsVersionInABOUTinfo $NLP)" == "1" ]; then
 ui_print "-> Hide NoLimits Version on About screen...";
 shjob config.flags HideVersion 1;
else
 shjob config.flags HideVersion 0;
fi



ProfCat=1_Debloating_Bulk

if [ "$($RCV ExtremeDebloating $NLP)" == "1" ] && [ "$($RCV IndividualDebloatSelection $NLP)" != "1" ]; then
	ui_print "-> Extreme ROM debloating...";
	ui_print "   - thanks to @ahmed_radaideh -";
	shjob debloat d /app/Account com.oneplus.account;
	shjob debloat d /app/AndroidPay;
	shjob debloat d /app/Chrome com.android.chrome;
	shjob debloat d /app/Drive com.google.android.apps.docs;
	shjob debloat d /app/Gmail2 com.google.android.gm;
	shjob debloat d /app/Hangouts;
	shjob debloat d /app/GooglePay com.google.android.apps.walletnfcrel;
	shjob debloat d /app/LiveWallpapersPicker;
	shjob debloat d /app/Maps com.google.android.apps.maps;
	shjob debloat d /app/Music2 com.google.android.music;
	shjob debloat d /app/OPBackupRestore;
	shjob debloat d /reserve/OPFilemanager com.oneplus.filemanager;
	shjob debloat d /reserve/OPForum net.oneplus.forums;
	shjob debloat d /app/DeviceHealthService com.google.android.apps.turbo;
	shjob debloat d /reserve/OPMusic;
	shjob debloat d /app/OPPush;
	shjob debloat d /priv-app/GoogleDocumentsUIPrebuilt com.google.android.documentsui;
	shjob debloat d /priv-app/H2DefaultIconPack; 
	shjob debloat d /priv-app/H2FolioIconPack; 
	shjob debloat d /priv-app/H2LightIconPack; 
	shjob debloat d /priv-app/OneplusIconPack; 
	shjob debloat d /priv-app/OneplusSquareIconPack;
	shjob debloat d /priv-app/OPIconpack;
	shjob debloat d /app/Photos com.google.android.apps.photos;
	shjob debloat d /reserve/SoundRecorder com.oneplus.soundrecorder;
	shjob debloat d /app/SwiftKey;
	shjob debloat d /app/talkback;
	shjob debloat d /app/Videos com.google.android.videos;
	shjob debloat d /reserve/Weather net.oneplus.weather;
	shjob debloat d /app/YouTube com.google.android.youtube;
	shjob debloat d /app/BasicDreams;
	shjob debloat d /app/BookmarkProvider;
	shjob debloat d /app/BTtestmode;
	shjob debloat f /bin/bugreportz;
	shjob debloat d /app/DMAgent;
	shjob debloat d /app/Duo com.google.android.apps.tachyon;
	shjob debloat d /app/EasterEgg;
	shjob debloat d /app/EngineeringMode;
	shjob debloat d /app/EngSpecialTest;
	shjob debloat f /bin/fmfactorytestserver;
	shjob debloat d /app/LogKitSdService;
	shjob debloat d /app/NFCTestMode;
	shjob debloat d /app/OemAutoTestServer;
	shjob debloat d /app/OEMLogKit;
	shjob debloat f /bin/oemlogkit;
	shjob debloat d /app/OPBugReportLite;
	shjob debloat d /app/OPCommonLogTool
	shjob debloat d /priv-app/OPDeviceManager;
	shjob debloat d /priv-app/OPDeviceManagerProvider;
	shjob debloat d /app/OpenWnn;
	shjob debloat d /app/PartnerBookmarksProvider;
	shjob debloat d /app/SecureSampleAuthService;
	shjob debloat d /app/SensorTestTool;
	shjob debloat d /app/Stk;
	shjob debloat f /etc/usb_drivers.iso;
	shjob debloat f /bin/WifiLogger_app;
	shjob debloat d /app/WifiRfTestApk;
	shjob debloat d /tts;
	shjob debloat d /app/PicoTts;
	shjob debloat d /app/GoogleTTS com.google.android.tts;
	shjob debloat d /app/VrCore;
	shjob debloat d /app/OPBreathMode com.oneplus.brickmode;
	shjob debloat f /in/mshop.apk in.amazon.mShop.android.shopping;
	shjob debloat f /app/By_3rd_AmazonShoppingKebabIndia in.amazon.mShop.android.shopping;
	shjob debloat f /in/mdip.apk com.amazon.appmanager;
	shjob debloat f /in/kindle.apk com.amazon.kindle;
	shjob debloat f /in/atv.apk com.amazon.avod.thirdpartyclient;
	shjob debloat d /app/Nearme com.finshell.atlas;
	shjob debloat d /app/HeytapIdProvider com.heytap.openid;
	shjob debloat d /app/heytab_mcs com.heytap.mcs;
	shjob debloat d /app/TVCast com.oneplus.tvcast;
	shjob debloat d /app/OPMemberShip com.oneplus.membership;	
	shjob debloat d /app/Netflix_Activation;
	shjob debloat d /app/netflix-activation;
	shjob debloat d /app/Netflix_Stub;
	shjob debloat d /app/netflix-stub;
	shjob debloat d /app/By_3rd_NetflixActivationOverSeas;
	shjob debloat d /app/By_3rd_NetflixStubOverSeas;
	shjob debloat d /app/FBAppmanager com.facebook.appmanager;
	shjob debloat d /priv-app/FBInstaller com.facebook.system;
	shjob debloat d /priv-app/FBServices com.facebook.services;
	shjob debloat d /reserve/By_3rd_FacebookOverSeas com.facebook.katana;
	shjob debloat d /reserve/By_3rd_FBAppManagerOverSeas com.facebook.appmanager;
	shjob debloat d /reserve/FBAppmanager com.facebook.appmanager;
	shjob debloat d /reserve/By_3rd_FBInstallOverSeas com.facebook.system;
	shjob debloat d /reserve/By_3rd_MessengerOverSeas com.facebook.orca;	
	shjob debloat d /app/YTMusic com.google.android.apps.youtube.music;
	shjob debloat d /app/GoogleNews com.google.android.apps.magazines;
	shjob debloat d /app/GooglePodcasts com.google.android.apps.podcasts;
fi

if [ "$($RCV OnePlusAnalyticsDisablerLight $NLP)" == "1" ]; then
	ui_print "-> Light Analytics Disabling...";
	shjob debloat d /priv-app/OPDeviceManager net.oneplus.odm;
	shjob debloat d /priv-app/OPDeviceManagerProvider;
fi

if [ "$($RCV OnePlusAnalyticsDisablerFull $NLP)" == "1" ]; then
	ui_print "-> Full Analytics Disabling...";
	shjob debloat d /app/EngineeringMode;
	shjob debloat d /app/LogKitSdService;
	shjob debloat d /app/OEMLogKit;
	shjob debloat d /app/OPBugReportLite;
	shjob debloat d /app/OPBugReport_Complete;
	shjob debloat d /app/OPCommonLogTool; 
	shjob debloat d /priv-app/OPDeviceManager net.oneplus.odm;
	shjob debloat d /priv-app/OPDeviceManagerProvider;
	shjob debloat f /bin/oemlogkit;
	shjob debloat f /bin/bugreportz;
	shjob debloat f /bin/bugreport;
	shjob debloat f /lib/libdoor.so;
	shjob debloat f /lib64/libdoor.so;
fi



if [ "$($RCV HydrogenDebloating $NLP)" == "1" ]; then
	ui_print "-> Bulk debloating all selected H2OS items...";

	if [ "$($RCV H2OS_Account $NLP)" == "1" ]; then
		shjob debloat d /app/Account com.oneplus.account;
	fi

	if [ "$($RCV H2OS_alipay $NLP)" == "1" ]; then
		shjob debloat d /app/alipay com.eg.android.AlipayGphone;
	fi

	if [ "$($RCV H2OS_amap $NLP)" == "1" ]; then
		shjob debloat d /app/amap com.autonavi.minimap;
	fi

	if [ "$($RCV H2OS_baidushurufa $NLP)" == "1" ]; then
		shjob debloat d /app/baidushurufa com.baidu.input_yijia;
	fi

	if [ "$($RCV H2OS_card $NLP)" == "1" ]; then
		shjob debloat d /app/card com.oneplus.card;
	fi

	if [ "$($RCV H2OS_ctrip $NLP)" == "1" ]; then
		shjob debloat d /app/ctrip ctrip.android.view;
	fi

	if [ "$($RCV H2OS_douyin $NLP)" == "1" ]; then
		shjob debloat d /app/douyin com.ss.android.ugc.aweme;
		shjob debloat d /vendor/reserve/douyin com.ss.android.ugc.aweme;	
	fi

	if [ "$($RCV H2OS_EasterEgg_H2 $NLP)" == "1" ]; then
		shjob debloat d /app/EasterEgg_H2 com.android.egg;
	fi

	if [ "$($RCV H2OS_GameCenter $NLP)" == "1" ]; then
		shjob debloat d /app/GameCenter com.nearme.gamecenter;
	fi

	if [ "$($RCV H2OS_GaodeChuxing $NLP)" == "1" ]; then
		shjob debloat d /app/GaodeChuxing com.autonavi.manu.widget;
	fi

	if [ "$($RCV H2OS_hao123news $NLP)" == "1" ]; then
		shjob debloat d /app/hao123news com.baidu.haokan;
	fi

	if [ "$($RCV H2OS_iqiyi $NLP)" == "1" ]; then
		shjob debloat d /app/iqiyi com.qiyi.video;
		shjob debloat d /vendor/reserve/iqiyi com.qiyi.video;	
	fi

	if [ "$($RCV H2OS_JD $NLP)" == "1" ]; then
		shjob debloat d /app/JD com.jingdong.app.mall;
	fi

	if [ "$($RCV H2OS_Meituan $NLP)" == "1" ]; then
		shjob debloat d /app/Meituan com.sankuai.meituan;
	fi

	if [ "$($RCV H2OS_NearmeBrowser $NLP)" == "1" ]; then
		shjob debloat d /app/NearmeBrowser com.nearme.browser;
		shjob debloat d /app/By_3rd_NearmeBrowserChina com.nearme.browser;
	fi

	if [ "$($RCV H2OS_NearmeBrowser $NLP)" == "1" ]; then
		shjob debloat d /app/NearmeBrowser com.nearme.browser;
		shjob debloat d /app/By_3rd_NearmeBrowserChina com.nearme.browser;
	fi

	if [ "$($RCV H2OS_NeteaseCloudmusic $NLP)" == "1" ]; then
		shjob debloat d /app/NeteaseCloudmusic com.netease.cloudmusic;
	fi

	if [ "$($RCV H2OS_NeteaseMail $NLP)" == "1" ]; then
		shjob debloat d /app/NeteaseMail com.netease.mail;
	fi

	if [ "$($RCV H2OS_NewsArticle $NLP)" == "1" ]; then
		shjob debloat d /app/NewsArticle com.ss.android.article.news;
	fi

	if [ "$($RCV H2OS_oneplusbbs $NLP)" == "1" ]; then
		shjob debloat d /app/oneplusbbs com.oneplus.bbs;
	fi

	if [ "$($RCV H2OS_OPFindMyPhone $NLP)" == "1" ]; then
		shjob debloat d /app/OPFindMyPhone com.oneplus.findmyphone;
	fi

	if [ "$($RCV H2OS_OPFindMyPhoneUtils $NLP)" == "1" ]; then
		shjob debloat d /app/OPFindMyPhoneUtils com.oneplus.findmyphoneutils;
	fi

	if [ "$($RCV H2OS_OPIconpackH2Default $NLP)" == "1" ]; then
		shjob debloat d /app/OPIconpackH2Default com.oneplus.iconpack.h2default;
	fi

	if [ "$($RCV H2OS_OPIconpackH2Folio $NLP)" == "1" ]; then
		shjob debloat d /app/OPIconpackH2Folio com.oneplus.iconpack.h2folio;
	fi

	if [ "$($RCV H2OS_OPIconpackH2Light $NLP)" == "1" ]; then
		shjob debloat d /app/OPIconpackH2Light com.oneplus.iconpack.h2light;
	fi

	if [ "$($RCV H2OS_OPMarket $NLP)" == "1" ]; then
		shjob debloat d /app/OPMarket com.oppo.market;
	fi

	if [ "$($RCV H2OS_OposAds $NLP)" == "1" ]; then
		shjob debloat d /app/OposAds com.opos.ads;
	fi

	if [ "$($RCV H2OS_OposAds $NLP)" == "1" ]; then
		shjob debloat d /app/OposAds com.opos.ads;
	fi

	if [ "$($RCV H2OS_OPSyncCenter $NLP)" == "1" ]; then
		shjob debloat d /app/OPSyncCenter com.oneplus.cloud;
	fi

	if [ "$($RCV H2OS_OPWallet $NLP)" == "1" ]; then
		shjob debloat d /app/OPWallet cn.oneplus.wallet;
	fi

	if [ "$($RCV H2OS_PhotosOnline $NLP)" == "1" ]; then
		shjob debloat d /app/PhotosOnline cn.oneplus.photos;
	fi

	if [ "$($RCV H2OS_pinduoduo $NLP)" == "1" ]; then
		shjob debloat d /app/pinduoduo com.xunmeng.pinduoduo;
	fi

	if [ "$($RCV H2OS_QQBrowser $NLP)" == "1" ]; then
		shjob debloat d /app/QQBrowser com.android.browser;
	fi

	if [ "$($RCV H2OS_QQreader $NLP)" == "1" ]; then
		shjob debloat d /app/QQreader ;
	fi

	if [ "$($RCV H2OS_Reader $NLP)" == "1" ]; then
		shjob debloat d /app/Reader com.heytap.reader;
	fi

	if [ "$($RCV H2OS_SinaWeibo $NLP)" == "1" ]; then
		shjob debloat d /app/SinaWeibo com.sina.weibo;
	fi

	if [ "$($RCV H2OS_taobao $NLP)" == "1" ]; then
		shjob debloat d /app/taobao com.taobao.taobao;
	fi

	if [ "$($RCV H2OS_TencentNews $NLP)" == "1" ]; then
		shjob debloat d /app/TencentNews com.tencent.news;
	fi

	if [ "$($RCV H2OS_TencentVideo $NLP)" == "1" ]; then
		shjob debloat d /app/TencentVideo com.tencent.qqlive;
	fi

	if [ "$($RCV H2OS_tmall $NLP)" == "1" ]; then
		shjob debloat d /app/tmall com.tmall.wireless;
		shjob debloat d /vendor/reserve/tmall com.tmall.wireless;	
	fi

	if [ "$($RCV H2OS_UCBrowser $NLP)" == "1" ]; then
		shjob debloat d /app/UCBrowser com.UCMobile;
	fi

	if [ "$($RCV H2OS_XimalayaFM $NLP)" == "1" ]; then
		shjob debloat d /app/XimalayaFM com.ximalaya.ting.android;
		shjob debloat d /vendor/reserve/XimalayaFM com.ximalaya.ting.android;
	fi

	if [ "$($RCV H2OS_YoudaoDict $NLP)" == "1" ]; then
		shjob debloat d /app/YoudaoDict com.youdao.dict;
		shjob debloat d /vendor/reserve/YoudaoDict com.youdao.dict;
	fi

	if [ "$($RCV H2OS_youku $NLP)" == "1" ]; then
		shjob debloat d /app/youku com.youku.phone;
	fi
fi




if [ "$($RCV GAppsPicolevel $NLP)" == "1" ]; then
	ui_print "-> Debloat Google Framework down to Pico level...";
	shjob debloat d /app/Chrome com.android.chrome;
	shjob debloat d /app/DMAgent;
	shjob debloat d /app/Drive com.google.android.apps.docs;
	shjob debloat d /app/Duo com.google.android.apps.tachyon;
	shjob debloat d /app/FaceLock;
	shjob debloat d /app/Gmail2 com.google.android.gm;
	shjob debloat d /app/GooglePay com.google.android.apps.walletnfcrel;
	shjob debloat d /app/GooglePrintRecommendationService;
	shjob debloat d /app/Maps com.google.android.apps.maps;
	shjob debloat d /app/Music2 com.google.android.music;
	shjob debloat d /app/Photos com.google.android.apps.photos;
	shjob debloat d /app/talkback;
	shjob debloat d /app/Videos com.google.android.videos;
	shjob debloat d /app/YouTube com.google.android.youtube;
	shjob debloat d /app/YTMusic com.google.android.apps.youtube.music;
	shjob debloat d /app/GoogleNews com.google.android.apps.magazines;
	shjob debloat d /app/GooglePodcasts com.google.android.apps.podcasts;
fi


if [ "$($RCV TotalGAppsremoval $NLP)" == "1" ]; then
	ui_print "-> Totally remove Goggle Framework...";
	shjob debloat d /app/Chrome com.android.chrome;
	shjob debloat d /app/CalendarGoogle com.google.android.calendar;
	shjob debloat d /app/DMAgent;
	shjob debloat d /app/Drive com.google.android.apps.docs;
	shjob debloat d /app/Duo com.google.android.apps.tachyon;
	shjob debloat d /app/FaceLock;
	shjob debloat d /priv-app/GoogleDocumentsUIPrebuilt com.google.android.documentsui;	
	shjob debloat d /app/OPGamingSpace com.oneplus.gamespace;
	shjob debloat d /app/Gmail2 com.google.android.gm;
	shjob debloat d /app/DeviceHealthService com.google.android.apps.turbo;
	shjob debloat d /app/GooglePay com.google.android.apps.walletnfcrel;
	shjob debloat d /app/GoogleContactsSyncAdapter;
	shjob debloat d /app/GooglePrintRecommendationService;
	shjob debloat d /app/GoogleTTS com.google.android.tts;
	shjob debloat d /app/Maps com.google.android.apps.maps;
	shjob debloat d /app/Music2 com.google.android.music;
	shjob debloat d /app/Photos com.google.android.apps.photos;
	shjob debloat d /app/talkback;
	shjob debloat d /app/Videos com.google.android.videos;
	shjob debloat d /app/YouTube com.google.android.youtube;
	shjob debloat d /priv-app/ConfigUpdater;
	shjob debloat d /priv-app/GoogleBackupTransport;
	shjob debloat d /priv-app/GoogleFeedback;
	shjob debloat d /priv-app/GoogleLoginService;
	shjob debloat d /priv-app/GoogleOneTimeInitializer;
	shjob debloat d /priv-app/GooglePartnerSetup;
	shjob debloat d /priv-app/GoogleServicesFramework;
	shjob debloat d /priv-app/Phonesky;
	shjob debloat d /priv-app/SetupWizard;
	shjob debloat d /priv-app/Velvet com.google.android.googlequicksearchbox;
	shjob debloat d /app/YTMusic com.google.android.apps.youtube.music;
	shjob debloat d /app/GoogleNews com.google.android.apps.magazines;
	shjob debloat d /app/GooglePodcasts com.google.android.apps.podcasts;
fi

ProfCat=2_Debloating__Light
if [ "$($RCV IndividualDebloatSelection $NLP)" == "1" ]; then
	ui_print "-> Debloat based on individual selections...";

	if [ "$($RCV india.img $NLP)" == "1" ]; then
	shjob config.flags india.img 1
	fi	

	if [ "$($RCV GoogleChrome $NLP)" == "1" ]; then
	shjob debloat d /app/Chrome com.android.chrome;
	fi

	if [ "$($RCV AndroidPay $NLP)" == "1" ]; then
	shjob debloat d /app/AndroidPay;
	fi

	if [ "$($RCV Account $NLP)" == "1" ]; then
		shjob debloat d /app/Account com.oneplus.account;
	fi
	
	if [ "$($RCV AmazonPrimeVideo $NLP)" == "1" ]; then
	shjob debloat f /in/atv.apk com.amazon.avod.thirdpartyclient;
	fi	
	
	if [ "$($RCV AmazonKindl $NLP)" == "1" ]; then
	shjob debloat f /in/kindle.apk com.amazon.kindle;
	fi

	if [ "$($RCV AmazonAppmanager $NLP)" == "1" ]; then
	shjob debloat f /in/mdip.apk com.amazon.appmanager;
	shjob debloat d /reserve/MaftPreloadManager com.amazon.appmanager;
	fi

	if [ "$($RCV AmazonShop $NLP)" == "1" ]; then
	shjob debloat f /in/mshop.apk in.amazon.mShop.android.shopping;
	shjob debloat d /app/By_3rd_AmazonShoppingKebabIndia in.amazon.mShop.android.shopping;
	shjob debloat d /app/AmazonShoppingMDIP in.amazon.mShop.android.shopping;
	fi
	
	if [ "$($RCV DigitalWellBeing $NLP)" == "1" ]; then
	  shjob debloat d /priv-app/Wellbeing com.google.android.apps.wellbeing;
	  shjob debloat d /priv-app/WellbeingPrebuilt com.google.android.apps.wellbeing;
	  shjob dalvik DigitalWellbeing com.google.android.apps.wellbeing;
	fi

	if [ "$($RCV OPMemberShip $NLP)" == "1" ]; then
		shjob debloat d /app/OPMemberShip com.oneplus.membership;
	fi
	
	if [ "$($RCV OPsports $NLP)" == "1" ]; then
		shjob debloat d /app/OPSports com.oneplus.opsports;
	fi	
	
	if [ "$($RCV TVCast $NLP)" == "1" ]; then
		shjob debloat d /app/TVCast com.oneplus.tvcast;
	fi
	
	if [ "$($RCV CloudService $NLP)" == "1" ]; then
		shjob debloat d /priv-app/CloudService com.heytap.cloud;
		shjob debloat d /priv-app/By_3rd_CloudServiceIndia com.heytap.cloud;
		shjob debloat d /priv-app/By_3rd_CloudServiceChina com.heytap.cloud;		
	fi	
	
	if [ "$($RCV heytab_mcs $NLP)" == "1" ]; then
		shjob debloat d /app/heytab_mcs com.heytap.mcs;
		shjob debloat d /app/heytap_mcs_in com.heytap.mcs;
	fi
	
	if [ "$($RCV HeytapIdProvider $NLP)" == "1" ]; then
		shjob debloat d /app/HeytapIdProvider com.heytap.openid;
		shjob debloat d /app/By_3rd_HeytapIdProviderIndia com.heytap.openid;
		shjob debloat d /app/By_3rd_HeytapIdProviderChina com.heytap.openid;		
	fi
	
	if [ "$($RCV Nearme $NLP)" == "1" ]; then
		shjob debloat d /app/Nearme com.finshell.atlas;
		shjob debloat d /app/By_3rd_NearmeIndia com.finshell.atlas;
		shjob debloat d /app/By_3rd_NearmeChina com.finshell.atlas;
	fi

	if [ "$($RCV AndroidAuto $NLP)" == "1" ]; then
     shjob debloat d /priv-app/AndroidAutoStub com.google.android.projection.gearhead;
	fi
	
	if [ "$($RCV DeviceHealthService $NLP)" == "1" ]; then
	shjob debloat d /app/DeviceHealthService com.google.android.apps.turbo;
	fi	

	if [ "$($RCV ARCore $NLP)" == "1" ]; then
	shjob debloat d /app/ARCore_stub com.google.ar.core;
	fi

	if [ "$($RCV GooglePay $NLP)" == "1" ]; then
	shjob debloat d /app/GooglePay com.google.android.apps.walletnfcrel;
	fi
	
	if [ "$($RCV GoogleNews $NLP)" == "1" ]; then
	shjob debloat d /app/GoogleNews com.google.android.apps.magazines;
	fi

	if [ "$($RCV GoogleAssistant $NLP)" == "1" ]; then
	shjob debloat d /app/GoogleAssistant com.google.android.apps.googleassistant;
	fi
	
	if [ "$($RCV GooglePodcasts $NLP)" == "1" ]; then
	shjob debloat d /app/GooglePodcasts com.google.android.apps.podcasts;
	fi	
	
	if [ "$($RCV GoogleDocumentsUIPrebuilt $NLP)" == "1" ]; then
	shjob debloat d /priv-app/GoogleDocumentsUIPrebuilt com.google.android.documentsui;
	fi	

	if [ "$($RCV CalendarGoogle $NLP)" == "1" ]; then
	shjob debloat d /app/CalendarGoogle com.google.android.calendar;
	fi

	if [ "$($RCV Drive $NLP)" == "1" ]; then
	shjob debloat d /app/Drive com.google.android.apps.docs;
	fi

	if [ "$($RCV Gboard-GoogleKeyboard $NLP)" == "1" ]; then
	shjob debloat d /app/LatinImeGoogle;
	fi
	
	if [ "$($RCV GoogleSpace $NLP)" == "1" ]; then
	shjob debloat d /app/OPGamingSpace com.oneplus.gamespace;
	fi	

	if [ "$($RCV Gmail2 $NLP)" == "1" ]; then
	shjob debloat d /app/Gmail2 com.google.android.gm;
	fi

	if [ "$($RCV Hangouts $NLP)" == "1" ]; then
	shjob debloat d /app/Hangouts;
	fi

	if [ "$($RCV LiveWallpapersPicker $NLP)" == "1" ]; then
	shjob debloat d /app/LiveWallpapersPicker;
	fi

	if [ "$($RCV Maps $NLP)" == "1" ]; then
	shjob debloat d /app/Maps com.google.android.apps.maps;
	fi

	if [ "$($RCV Music2 $NLP)" == "1" ]; then
	shjob debloat d /app/Music2 com.google.android.music;
	fi

	if [ "$($RCV OPDialer+Contacts $NLP)" == "1" ]; then
	 shjob debloat d /priv-app/Contacts com.android.contacts;
	 shjob debloat d /priv-app/Dialer com.android.dialer;
	fi

	if [ "$($RCV OPContacts $NLP)" == "1" ]; then
	 shjob debloat d /priv-app/Contacts com.android.contacts;
	fi

	if [ "$($RCV OnePlusSwitch $NLP)" == "1" ]; then
	shjob debloat d /app/OPBackupRestore com.oneplus.backuprestore;
	shjob debloat d /reserve/OPBackupRestore com.oneplus.backuprestore;
	fi
	
	if [ "$($RCV OnePlusPods $NLP)" == "1" ]; then
	shjob debloat d /app/OnePlusPods com.oneplus.twspods;
	fi	

	if [ "$($RCV OPFilemanager $NLP)" == "1" ]; then
	shjob debloat d /reserve/OPFilemanager com.oneplus.filemanager;
	fi

	if [ "$($RCV OPNotes $NLP)" == "1" ]; then
	shjob debloat d /reserve/OPNote com.oneplus.note;
	fi

	if [ "$($RCV OPSimContacts $NLP)" == "1" ]; then
	shjob debloat d /priv-app/OPSimContacts;
	fi

	if [ "$($RCV OPForum $NLP)" == "1" ]; then
	shjob debloat d /reserve/OPForum net.oneplus.forums;
	fi

	if [ "$($RCV OPMusic $NLP)" == "1" ]; then
	shjob debloat d /reserve/OPMusic;
	fi

	if [ "$($RCV Instagram $NLP)" == "1" ]; then
	shjob debloat d /reserve/instagram-localapk-stub com.instagram.android;
	shjob debloat d /reserve/By_3rd_InstagramOverSeas com.instagram.android;	
	fi	

	if [ "$($RCV OPPush $NLP)" == "1" ]; then
	shjob debloat d /app/OPPush;
	fi

	if [ "$($RCV OPIcons $NLP)" == "1" ]; then
	 shjob debloat d /priv-app/H2DefaultIconPack;
	 shjob debloat d /priv-app/H2FolioIconPack;
	 shjob debloat d /priv-app/H2LightIconPack;
	 shjob debloat d /priv-app/OneplusIconPack;
	 shjob debloat d /priv-app/OneplusSquareIconPack;
	 shjob debloat d /priv-app/OPIconpack;
	 shjob debloat d /reserve/OPIconpackCircle com.oneplus.iconpack.circle;
	 shjob debloat d /reserve/OPIconpackOnePlus com.oneplus.iconpack.oneplus;
	 shjob debloat d /reserve/OPIconpackSquare com.oneplus.iconpack.square;
	fi

	if [ "$($RCV OPWorkLifeBalance $NLP)" == "1" ]; then
	shjob debloat d /priv-app/OPWorkLifeBalance com.oneplus.opwlb;
	fi
	
	if [ "$($RCV OPGamingSpace $NLP)" == "1" ]; then
	shjob debloat d /app/OPGamingSpace com.oneplus.gamespace;
	fi

	if [ "$($RCV Photos $NLP)" == "1" ]; then
	shjob debloat d /app/Photos com.google.android.apps.photos;
	fi

	if [ "$($RCV SoundRecorder $NLP)" == "1" ]; then
	shjob debloat d /reserve/SoundRecorder com.oneplus.soundrecorder;
	fi

	if [ "$($RCV SwiftKey $NLP)" == "1" ]; then
	shjob debloat d /app/SwiftKey;
	fi

	if [ "$($RCV talkback $NLP)" == "1" ]; then
	shjob debloat d /app/talkback;
	fi

	if [ "$($RCV Velvet-GoogleApp $NLP)" == "1" ]; then
	shjob debloat d /priv-app/Velvet com.google.android.googlequicksearchbox;
	fi

	if [ "$($RCV Videos $NLP)" == "1" ]; then
	shjob debloat d /app/Videos com.google.android.videos;
	fi

	if [ "$($RCV Weather $NLP)" == "1" ]; then
	shjob debloat d /reserve/Weather net.oneplus.weather;
	fi

	if [ "$($RCV YouTube $NLP)" == "1" ]; then
	shjob debloat d /app/YouTube com.google.android.youtube;
	fi

	if [ "$($RCV Card $NLP)" == "1" ]; then
	 shjob debloat d /reserve/card com.oneplus.card;
	 shjob debloat d /app/card com.oneplus.card;
	fi

	if [ "$($RCV GoogleBackupTransport $NLP)" == "1" ]; then
	shjob debloat d /priv-app/GoogleBackupTransport;
	fi

	if [ "$($RCV BackupRestoreRemoteService $NLP)" == "1" ]; then
	shjob debloat d /app/BackupRestoreRemoteService com.oneplus.backuprestore.remoteservice;
	fi

	if [ "$($RCV DeskClock $NLP)" == "1" ]; then
	shjob debloat d /app/DeskClock;
	fi

	if [ "$($RCV HTMLViewer $NLP)" == "1" ]; then
	shjob debloat d /app/HTMLViewer;
	fi

	if [ "$($RCV NVBackupUI $NLP)" == "1" ]; then
	shjob debloat d /app/NVBackupUI;
	fi

	if [ "$($RCV BackupRestoreConfirmation $NLP)" == "1" ]; then
	shjob debloat d /priv-app/BackupRestoreConfirmation;
	fi

	if [ "$($RCV CallLogBackup $NLP)" == "1" ]; then
	shjob debloat d /priv-app/CallLogBackup;
	fi

	if [ "$($RCV GoogleRestore $NLP)" == "1" ]; then
	shjob debloat d /priv-app/GoogleRestore;
	fi

	if [ "$($RCV ManagedProvisioning $NLP)" == "1" ]; then
	shjob debloat d /priv-app/ManagedProvisioning;
	fi

	if [ "$($RCV OPAppLocker $NLP)" == "1" ]; then
	shjob debloat d /priv-app/OPAppLocker;
	fi

	if [ "$($RCV SharedStorageBackup $NLP)" == "1" ]; then
	shjob debloat d /priv-app/SharedStorageBackup;
	fi

	if [ "$($RCV Turbo $NLP)" == "1" ]; then
	shjob debloat d /priv-app/Turbo;
	fi

	if [ "$($RCV Calculator $NLP)" == "1" ]; then
	shjob debloat d /app/Calculator com.oneplus.calculator;
	fi

	if [ "$($RCV OPLongshot $NLP)" == "1" ]; then
	shjob debloat d /app/OPLongshot;
	fi

	if [ "$($RCV OPRoamingAppRelease $NLP)" == "1" ]; then
	shjob debloat d /reserve/OPRoamingAppRelease com.redteamobile.oneplus.roaming;
	shjob debloat d /reserve/By_3rd_RoamingAppIndia com.redteamobile.oneplus.roaming;
	shjob debloat d /reserve/By_3rd_RoamingAppChina com.redteamobile.oneplus.roaming;
	shjob debloat d /reserve/IndiaOPRoamingAppRelease com.redteamobile.oneplus.roaming;
	fi

	if [ "$($RCV OPRoamingServiceRelease $NLP)" == "1" ]; then
	shjob debloat d /priv-app/OPRoamingServiceRelease com.redteamobile.virtual.softsim;
	shjob debloat d /priv-app/OverseasOPRoamingServiceRelease com.redteamobile.virtual.softsim;
	shjob debloat d /priv-app/IndiaOPRoamingServiceRelease com.redteamobile.virtual.softsim;
	shjob debloat d /priv-app/By_3rd_RoamingServiceIndia com.redteamobile.virtual.softsim;
	shjob debloat d /priv-app/By_3rd_RoamingServiceChina com.redteamobile.virtual.softsim;	
	fi

	if [ "$($RCV OPSafe $NLP)" == "1" ]; then
	shjob debloat d /app/OPSafe com.oneplus.security;
	fi

	if [ "$($RCV DocumentsUI $NLP)" == "1" ]; then
	shjob debloat d /priv-app/DocumentsUI;
	fi

	if [ "$($RCV OnePlusCamera $NLP)" == "1" ]; then
	shjob debloat d /priv-app/OnePlusCamera com.oneplus.camera;
	fi

	if [ "$($RCV OnePlusCameraService $NLP)" == "1" ]; then
	shjob debloat d /priv-app/OnePlusCameraService;
	fi

	if [ "$($RCV OnePlusGallery $NLP)" == "1" ]; then
	shjob debloat d /priv-app/OnePlusGallery com.oneplus.gallery;
	fi

	if [ "$($RCV OPLauncher2 $NLP)" == "1" ]; then
	shjob debloat d /priv-app/OPLauncher2 net.oneplus.launcher;
	fi

	if [ "$($RCV WallpaperCropper $NLP)" == "1" ]; then
	shjob debloat d /priv-app/WallpaperCropper;
	fi

	ProfCat=3_Debloating__Extreme
	if [ "$($RCV BasicDreams $NLP)" == "1" ]; then
	shjob debloat d /app/BasicDreams;
	fi

	if [ "$($RCV BookmarkProvider $NLP)" == "1" ]; then
	shjob debloat d /app/BookmarkProvider;
	fi

	if [ "$($RCV BTtestmode $NLP)" == "1" ]; then
	shjob debloat d /app/BTtestmode;
	fi

	if [ "$($RCV bugreport $NLP)" == "1" ]; then
	shjob debloat f /bin/bugreportz;
	fi

	if [ "$($RCV DMAgent $NLP)" == "1" ]; then
	shjob debloat d /app/DMAgent;
	fi

	if [ "$($RCV Duo $NLP)" == "1" ]; then
	shjob debloat d /app/Duo com.google.android.apps.tachyon;
	fi

	if [ "$($RCV EasterEgg $NLP)" == "1" ]; then
	shjob debloat d /app/EasterEgg;
	fi

	if [ "$($RCV EngSpecialTest $NLP)" == "1" ]; then
	shjob debloat d /app/EngSpecialTest;
	fi

	if [ "$($RCV fmfactorytest $NLP)" == "1" ]; then
	shjob debloat f /bin/fmfactorytestserver;
	fi

	if [ "$($RCV LogKitSdService $NLP)" == "1" ]; then
	shjob debloat d /app/LogKitSdService;
	fi

	if [ "$($RCV NFCTestMode $NLP)" == "1" ]; then
	shjob debloat d /app/NFCTestMode;
	fi

	if [ "$($RCV OemAutoTestServer $NLP)" == "1" ]; then
	shjob debloat d /app/OemAutoTestServer;
	fi

	if [ "$($RCV OpenWnn $NLP)" == "1" ]; then
	shjob debloat d /app/OpenWnn;
	fi

	if [ "$($RCV PartnerBookmarksProvider $NLP)" == "1" ]; then
	shjob debloat d /app/PartnerBookmarksProvider;
	fi

	if [ "$($RCV SecureSampleAuthService $NLP)" == "1" ]; then
	shjob debloat d /app/SecureSampleAuthService;
	fi

	if [ "$($RCV SensorTestTool $NLP)" == "1" ]; then
	shjob debloat d /app/SensorTestTool;
	fi

	if [ "$($RCV Stk $NLP)" == "1" ]; then
	shjob debloat d /app/Stk;
	fi

	if [ "$($RCV usb_drivers.iso $NLP)" == "1" ]; then
	shjob debloat f /etc/usb_drivers.iso;
	fi

	if [ "$($RCV WifiLogger_app $NLP)" == "1" ]; then
	shjob debloat f /bin/WifiLogger_app;
	fi

	if [ "$($RCV WifiRfTestApk $NLP)" == "1" ]; then
	shjob debloat d /app/WifiRfTestApk;
	fi

	if [ "$($RCV tts $NLP)" == "1" ]; then
	shjob debloat d /tts;
	fi

	if [ "$($RCV PicoTts $NLP)" == "1" ]; then
	shjob debloat d /app/PicoTts;
	fi

	if [ "$($RCV GoogleTTS $NLP)" == "1" ]; then
	shjob debloat d /app/GoogleTTS com.google.android.tts;
	fi

	if [ "$($RCV VrCore $NLP)" == "1" ]; then
	shjob debloat d /app/VrCore;
	fi

	if [ "$($RCV AntHalService $NLP)" == "1" ]; then
	shjob debloat d /app/AntHalService;
	fi

	if [ "$($RCV AutoRegistration $NLP)" == "1" ]; then
	shjob debloat d /app/AutoRegistration;
	fi

	if [ "$($RCV BuiltInPrintService $NLP)" == "1" ]; then
	shjob debloat d /app/BuiltInPrintService;
	fi

	if [ "$($RCV OPLiveWallpaper $NLP)" == "1" ]; then
	shjob debloat d /app/OPLiveWallpaper;
	fi

	if [ "$($RCV OPSesAuthentication $NLP)" == "1" ]; then
	shjob debloat d /app/OPSesAuthentication;
	fi

	if [ "$($RCV OPWidget $NLP)" == "1" ]; then
	shjob debloat d /app/OPWidget;
	fi
	
	if [ "$($RCV OPCarrierLocation $NLP)" == "1" ]; then
	shjob debloat d /app/OPCarrierLocation;
	fi
	
	if [ "$($RCV PowerOffAlarm $NLP)" == "1" ]; then
	shjob debloat d /app/PowerOffAlarm;
	fi		

	if [ "$($RCV PhotosOnline $NLP)" == "1" ]; then
	shjob debloat d /app/PhotosOnline;
	fi

	if [ "$($RCV PlayAutoInstallConfig $NLP)" == "1" ]; then
	shjob debloat d /app/PlayAutoInstallConfig;
	fi

	if [ "$($RCV QdcmFF $NLP)" == "1" ]; then
	shjob debloat d /app/QdcmFF;
	fi

	if [ "$($RCV RFTuner $NLP)" == "1" ]; then
	shjob debloat d /app/RFTuner;
	fi

	if [ "$($RCV SeempService $NLP)" == "1" ]; then
	shjob debloat d /app/SeempService;
	fi

	if [ "$($RCV uimremoteclient $NLP)" == "1" ]; then
	shjob debloat d /app/uimremoteclient;
	fi

	if [ "$($RCV WallpaperBackup $NLP)" == "1" ]; then
	shjob debloat d /app/WallpaperBackup;
	fi

	if [ "$($RCV WapiCertManage $NLP)" == "1" ]; then
	shjob debloat d /app/WapiCertManage;
	fi

	if [ "$($RCV DiracManager $NLP)" == "1" ]; then
	shjob debloat d /app/DiracManager;
	fi

	if [ "$($RCV DiracAudioControlService $NLP)" == "1" ]; then
	shjob debloat d /priv-app/DiracAudioControlService;
	fi

	if [ "$($RCV OPCellBroadcastReceiver $NLP)" == "1" ]; then
	shjob debloat d /priv-app/OPCellBroadcastReceiver;
	fi

	if [ "$($RCV Tag $NLP)" == "1" ]; then
	shjob debloat d /priv-app/Tag;
	fi

	if [ "$($RCV BluetoothMidiService $NLP)" == "1" ]; then
	shjob debloat d /app/BluetoothMidiService;
	fi

	if [ "$($RCV datastatusnotification $NLP)" == "1" ]; then
	shjob debloat d /app/datastatusnotification;
	fi

	if [ "$($RCV OPBackup $NLP)" == "1" ]; then
	shjob debloat d /app/OPBackup;
	fi

	if [ "$($RCV OpSkin $NLP)" == "1" ]; then
	shjob debloat d /app/OpSkin;
	fi

	if [ "$($RCV com.qualcomm.qti.services.systemhelper $NLP)" == "1" ]; then
	shjob debloat d /app/com.qualcomm.qti.services.systemhelper;
	fi

	if [ "$($RCV DeviceStatisticsService $NLP)" == "1" ]; then
	shjob debloat d /app/DeviceStatisticsService;
	fi		

	if [ "$($RCV SoterService $NLP)" == "1" ]; then
	shjob debloat d /app/SoterService;
	fi

	if [ "$($RCV CNEService $NLP)" == "1" ]; then
	shjob debloat d /priv-app/CNEService;
	fi

	if [ "$($RCV EmergencyInfo $NLP)" == "1" ]; then
	shjob debloat d /priv-app/EmergencyInfo;
	fi

	if [ "$($RCV GoogleFeedback $NLP)" == "1" ]; then
	shjob debloat d /priv-app/GoogleFeedback;
	fi

	if [ "$($RCV HotwordEnrollmentOKGoogleWCD9340 $NLP)" == "1" ]; then
	shjob debloat d /priv-app/HotwordEnrollmentOKGoogleWCD9340;
	shjob debloat d /priv-app/HotwordEnrollmentOKGoogleHEXAGON;
	fi

	if [ "$($RCV HotwordEnrollmentXGoogleWCD9340 $NLP)" == "1" ]; then
	shjob debloat d /priv-app/HotwordEnrollmentXGoogleWCD9340;
	shjob debloat d /priv-app/HotwordEnrollmentXGoogleHEXAGON;	
	fi

	if [ "$($RCV OPCoreService $NLP)" == "1" ]; then
	shjob debloat d /priv-app/OPCoreService;
	fi

	if [ "$($RCV QualcommVoiceActivation $NLP)" == "1" ]; then
	shjob debloat d /priv-app/QualcommVoiceActivation;
	fi		

	if [ "$($RCV OPAod $NLP)" == "1" ]; then
	shjob debloat d /priv-app/OPAod;
	fi

	if [ "$($RCV OPFaceUnlock $NLP)" == "1" ]; then
	shjob debloat d /priv-app/OPFaceUnlock;
	fi

	if [ "$($RCV ProxyHandler $NLP)" == "1" ]; then
	shjob debloat d /priv-app/ProxyHandler;
	fi

	if [ "$($RCV SetupWizard $NLP)" == "1" ]; then
	shjob debloat d /priv-app/SetupWizard;
	fi

	if [ "$($RCV GooglePartnerSetup $NLP)" == "1" ]; then
	shjob debloat d /priv-app/GooglePartnerSetup;
	fi

	if [ "$($RCV GoogleOneTimeInitializer $NLP)" == "1" ]; then
	shjob debloat d /priv-app/GoogleOneTimeInitializer;
	fi
	
	ProfCat=4_Debloating__Experts
	if [ "$($RCV Bluetooth $NLP)" == "1" ]; then
		shjob debloat d /app/Bluetooth;
	fi

	if [ "$($RCV BluetoothExt $NLP)" == "1" ]; then
		shjob debloat d /app/BluetoothExt;
	fi

	if [ "$($RCV CallFeaturesSetting $NLP)" == "1" ]; then
		shjob debloat d /app/CallFeaturesSetting;
	fi

	if [ "$($RCV CaptivePortalLogin $NLP)" == "1" ]; then
		shjob debloat d /app/CaptivePortalLogin;
	fi

	if [ "$($RCV CarrierDefaultApp $NLP)" == "1" ]; then
		shjob debloat d /app/CarrierDefaultApp;
	fi

	if [ "$($RCV CertInstaller $NLP)" == "1" ]; then
		shjob debloat d /app/CertInstaller;
	fi

	if [ "$($RCV CompanionDeviceManager $NLP)" == "1" ]; then
		shjob debloat d /app/CompanionDeviceManager;
	fi

	if [ "$($RCV ConfURIDialer $NLP)" == "1" ]; then
		shjob debloat d /app/ConfURIDialer;
	fi

	if [ "$($RCV ConfUrlDialer $NLP)" == "1" ]; then
		shjob debloat d /app/ConfUrlDialer;
	fi

	if [ "$($RCV CtsShimPrebuilt $NLP)" == "1" ]; then
		shjob debloat d /app/CtsShimPrebuilt;
	fi

	if [ "$($RCV DeviceInfo $NLP)" == "1" ]; then
		shjob debloat d /app/DeviceInfo;
	fi

	if [ "$($RCV DynamicDDSService $NLP)" == "1" ]; then
		shjob debloat d /app/DynamicDDSService;
	fi

	if [ "$($RCV DynamicDSService $NLP)" == "1" ]; then
		shjob debloat d /app/DynamicDSService;
	fi

	if [ "$($RCV embms $NLP)" == "1" ]; then
		shjob debloat d /app/embms;
	fi

	if [ "$($RCV GoogleExtShared $NLP)" == "1" ]; then
		shjob debloat d /app/GoogleExtShared;
	fi

	if [ "$($RCV ims $NLP)" == "1" ]; then
		shjob debloat d /app/ims;
	fi

	if [ "$($RCV imssettings $NLP)" == "1" ]; then
		shjob debloat d /app/imssettings;
	fi

	if [ "$($RCV KeyChain $NLP)" == "1" ]; then
		shjob debloat d /app/KeyChain;
	fi

	if [ "$($RCV NxpNfcNci $NLP)" == "1" ]; then
		shjob debloat d /app/NxpNfcNci;
	fi

	if [ "$($RCV NxpSecureElement $NLP)" == "1" ]; then
		shjob debloat d /app/NxpSecureElement;
	fi

	if [ "$($RCV oem_tcma $NLP)" == "1" ]; then
		shjob debloat d /app/oem_tcma;
	fi

	if [ "$($RCV OPIpTime $NLP)" == "1" ]; then
		shjob debloat d /app/OPIpTime;
	fi

	if [ "$($RCV OPMmsLocationFramework $NLP)" == "1" ]; then
		shjob debloat d /app/OPMmsLocationFramework;
	fi

	if [ "$($RCV OPOnlineConfig $NLP)" == "1" ]; then
		shjob debloat d /app/OPOnlineConfig;
	fi

	if [ "$($RCV OPTelephonyDiagnoseManager $NLP)" == "1" ]; then
		shjob debloat d /app/OPTelephonyDiagnoseManager;
	fi
	
	if [ "$($RCV OPTelephonyCollectionData $NLP)" == "1" ]; then
		shjob debloat d /app/OPTelephonyCollectionData;
	fi	
	
	if [ "$($RCV OPTelephonyDiagnoseManager $NLP)" == "1" ]; then
		shjob debloat d /app/OPTelephonyOptimization;
	fi	

	if [ "$($RCV OPWallpaperResources $NLP)" == "1" ]; then
		shjob debloat d /app/OPWallpaperResources;
	fi
	
	if [ "$($RCV SecureElement $NLP)" == "1" ]; then
		shjob debloat d /app/SecureElement;
	fi
	
	if [ "$($RCV workloadclassifier $NLP)" == "1" ]; then
		shjob debloat d /app/workloadclassifier;
	fi		

	if [ "$($RCV OPYellowpage $NLP)" == "1" ]; then
		shjob debloat d /app/OPYellowpage;
	fi

	if [ "$($RCV PacProcessor $NLP)" == "1" ]; then
		shjob debloat d /app/PacProcessor;
	fi

	if [ "$($RCV PrintSpooler $NLP)" == "1" ]; then
		shjob debloat d /app/PrintSpooler;
	fi

	if [ "$($RCV QtiSystemService $NLP)" == "1" ]; then
		shjob debloat d /app/QtiSystemService;
	fi

	if [ "$($RCV QtiTelephoneService $NLP)" == "1" ]; then
		shjob debloat d /app/QtiTelephoneService;
	fi

	if [ "$($RCV QtiTelephonyService $NLP)" == "1" ]; then
		shjob debloat d /app/QtiTelephonyService;
	fi

	if [ "$($RCV remotesimlockservice $NLP)" == "1" ]; then
		shjob debloat d /app/remotesimlockservice;
	fi

	if [ "$($RCV remotessimlockservice $NLP)" == "1" ]; then
		shjob debloat d /app/remotessimlockservice;
	fi

	if [ "$($RCV SCardService $NLP)" == "1" ]; then
		shjob debloat d /app/SCardService;
	fi

	if [ "$($RCV SdCardService $NLP)" == "1" ]; then
		shjob debloat d /app/SdCardService;
	fi

	if [ "$($RCV SimAppDialog $NLP)" == "1" ]; then
		shjob debloat d /app/SimAppDialog;
	fi

	if [ "$($RCV SimSettings $NLP)" == "1" ]; then
		shjob debloat d /app/SimSettings;
	fi

	if [ "$($RCV smcinvokepkgmgr $NLP)" == "1" ]; then
		shjob debloat d /app/smcinvokepkgmgr;
	fi

	if [ "$($RCV SmscPlugger $NLP)" == "1" ]; then
		shjob debloat d /app/SmscPlugger;
	fi

	if [ "$($RCV SmsPlugger $NLP)" == "1" ]; then
		shjob debloat d /app/SmsPlugger;
	fi

	if [ "$($RCV Traceur $NLP)" == "1" ]; then
		shjob debloat d /app/Traceur;
	fi

	if [ "$($RCV uimlpaservice $NLP)" == "1" ]; then
		shjob debloat d /app/uimlpaservice;
	fi

	if [ "$($RCV WallpaperPicker $NLP)" == "1" ]; then
		shjob debloat d /app/WallpaperPicker;
	fi

	if [ "$($RCV WAPPushManager $NLP)" == "1" ]; then
		shjob debloat d /app/WAPPushManager;
	fi

	if [ "$($RCV WebViewStub $NLP)" == "1" ]; then
		shjob debloat d /app/WebViewStub;
	fi

	if [ "$($RCV AndroidPlatformServices $NLP)" == "1" ]; then
		shjob debloat d /priv-app/AndroidPlatformServices;
	fi

	if [ "$($RCV BlockedNumberProvider $NLP)" == "1" ]; then
		shjob debloat d /priv-app/BlockedNumberProvider;
	fi

	if [ "$($RCV BlokedNumberProvider $NLP)" == "1" ]; then
		shjob debloat d /priv-app/BlokedNumberProvider;
	fi

	if [ "$($RCV CalendarProvider $NLP)" == "1" ]; then
		shjob debloat d /priv-app/CalendarProvider;
	fi

	if [ "$($RCV CarrierConfig $NLP)" == "1" ]; then
		shjob debloat d /priv-app/CarrierConfig;
	fi

	if [ "$($RCV com.qualcomm.location $NLP)" == "1" ]; then
		shjob debloat d /priv-app/com.qualcomm.location;
	fi

	if [ "$($RCV ContactsProvider $NLP)" == "1" ]; then
		shjob debloat d /priv-app/ContactsProvider;
	fi

	if [ "$($RCV CtsShimPrivPrebuilt $NLP)" == "1" ]; then
		shjob debloat d /priv-app/CtsShimPrivPrebuilt;
	fi

	if [ "$($RCV DefaultContainerService $NLP)" == "1" ]; then
		shjob debloat d /priv-app/DefaultContainerService;
	fi

	if [ "$($RCV DownloadProvider $NLP)" == "1" ]; then
		shjob debloat d /priv-app/DownloadProvider;
	fi

	if [ "$($RCV DownloadProviderUI $NLP)" == "1" ]; then
		shjob debloat d /priv-app/DownloadProviderUI;
	fi

	if [ "$($RCV dpmserviceapp $NLP)" == "1" ]; then
		shjob debloat d /priv-app/dpmserviceapp;
	fi

	if [ "$($RCV ExternalStorageProvider $NLP)" == "1" ]; then
		shjob debloat d /priv-app/ExternalStorageProvider;
	fi

	if [ "$($RCV FusedLocation $NLP)" == "1" ]; then
		shjob debloat d /priv-app/FusedLocation;
	fi

	if [ "$($RCV GmsCore $NLP)" == "1" ]; then
		shjob debloat d /priv-app/GmsCore com.google.android.gms;
	fi
	
	if [ "$($RCV OPBreathMode $NLP)" == "1" ]; then
		shjob debloat d /app/OPBreathMode com.oneplus.brickmode;
	fi	

	if [ "$($RCV GoogleExtServices $NLP)" == "1" ]; then
		shjob debloat d /priv-app/GoogleExtServices;
	fi

	if [ "$($RCV GooglePackageInstaller $NLP)" == "1" ]; then
		shjob debloat d /priv-app/GooglePackageInstaller;
	fi

	if [ "$($RCV IFAAService $NLP)" == "1" ]; then
		shjob debloat d /priv-app/IFAAService;
	fi

	if [ "$($RCV InputDevices $NLP)" == "1" ]; then
		shjob debloat d /priv-app/InputDevices;
	fi

	if [ "$($RCV MediaProvider $NLP)" == "1" ]; then
		shjob debloat d /priv-app/MediaProvider;
	fi

	if [ "$($RCV MmsService $NLP)" == "1" ]; then
		shjob debloat d /priv-app/MmsService;
	fi

	if [ "$($RCV MtpDocumentProvider $NLP)" == "1" ]; then
		shjob debloat d /priv-app/MtpDocumentProvider;
	fi

	if [ "$($RCV MtpDocumentsProvider $NLP)" == "1" ]; then
		shjob debloat d /priv-app/MtpDocumentsProvider;
	fi

	if [ "$($RCV oneplus-framework-res $NLP)" == "1" ]; then
		shjob debloat d /priv-app/oneplus-framework-res;
	fi

	if [ "$($RCV OnePlusWizard $NLP)" == "1" ]; then
		shjob debloat d /priv-app/OnePlusWizard;
	fi

	if [ "$($RCV OPAppCategoryProvider $NLP)" == "1" ]; then
		shjob debloat d /priv-app/OPAppCategoryProvider;
	fi

	if [ "$($RCV OPConfigurationClient $NLP)" == "1" ]; then
		shjob debloat d /priv-app/OPConfigurationClient;
	fi

	if [ "$($RCV OPMms $NLP)" == "1" ]; then
		shjob debloat d /priv-app/OPMms;
	fi

	if [ "$($RCV OPNetworkSetting $NLP)" == "1" ]; then
		shjob debloat d /priv-app/OPNetworkSetting;
	fi

	if [ "$($RCV OPSettingProvider $NLP)" == "1" ]; then
		shjob debloat d /priv-app/OPSettingProvider;
	fi

	if [ "$($RCV OPSettingsProvider $NLP)" == "1" ]; then
		shjob debloat d /priv-app/OPSettingsProvider;
	fi

	if [ "$($RCV OPsystemUI $NLP)" == "1" ]; then
		shjob debloat d /priv-app/OPsystemUI;
	fi

	if [ "$($RCV OPWifiApSettings $NLP)" == "1" ]; then
		shjob debloat d /priv-app/OPWifiApSettings;
	fi

	if [ "$($RCV qcrilmsgtunnel $NLP)" == "1" ]; then
		shjob debloat d /priv-app/qcrilmsgtunnel;
	fi

	if [ "$($RCV seccamservice $NLP)" == "1" ]; then
		shjob debloat d /priv-app/seccamservice;
	fi

	if [ "$($RCV Settings $NLP)" == "1" ]; then
		shjob debloat d /priv-app/Settings;
	fi

	if [ "$($RCV SettingsIntelligence $NLP)" == "1" ]; then
		shjob debloat d /priv-app/SettingsIntelligence;
	fi

	if [ "$($RCV Shell $NLP)" == "1" ]; then
		shjob debloat d /priv-app/Shell;
	fi

	if [ "$($RCV StatementService $NLP)" == "1" ]; then
		shjob debloat d /priv-app/StatementService;
	fi

	if [ "$($RCV StorageManager $NLP)" == "1" ]; then
		shjob debloat d /priv-app/StorageManager;
	fi

	if [ "$($RCV Telecom $NLP)" == "1" ]; then
		shjob debloat d /priv-app/Telecom;
	fi

	if [ "$($RCV TelephonyProvider $NLP)" == "1" ]; then
		shjob debloat d /priv-app/TelephonyProvider;
	fi

	if [ "$($RCV TeleService $NLP)" == "1" ]; then
		shjob debloat d /priv-app/TeleService;
	fi

	if [ "$($RCV UserDictionaryProvider $NLP)" == "1" ]; then
		shjob debloat d /priv-app/UserDictionaryProvider;
	fi

	if [ "$($RCV VpnDialogs $NLP)" == "1" ]; then
		shjob debloat d /priv-app/VpnDialogs;
	fi

	if [ "$($RCV WfdService $NLP)" == "1" ]; then
		shjob debloat d /priv-app/WfdService;
	fi

	if [ "$($RCV OPWidget $NLP)" == "1" ]; then
		shjob debloat d /reserve/OPWidget;
	fi

	if [ "$($RCV GoogleContactsSyncAdapter $NLP)" == "1" ]; then
		shjob debloat d /app/GoogleContactsSyncAdapter;
	fi

	if [ "$($RCV GooglePrintRecommendationService $NLP)" == "1" ]; then
		shjob debloat d /app/GooglePrintRecommendationService;
	fi
	
	if [ "$($RCV YTMusic $NLP)" == "1" ]; then
		shjob debloat d /app/YTMusic com.google.android.apps.youtube.music;
	fi
	
	if [ "$($RCV CameraPicProcService $NLP)" == "1" ]; then
		shjob debloat d /priv-app/CameraPicProcService;
	fi		

	if [ "$($RCV ConfigUpdater $NLP)" == "1" ]; then
		shjob debloat d /priv-app/ConfigUpdater;
	fi

	if [ "$($RCV GoogleLoginService $NLP)" == "1" ]; then
		shjob debloat d /priv-app/GoogleLoginService;
	fi

	if [ "$($RCV GoogleServicesFramework $NLP)" == "1" ]; then
		shjob debloat d /priv-app/GoogleServicesFramework;
	fi

	if [ "$($RCV Phonesky $NLP)" == "1" ]; then
		shjob debloat d /priv-app/Phonesky;
	fi

	if [ "$($RCV Rftoolkit $NLP)" == "1" ]; then
		shjob debloat d /vendor/app/Rftoolkit;
	fi
	
	if [ "$($RCV OPCommonLogTool $NLP)" == "1" ]; then
		shjob debloat d /app/OPCommonLogTool;
	fi	
	
	if [ "$($RCV app_Backup $NLP)" == "1" ]; then
		shjob debloat d /app/Backup;
	fi

	if [ "$($RCV app_colorservice $NLP)" == "1" ]; then
		shjob debloat d /app/colorservice;
	fi

	if [ "$($RCV app_FidoCryptoService $NLP)" == "1" ]; then
		shjob debloat d /app/FidoCryptoService;
	fi

	if [ "$($RCV app_Netflix_Activation $NLP)" == "1" ]; then
		shjob debloat d /app/Netflix_Activation;
		shjob debloat d /app/netflix-activation;
		shjob debloat d /app/By_3rd_NetflixActivationOverSeas;
	fi

	if [ "$($RCV app_Netflix_Stub $NLP)" == "1" ]; then
		shjob debloat d /app/Netflix_Stub;
		shjob debloat d /app/netflix-stub;
		shjob debloat d /app/By_3rd_NetflixStubOverSeas;		
	fi
	
	if [ "$($RCV Facebook $NLP)" == "1" ]; then
		shjob debloat d /app/FBAppmanager com.facebook.appmanager;
		shjob debloat d /priv-app/FBInstaller com.facebook.system;
		shjob debloat d /priv-app/FBServices com.facebook.services;
		shjob debloat d /reserve/facebook-localapk-stub	com.facebook.katana;	
		shjob debloat d /reserve/messenger-localapk-stub com.facebook.orca;
		shjob debloat d /reserve/By_3rd_FacebookOverSeas com.facebook.katana;
		shjob debloat d /reserve/By_3rd_FBAppManagerOverSeas com.facebook.appmanager;
		shjob debloat d /reserve/FBAppmanager com.facebook.appmanager;
		shjob debloat d /reserve/By_3rd_FBInstallOverSeas com.facebook.system;
		shjob debloat d /reserve/By_3rd_MessengerOverSeas com.facebook.orca;		
	fi

	if [ "$($RCV app_OemAutoTestServer $NLP)" == "1" ]; then
		shjob debloat d /app/OemAutoTestServer;
	fi

	if [ "$($RCV app_OPSoundTuner $NLP)" == "1" ]; then
		shjob debloat d /app/OPSoundTuner;
	fi

	if [ "$($RCV app_OPWallpaperResources $NLP)" == "1" ]; then
		shjob debloat d /app/OPWallpaperResources;
	fi

	if [ "$($RCV app_PlayAutoInstallConfig $NLP)" == "1" ]; then
		shjob debloat d /app/PlayAutoInstallConfig;
	fi

	if [ "$($RCV app_Qmmi $NLP)" == "1" ]; then
		shjob debloat d /app/Qmmi;
	fi

	if [ "$($RCV app_remoteSimLockAuthentication $NLP)" == "1" ]; then
		shjob debloat d /app/remoteSimLockAuthentication;
	fi

	if [ "$($RCV app_uceShimService $NLP)" == "1" ]; then
		shjob debloat d /app/uceShimService;
	fi

	if [ "$($RCV app_workloadclassifier $NLP)" == "1" ]; then
		shjob debloat d /app/workloadclassifier;
	fi

	if [ "$($RCV priv-app_daxService $NLP)" == "1" ]; then
		shjob debloat d /priv-app/daxService;
	fi
	
	if [ "$($RCV OobConfig $NLP)" == "1" ]; then
		shjob debloat d /priv-app/OobConfig;
	fi	

	if [ "$($RCV priv-app_ims $NLP)" == "1" ]; then
		shjob debloat d /priv-app/ims;
	fi

	if [ "$($RCV priv-app_TSDM $NLP)" == "1" ]; then
		shjob debloat d /priv-app/TSDM;
	fi
	
	if [ "$($RCV OnePlus_Launcher $NLP)" == "1" ]; then
	 ui_print "-> Removing OnePlus Launcher...";
	 shjob debloat d /app/OPLauncher net.oneplus.launcher;
	 shjob debloat d /priv-app/OPLauncher2 net.oneplus.launcher;
	 shjob debloat d /priv-app/H2DefaultIconPack;
	 shjob debloat d /priv-app/H2FolioIconPack;
	 shjob debloat d /priv-app/H2LightIconPack;
	 shjob debloat d /priv-app/OneplusIconPack;
	 shjob debloat d /priv-app/OneplusCircleIconPack;
	 shjob debloat d /priv-app/OneplusSquareIconPack;
	 shjob debloat d /reserve/OPIconpackCircle com.oneplus.iconpack.circle;
	 shjob debloat d /reserve/OPIconpackOnePlus com.oneplus.iconpack.oneplus;
	 shjob debloat d /reserve/OPIconpackSquare com.oneplus.iconpack.square;
	 shjob debloat d /reserve/OPIconpackOnePlusH2 com.oneplus.iconpack.oneplush2;
	 shjob debloat d /reserve/OPIconpackOnePlusO2 com.oneplus.iconpack.onepluso2;	 
	fi	
fi


ProfCat=.Emojis
if [ "$($RCV EmojiFont $NLP)" == "1" ]; then
 ui_print "-> Installing Android O Emojis...";
 ui_print "   - thanks to @linuxct -";
 shjob cp d $TMPDIR/fonts/Emojis/android_O/system $TMPDIR/system/;
fi

if [ "$($RCV EmojiFont $NLP)" == "2" ]; then
 ui_print "-> Installing iOS13.2 Emojis...";
 ui_print "   - thanks to @tych_tych -";
 shjob cp d $TMPDIR/fonts/Emojis/iOS/system $TMPDIR/system/;
fi

if [ "$($RCV EmojiFont $NLP)" == "3" ]; then
 ui_print "-> Installing JoyPixels (Emoji One) Font...";
 shjob cp d $TMPDIR/fonts/Emojis/EmojiOne/system $TMPDIR/system/;
fi

if [ "$($RCV EmojiFont $NLP)" == "4" ]; then
 ui_print "-> Installing Samsung Emoji Font...";
 ui_print "   - thanks to @FedericoPeranzi -";
 shjob cp d $TMPDIR/fonts/Emojis/Samsung/system $TMPDIR/system/;
fi

ProfCat=.StandardFont
if [ "$($RCV StandardFont $NLP)" == "1" ]; then
 ui_print "-> Installing Google Sans Font...";
 shjob cp d $TMPDIR/fonts/GoogleSans/system $TMPDIR/system/;
fi

if [ "$($RCV StandardFont $NLP)" == "2" ]; then
 ui_print "-> Installing Storopia Font...";
 shjob cp d $TMPDIR/fonts/Storopia/system $TMPDIR/system/;
fi

ProfCat=.Miscellaneous_Options
if [ "$($RCV AdAway $NLP)" != "0" ]; then
 ui_print "-> Installing AdAway...";
 if [ "$($RCV AdAway $NLP)" == "1" ]; then
   ui_print "-> Installing AdAway v5...";
   shjob cp d $TMPDIR/apps/AdAway/v5/system $TMPDIR/system/;
 fi;
 if [ "$($RCV AdAway $NLP)" == "2" ]; then
   ui_print "-> Installing AdAway v4...";
   shjob cp d $TMPDIR/apps/AdAway/v4/system $TMPDIR/system/;
 fi;
 ui_print "   - thanks to @mrRobinson & @PerfectSlayer -";
 shjob cp f $(find $TMPDIR/system -type f -name "*AdAway.apk*") /data/xXx/
 if [ ! -f /data/adb/modules/hosts ]; then
   shjob cp d $TMPDIR/apps/AdAway/hosts/system $TMPDIR/system/;
 fi 
 shjob dalvik AdAway org.adaway;
 shjob perms AdAway;
 shjob apps2data AdAway;
fi

if [ "$($RCV AdAway $NLP)" == "0" ]; then
  if [ -f /data/system/xXx/AdAway.flag ]; then
    ui_print "-> Uninstalling AdAway...";
	shjob dalvik AdAway org.adaway;
 	shjob apps2data AdAwayRM;
  fi
fi


if [ "$($RCV Caffeine $NLP)" == "1" ]; then
 ui_print "-> Installing Caffeine...";
 ui_print "   - thanks to Hansog Zhang -";
 shjob cp d $TMPDIR/apps/Caffeine/system $TMPDIR/system/;
 shjob dalvik Caffeine moe.zhs.caffeine;
fi



if [ "$($RCV YouTubeVanced $NLP)" == "1" ]; then
 ui_print "-> Installing modded YouTube app white/dark themed...";
 ui_print "   - thanks to @Master_T and @ZaneZam -";
 shjob debloat d /app/YouTube com.google.android.youtube 1; 
 shjob rm d /data/app/com.google.android.youtube*;
 shjob cp d $TMPDIR/apps/YTV/14/dark/system $TMPDIR/system/;
 shjob cp d $TMPDIR/apps/YTV/14/system $TMPDIR/system/;
 shjob config.flags YouTube detach;
 shjob dalvik YouTube com.google.android.youtube;
 shjob perms YouTube;
fi

if [ "$($RCV YouTubeVanced $NLP)" == "2" ]; then
 ui_print "-> Installing modded YouTube app white/black themed...";
 ui_print "   - thanks to @Master_T and @ZaneZam -";
 shjob debloat d /app/YouTube com.google.android.youtube 1; 
 shjob rm d /data/app/com.google.android.youtube*;
 shjob cp d $TMPDIR/apps/YTV/14/white/system $TMPDIR/system/;
 shjob cp d $TMPDIR/apps/YTV/14/system $TMPDIR/system/;
 shjob config.flags YouTube detach;
 shjob dalvik YouTube com.google.android.youtube;
 shjob perms YouTube;
fi

if [ "$($RCV YouTubeVanced $NLP)" == "3" ]; then
 ui_print "-> Detach Youtube from PlayStore...";
 shjob debloat d /app/YouTube; 
 shjob config.flags YouTube detach;
 shjob config.flags Vanced manual; 
 shjob dalvik YouTube com.google.android.youtube; 
fi




if [ "$($RCV GoogleDialer $NLP)" == "0" ]; then
  if [ -f /data/system/xXx/GoogleDialer.flag ]; then
    ui_print "-> Uninstalling Google Dialer...";
	shjob dalvik GoogleDialer com.google.android.dialer;
 	shjob apps2data GoogleDialerRM;
  fi
fi

if [ "$($RCV GoogleDialer $NLP)" == "1" ]; then
 ui_print "-> Installing latest Google Dialer...";
 ui_print "   - and debloat OOS Dialer -";
 shjob cp f $(find $TMPDIR/apps/GoogleDialer/new/system -type f -name "*GoogleDialer.apk*") /data/xXx/  
 shjob debloat d /priv-app/OPInCallUI;
 shjob cp d $TMPDIR/apps/GoogleDialer/new/system $TMPDIR/system/;
 shjob perms Dialer;
 shjob debloat d /priv-app/Contacts com.android.contacts 1;
 shjob debloat d /priv-app/Dialer com.android.dialer 1;
 shjob dalvik GoogleContacts com.google.android.contacts;
 shjob dalvik GoogleDialer com.google.android.dialer; 
 shjob dalvik Contacts com.android.contacts;
 shjob dalvik Dialer com.android.dialer;
 shjob config.flags GoogleDialer 1;
 shjob apps2data GoogleDialer; 
 shjob apps2data GoogleContacts;
fi

if [ "$($RCV GoogleDialer $NLP)" == "2" ]; then
 ui_print "-> Installing old Google Dialer...";
 ui_print "   - and debloat OOS Dialer -";
 shjob cp f $(find $TMPDIR/apps/GoogleDialer/old/system -type f -name "*GoogleDialer.apk*") /data/xXx/  
 shjob debloat d /priv-app/OPInCallUI;
 shjob cp d $TMPDIR/apps/GoogleDialer/old/system $TMPDIR/system/;
 shjob perms Dialer;
 shjob debloat d /priv-app/Contacts com.android.contacts 1;
 shjob debloat d /priv-app/Dialer com.android.dialer 1;
 shjob dalvik GoogleContacts com.google.android.contacts;
 shjob dalvik GoogleDialer com.google.android.dialer; 
 shjob dalvik Contacts com.android.contacts;
 shjob dalvik Dialer com.android.dialer;
 shjob config.flags GoogleDialer 1; 
 shjob apps2data GoogleDialer;
 shjob apps2data GoogleContacts; 
fi

if [ "$($RCV GoogleDialer $NLP)" == "3" ]; then
 ui_print "-> Installing latest Google Dialer...";
 ui_print "   - with remaining OOS Dialer -";
 shjob cp f $(find $TMPDIR/apps/GoogleDialer/new/system -type f -name "*GoogleDialer.apk*") /data/xXx/ 
 shjob cp d $TMPDIR/apps/GoogleDialer/new/system $TMPDIR/system/;
 shjob dalvik GoogleContacts com.google.android.contacts;
 shjob dalvik GoogleDialer com.google.android.dialer; 
 shjob dalvik Contacts com.android.contacts;
 shjob dalvik Dialer com.android.dialer; 
 shjob perms Dialer;
 shjob config.flags GoogleDialer 1;
 shjob apps2data GoogleDialer;
 shjob apps2data GoogleContacts; 
fi 

if [ "$($RCV GoogleDialer $NLP)" == "4" ]; then
 ui_print "-> Installing old Google Dialer...";
 ui_print "   - with remaining OOS Dialer -";
 shjob cp f $(find $TMPDIR/apps/GoogleDialer/old/system -type f -name "*GoogleDialer.apk*") /data/xXx/  
 shjob cp d $TMPDIR/apps/GoogleDialer/old/system $TMPDIR/system/;
 shjob dalvik GoogleContacts com.google.android.contacts;
 shjob dalvik GoogleDialer com.google.android.dialer;
 shjob dalvik Contacts com.android.contacts;
 shjob dalvik Dialer com.android.dialer; 
 shjob perms Dialer;
 shjob config.flags GoogleDialer 1;
 shjob apps2data GoogleDialer;
 shjob apps2data GoogleContacts;
fi
 


if [ "$($RCV GoogleCamera $NLP)" == "1" ] || [ "$($RCV GoogleCamera $NLP)" == "2" ]; then
  ui_print "-> Installing modded Google Camera...";
  ui_print "   - thanks to @Urnyx05 -";
  shjob cp f $(find $TMPDIR/apps -type f -name "*GoogleCamera.apk*") /data/xXx/
  if [ "$($RCV GoogleCamera $NLP)" == "2" ]; then
	  shjob cp d $TMPDIR/apps/GoogleCamera/system $TMPDIR/system/;
	  shjob lib GoogleCamera x $TMPDIR/system/app;
  fi
  shjob cp d $TMPDIR/apps/GoogleCamera/root $MODPATH/;
  shjob dalvik com.google.android.GoogleCamera.Urnyx;
  sh $TMPDIR/btweaks.sh GCam.prop;  
  shjob apps2data GoogleCamera;
  shjob perms GoogleCamera;
else
  if [ -f /data/system/xXx/GoogleCamera.flag ]; then
    ui_print "-> Uninstalling Google Camera...";
	shjob dalvik GoogleCamera com.google.android.GoogleCamera.Urnyx;
 	shjob apps2data GoogleCameraRM;
  fi
fi


if [ "$($RCV AlwaysOn $NLP)" == "1" ]; then
  ui_print "-> Installing AlwaysOn Display...";
  ui_print "   - thanks to @domi04151309 -";
  shjob cp d $TMPDIR/apps/AlwaysOn/system $TMPDIR/system/;  
  shjob dalvik AlwaysOn io.github.domi04151309.alwayson;
  shjob apps2data AlwaysOn;
  shjob perms AlwaysOn;
else
  if [ -f /data/system/xXx/AlwaysOn.flag ]; then
    ui_print "-> Uninstalling AlwaysOn Display...";
	shjob dalvik AlwaysOn io.github.domi04151309.alwayson;
	shjob apps2data AlwaysOnRM;
  fi 
fi



if [ "$($RCV MoreLocale $NLP)" == "1" ]; then
  ui_print "-> Installing MoreLocale2 for HydrogenOS...";
  shjob apps2data MoreLocale;
else
  if [ -f /data/system/xXx/MoreLocale.flag ]; then
    ui_print "-> Uninstalling MoreLocale...";
	shjob apps2data MoreLocaleRM;
  fi 
fi


if [ "$($RCV IceBoxSpeedup $NLP)" == "1" ]; then
  ui_print "-> Installing Ice Box System Plugin...";
  shjob cp d $TMPDIR/apps/IceBoxSpeedup/system $TMPDIR/system/;
  shjob dalvik IceBoxSpeedup com.catchingnow.iceboxsystemplugin;
fi


ProfCat=.Substratum_Mods
if [ "$($RCV SubstratumThemeEngine $NLP)" == "1" ]; then
 ui_print "-> Installing Substratum Theme Engine...";
 ui_print "   - thanks to chummy development team -";
 shjob apps2data Substratum;
 shjob perms Substratum;
else
  if [ -f /data/system/xXx/SubstratumThemeEngine.flag ]; then
    ui_print "-> Uninstalling SubstratumThemeEngine...";
	shjob apps2data SubstratumRM; 
  fi
fi

if [ "$($RCV K-KlockModule $NLP)" == "1" ]; then
 ui_print "-> Installing K-Klock Theme Module...";
 ui_print "   - thanks to @KpChuck -";
 shjob apps2data K-Manager;
 shjob perms K-Klock;
else
  if [ -f /data/system/xXx/K-Manager.flag ]; then
    ui_print "-> Uninstalling K-Klock Theme Modul...";
	shjob apps2data K-ManagerRM; 
  fi 
fi

if [ "$($RCV Aether $NLP)" == "1" ]; then
 ui_print "-> Installing Aether substratum module...";
 ui_print "   - thanks to @ungeeked -";
 shjob apps2data Aether;
else
  if [ -f /data/system/xXx/Aether.flag ]; then
    ui_print "-> Uninstalling Aether substratum module...";
	shjob apps2data AetherRM; 
  fi  
fi

ProfCat=.Audio_Mods
shjob config.flags DolbyAtmosUI 0;
if [ "$($RCV DolbyAtmosUI $NLP)" != "0" ]; then
 case $($RCV ro.build.product $Flags) in
 *OnePlus7*) 
   shjob config.flags DolbyAtmosUI 1;
   ;;
 *OnePlus8*)
   shjob config.flags DolbyAtmosUI 1;
   ;;
 esac
fi

if [ "$($RCV DolbyAtmosUI $Flags)" == "1" ]; then
  ui_print "-> Installing Dolby Atmos UI with graphic Equalizer...";
  ui_print "   - thanks to jamal2367... -";
  shjob dalvik DaxUI com.dolby.daxappui;
  shjob cp d $TMPDIR/sound/Atmos/system $TMPDIR/system/; 
  shjob debloat d /app/OPSoundTuner com.oneplus.sound.tuner 1;
fi

if [ "$($RCV ViperProfileCollection $NLP)" == "1" ]; then
 ui_print "-> Installing Viper Profile Collection...";
 ui_print "   - thanks to @A.R.I.S.E. Team -";
 shjob apps2data ViPER4Android Complete;
 ui_print " ";
fi

if [ "$($RCV StereoSpeakerMod $NLP)" == "1" ]; then
 case $($RCV ro.build.product $Flags) in
 *OnePlus5*) 
   ui_print "-> Installing OP5 Stereo Speaker mod...";
   ui_print "   - thanks to @shadowstep -";
   shjob cp d $TMPDIR/sound/stereoOP5/system $TMPDIR/system/;
   ;;
 *OnePlus6*)
   ui_print "-> Installing OP6 Stereo Speaker mod...";
   ui_print "   - thanks to @acervenky & @DorianX -";
   shjob stereo.mod;
   ;;
 esac
fi

if [ "$($RCV DolbyAtmosUI $Flags)" == "0" ]; then	 
	if [ "$($RCV Viper4Android $NLP)" == "1" ]; then
	  ui_print "-> Installing Viper4Android...";
	  ui_print "   - thanks to Ahrion,Zackptg5,ViPER520,ZhuHang... -";
	  shjob cp d $TMPDIR/sound/viper1/system $TMPDIR/system/;
	  shjob cp d $TMPDIR/sound/all/system $TMPDIR/system/; 
	  echo "Uninstall flag" > /data/system/xXx/Viper4Android.flag;  
	  shjob config.flags Viper 1;
	  sh $TMPDIR/btweaks.sh V4A.prop;
	  shjob apps2data ViPER4AndroidFX;
	  shjob dalvik ViPER4Android com.pittvandewitt.viperfx;
	  shjob apps2data ViPER4Android Essentials;
	  shjob perms Viper;
	else
	  if [ -f /data/system/xXx/Viper4Android.flag ]; then
		ui_print "-> Uninstalling Viper4Android...";
		shjob dalvik ViPER4Android com.pittvandewitt.viperfx;
		shjob rm f /data/system/xXx/Viper4Android.flag;
	  fi 
	fi

	if [ "$($RCV Viper4Android $NLP)" == "2" ]; then
	  ui_print "-> Installing Viper4AndroidFX...";
	  ui_print "   - thanks to Team DeWitt... -";
	  shjob cp d $TMPDIR/sound/viper2/system $TMPDIR/system/;
	  shjob cp d $TMPDIR/sound/all/system $TMPDIR/system/; 
	  shjob cp f $(find $TMPDIR/sound/viper2 -type f -name "*ViPER4Android.apk*") /data/xXx/
	  shjob config.flags Viper 1;
	  sh $TMPDIR/btweaks.sh V4A.prop;
	  shjob apps2data ViPER4AndroidFX;
	  shjob dalvik ViPER4Android com.pittvandewitt.viperfx;
	  shjob apps2data ViPER4Android Essentials;
	  shjob perms Viper;
	else
	  if [ -f /data/system/xXx/ViPER4AndroidFX.flag ]; then
		ui_print "-> Uninstalling ViPER4AndroidFX...";
		shjob dalvik ViPER4Android com.pittvandewitt.viperfx;
		shjob apps2data ViPER4AndroidRM;
	  fi   
	fi


	if [ "$($RCV JamesDSP $NLP)" == "1" ]; then
	  ui_print "-> Installing JamesDSP...";
	  ui_print "   - thanks to james34602, ahrion, zackptg5... -";
	  shjob cp d $TMPDIR/sound/JamesDSP/system $TMPDIR/system/;
	  shjob cp d $TMPDIR/sound/all/system $TMPDIR/system/;
	  shjob config.flags JamesDSP 1;  
	  shjob dalvik JamesDSPManager james.dsp;
	  shjob apps2data JamesDspEssentials;
	  shjob apps2data JamesDSP;
	  shjob perms JamesDSP;
	else
	  if [ -f /data/system/xXx/JamesDSP.flag ]; then
		ui_print "-> Uninstalling JamesDSP...";
		shjob dalvik JamesDSPManager james.dsp;
		shjob apps2data JamesDspRM;
	  fi 
	fi


	if [ "$($RCV DolbyDigital $NLP)" == "1" ]; then
	  ui_print "-> Installing Dolby Digital...";
	  ui_print "   - thanks to repey6, Ahrion and Zackptg5... -";
	  shjob cp d $TMPDIR/sound/dolby/system $TMPDIR/system/;
	  shjob cp d $TMPDIR/sound/all/system $TMPDIR/system/; 
	  echo "Uninstall flag" > /data/system/xXx/DolbyDigital.flag;  
	  shjob config.flags Dolby 1;
	  shjob dalvik Ds com.dolby;
	  shjob dalvik DsUI com.dolby.ds1appUI;   
	  shjob perms Dolby;
	  sh $TMPDIR/btweaks.sh DDP.prop;
		shjob dalvik daxService com.dolby.daxservice;
		shjob dalvik OPSoundTuner com.oneplus.sound.tuner;	
	else
	  if [ -f /data/system/xXx/DolbyDigital.flag ]; then
		ui_print "-> Uninstalling Dolby Digital...";
		shjob dalvik Ds com.dolby;
		shjob dalvik DsUI com.dolby.ds1appUI;	
		shjob rm f /data/system/xXx/DolbyDigital.flag;
	  fi  
	fi
fi


if [ "$($RCV PixelSounds $NLP)" == "1" ]; then
  ui_print "-> Installing Pixel Sounds...";
     shjob cp d $TMPDIR/sound/Pixel/system $TMPDIR/system;
fi  
  

ProfCat=.Launchers

if [ "$($RCV NovaLauncher $NLP)" == "1" ]; then
 ui_print "-> Installing Nova Launcher...";
 shjob cp f $(find $TMPDIR/apps -type f -iname "*Nova_Launcher.apk*") /data/xXx/
 shjob cp d $TMPDIR/apps/Nova_Launcher/system $TMPDIR/system/;
 shjob apps2data NovaLauncher; 
 shjob dalvik Nova_Launcher com.teslacoilsw.launcher;
 shjob perms NovaLauncher;
 else
	if [ -f /data/system/xXx/NovaLauncher.flag ]; then
		ui_print "-> Uninstalling NovaLauncher...";
		shjob apps2data NovaLauncherRM;
		shjob dalvik Nova_Launcher com.teslacoilsw.launcher;
	fi 
fi

if [ "$($RCV ActionLauncher $NLP)" == "1" ]; then
 ui_print "-> Installing Action Launcher...";
 shjob cp f $(find $TMPDIR/apps -type f -iname "*Action_Launcher.apk*") /data/xXx/
 shjob cp d $TMPDIR/apps/Action_Launcher/system $TMPDIR/system/;
 shjob apps2data ActionLauncher; 
 shjob dalvik Action_Launcher com.actionlauncher.playstore;
 shjob perms ActionLauncher;
 else
	if [ -f /data/system/xXx/ActionLauncher.flag ]; then
		ui_print "-> Uninstalling Action Launcher...";
		shjob apps2data ActionLauncherRM;
		shjob dalvik Action_Launcher com.actionlauncher.playstore;
	fi 
fi

if [ "$($RCV PixelLaucher $NLP)" == "1" ]; then
 ui_print "-> Installing Pixel Laucher...";
 shjob cp f $(find $TMPDIR/apps -type f -iname "*Pixel_Launcher.apk*") /data/xXx/
 shjob cp d $TMPDIR/apps/Pixel_Launcher/system $TMPDIR/system/;
 shjob apps2data PixelLaucher; 
 shjob dalvik Pixel_Launcher amirz.rootless.nexuslauncher;
 shjob dalvik WallpaperPickerGoogle com.google.android.apps.wallpaper;
 shjob perms PixelLaucher;
 else
	if [ -f /data/system/xXx/PixelLaucher.flag ]; then
		ui_print "-> Uninstalling Pixel Laucher...";
		shjob apps2data PixelLaucherRM;
		shjob dalvik Pixel_Launcher amirz.rootless.nexuslauncher;
		shjob dalvik WallpaperPickerGoogle com.google.android.apps.wallpaper;
	fi 
fi

if [ "$($RCV LawnchairLaucher $NLP)" == "1" ]; then
 ui_print "-> Installing Lawnchair Laucher...";
 shjob cp f $(find $TMPDIR/apps -type f -iname "*Lawnchair.apk*") /data/xXx/
 shjob cp d $TMPDIR/apps/Lawnchair/system $TMPDIR/system/;
 shjob apps2data LawnchairLaucher;
 shjob dalvik Lawnchair ch.deletescape.lawnchair.plah;
 shjob perms LawnChairLauncher; 
 else
	if [ -f /data/system/xXx/LawnchairLaucher.flag ]; then
		ui_print "-> Uninstalling Lawnchair Laucher...";
		shjob apps2data LawnchairLaucherRM;
		shjob dalvik Lawnchair ch.deletescape.lawnchair.plah;
	fi 
fi




ProfCat=.Bootanimations

if [ ! -f /sdcard/xXx/bootanimation.zip ]; then
 case $($RCV ro.build.product $Flags) in
 *OnePlus7Pro*)
	shjob cp f $TMPDIR/apps/BootAnimations/NoLimits/1440/system/media/bootanimation.zip /sdcard/xXx/;
	shjob cp f $TMPDIR/apps/BootAnimations/NoLimits/1440/system/media/bootanimation.zip /data/system/xXx/;
	;;
 *)
	shjob cp f $TMPDIR/apps/BootAnimations/NoLimits/1080/system/media/bootanimation.zip /sdcard/xXx/;
	shjob cp f $TMPDIR/apps/BootAnimations/NoLimits/1080/system/media/bootanimation.zip /data/system/xXx/;
	;;
 esac
else
 shjob cp f /sdcard/xXx/bootanimation.zip /data/system/xXx/;
fi


if [ "$($RCV CustomBootAnimation $NLP)" == "1" ]; then
 ui_print "-> Installing xXx NoLimits Bootanimation...";
 ui_print "   - thanks to to @Roger_T -";
 case $($RCV ro.build.product $Flags) in
 *OnePlus7Pro*)
	shjob cp d $TMPDIR/apps/BootAnimations/NoLimits/1440/system $TMPDIR/system/;
	shjob cp d $TMPDIR/apps/BootAnimations/NoLimits/1440/system $TMPDIR/system/product/;
	;;
 *)
	shjob cp d $TMPDIR/apps/BootAnimations/NoLimits/1080/system $TMPDIR/system/;
	shjob cp d $TMPDIR/apps/BootAnimations/NoLimits/1080/system $TMPDIR/system/product/;
	;;
 esac
fi

if [ "$($RCV CustomBootAnimation $NLP)" == "2" ]; then
 ui_print "-> Installing Oxygen Stock Bootanimation...";
 case $($RCV ro.build.product $Flags) in
 *OnePlus7Pro*)
	shjob cp d $TMPDIR/apps/BootAnimations/OOS/1440/system $TMPDIR/system/;
	shjob cp d $TMPDIR/apps/BootAnimations/OOS/1440/system $TMPDIR/system/product/;
	;;
 *)
	shjob cp d $TMPDIR/apps/BootAnimations/OOS/1080/system $TMPDIR/system/;
	shjob cp d $TMPDIR/apps/BootAnimations/OOS/1080/system $TMPDIR/system/product/;
	;;
 esac
fi

if [ "$($RCV CustomBootAnimation $NLP)" == "3" ]; then
 ui_print "-> Installing Bootanimation from xXx Folder...";
 shjob bootani;
 shjob config.flags custom.bootani 1;
fi

if [ "$($RCV CustomBootAnimation $NLP)" == "4" ]; then
 ui_print "-> Installing WatchDogs Bootanimation...";
 ui_print "   - thanks to @Robdyx -";
 case $($RCV ro.build.product $Flags) in
 *OnePlus7Pro*)
	shjob cp d $TMPDIR/apps/BootAnimations/WatchDogs/1440/system $TMPDIR/system/;
	shjob cp d $TMPDIR/apps/BootAnimations/WatchDogs/1440/system $TMPDIR/system/product/;
	;;
 *)
	shjob cp d $TMPDIR/apps/BootAnimations/WatchDogs/1080/system $TMPDIR/system/;
	shjob cp d $TMPDIR/apps/BootAnimations/WatchDogs/1080/system $TMPDIR/system/product/;
	;;
 esac
fi

if [ "$($RCV CustomBootAnimation $NLP)" == "5" ]; then
 ui_print "-> Installing McLaren Bootanimation...";
 ui_print "   - thanks to @Mishaal Rahman -";
 shjob cp d $TMPDIR/apps/BootAnimations/McLaren/system $TMPDIR/system/;
 shjob cp d $TMPDIR/apps/BootAnimations/McLaren/system $TMPDIR/system/product/;
fi

if [ "$($RCV CustomBootAnimation $NLP)" == "6" ]; then
 ui_print "-> Installing Google Pixel 1 Bootanimation...";
 shjob cp d $TMPDIR/apps/BootAnimations/GooglePixel1/system $TMPDIR/system/;
 shjob cp d $TMPDIR/apps/BootAnimations/GooglePixel1/system $TMPDIR/system/product/;
fi

if [ "$($RCV CustomBootAnimation $NLP)" == "7" ]; then
 ui_print "-> Installing Google Pixel 2 Bootanimation...";
 shjob cp d $TMPDIR/apps/BootAnimations/GooglePixel2/system $TMPDIR/system/;
 shjob cp d $TMPDIR/apps/BootAnimations/GooglePixel2/system $TMPDIR/system/product/;
fi

if [ "$($RCV CustomBootAnimation $NLP)" == "8" ]; then
 ui_print "-> Installing Google Pixel 3 Bootanimation...";
 shjob cp d $TMPDIR/apps/BootAnimations/GooglePixel3/system $TMPDIR/system/;
 shjob cp d $TMPDIR/apps/BootAnimations/GooglePixel3/system $TMPDIR/system/product/;
fi

if [ "$($RCV CustomBootAnimation $NLP)" == "9" ]; then
 ui_print "-> Installing xXx NoLimit Porsche Edition Bootanimation...";
 ui_print "   - thanks to @Roger.T & @Xenix96 -";
 case $($RCV ro.build.product $Flags) in
 *OnePlus7Pro*)
	shjob cp d $TMPDIR/apps/BootAnimations/Porsche/1440/system $TMPDIR/system/;
	shjob cp d $TMPDIR/apps/BootAnimations/Porsche/1440/system $TMPDIR/system/product/;
	;;
 *)
	shjob cp d $TMPDIR/apps/BootAnimations/Porsche/1080/system $TMPDIR/system/;
	shjob cp d $TMPDIR/apps/BootAnimations/Porsche/1080/system $TMPDIR/system/product/;
	;;
 esac
fi


if [ "$($RCV xXxNoLimitsLogo-SplashScreen $NLP)" == "1" ]; then
 ui_print "-> Flashing xXx NoLimits Logo - Splash Screen ...";
 shjob flash logo xXxNoLimits1;
fi

ProfCat=nothing

if [ "$($RCV AnimationScale $NLP)" == "1" ]; then
 ui_print "-> Set Windows Aninimation Scale Values to 0 ...";
 ProfCat=.Tweaks__Animation_Scales
 shjob config.flags AnimationScales 1;
 shjob scales 0;
fi

if [ "$($RCV AnimationScale $NLP)" == "2" ]; then
 ui_print "-> Set Windows Aninimation Scale Values to 0.25 ...";
 ProfCat=.Tweaks__Animation_Scales
 shjob config.flags AnimationScales 1;
 shjob scales 0.25;
fi

if [ "$($RCV AnimationScale $NLP)" == "3" ]; then
 ui_print "-> Set Windows Aninimation Scale Values to 0.50 ...";
 ProfCat=.Tweaks__Animation_Scales
 shjob config.flags AnimationScales 1;
 shjob scales 0.50;
fi

if [ "$($RCV AnimationScale $NLP)" == "4" ]; then
 ui_print "-> Set Windows Aninimation Scale Values to 0.75 ...";
 ProfCat=.Tweaks__Animation_Scales
 shjob config.flags AnimationScales 1;
 shjob scales 0.75;
fi

if [ "$($RCV AnimationScale $NLP)" == "5" ]; then
 ui_print "-> Set Windows Aninimation Scale Values to 1 ...";
 ProfCat=.Tweaks__Animation_Scales
 shjob config.flags AnimationScales 1;
 shjob scales 1.0;
fi


ProfCat=nothing
if [ "$($RCV ModdedAppsDetaching $NLP)" == "1" ]; then
	shjob config.flags Detach 1;
else
	shjob config.flags Detach 0; 
fi


ui_print "-> Building xXx NoLimits Magisk module...";
	if [ "$($RCV YouTubeVanced $NLP)" != "0" ] && [ "$($RCV YouTubeVanced $NLP)" != "4" ]; then
	  shjob debloat k YouTube; 
	fi
	if [ "$($RCV YouTubeVanced $NLP)" == "3" ]; then
	  sed -i '/pm uninstall -k com.google.android.youtube/d' /data/xXx/temp_xXx_apps2data.sh >&2
	fi	
	shjob debloat d /vendor/etc/apps
	shjob systemapps;
		shjob debloat p
	shjob build.prop rom xXx_NoLimits_12.3;
	shjob rm d $SourceDir;
	cp -rf $TMPDIR/Magisk/Module/* $MODPATH/;
	cp -rf $TMPDIR/debloat/system/* $MODPATH/system/;
	cp -rf $TMPDIR/system/* $MODPATH/system/;
	rm -f $MODPATH/xXx* 2>/dev/null
	set_perm_recursive $MODPATH 0 0 0755 0755 
	set_perm_recursive $MODPATH/system 0 0 0755 0644 
	set_perm_recursive $MODPATH/system/etc/xXx 0 0 0755 0777 
	set_perm_recursive $MODPATH/system/xbin 0 2000 0777 0777
	chcon -hR 'u:object_r:system_file:s0' $MODPATH
	ui_print " ";

ProfCat=.BusyBox
if [ "$($RCV BusyBox $NLP)" == "1" ]; then
	ui_print "-> Installing BusyBox...";
	ui_print "   - by osm0sis @ xda-developers -";
	unzip -o "$TMPDIR/bbox/bbox.zip" 'busybox-arm64' -d $TMPDIR/bbox >&2
	mkdir -p $MODPATH/system/xbin
	cp -f $TMPDIR/bbox/busybox-arm64 $MODPATH/system/xbin/busybox
	set_perm_recursive $MODPATH/system/xbin 0 2000 0777 0777
	$MODPATH/system/xbin/busybox --install -s $MODPATH/system/xbin		
fi 

ProfCat=nothing
ui_print "-> Fixing permissions and cleanup";
	shjob ini;
 
ui_print "   - Set Permissions -";
	shjob perm;
	if [ "$($RCV  FixSDcardpermissions $NLP)" == "1" ]; then
		ui_print "-> SDcard Fix Permissions Script...";
		ui_print "   - by osm0sis @ xda-developers -";
		ui_print "   - this process can take some time longer!! -";
		shjob sd;
	fi 

ui_print "   - Wipes Caches -";
	shjob WipeCache;

ui_print " ";
ui_print "->  xXx No Limits ROM Installation completed <---";
ui_print " ";

sort -u $TmpLog > $ProfLog
sed -i '1s/^/=========================================================================\n/' $ProfLog
sed -i '2s/^/ xXx_NoLimits_12.3 - Profile Selections Summary - '$(date +%Y-%m-%d_%H:%M:%S)'\n/' $ProfLog
sed -i '3s/^/=========================================================================\n/' $ProfLog
shjob cp f $TMPDIR/recovery.log /sdcard/xXx/logs/;
shjob cp f $TMPDIR/shjob.log /sdcard/xXx/logs/;
mount -o ro,remount /system_root


