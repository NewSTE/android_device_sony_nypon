#
# Copyright (C) 2011 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#charging animation
$(call inherit-product, device/sony/montblanc-common/prebuilt/resources-540x960.mk)

# Inherit the proprietary counterpart
$(call inherit-product-if-exists, vendor/sony/nypon/nypon-vendor.mk)

DEVICE_PACKAGE_OVERLAYS += device/sony/nypon/overlay

# Inherit the montblanc-common definitions
$(call inherit-product, device/sony/montblanc-common/montblanc.mk)

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_eu_supl.mk)

# These are the hardware-specific features
PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml

# This device is xhdpi.  However the platform doesn't
# currently contain all of the bitmaps at xhdpi density so
# we do this little trick to fall back to the hdpi version
# if the xhdpi doesn't exist.
PRODUCT_AAPT_CONFIG := normal mdpi hdpi
PRODUCT_AAPT_PREF_CONFIG := hdpi

# Configuration scripts
PRODUCT_COPY_FILES += \
   device/sony/montblanc-common/prebuilt/logo-540x960.rle:root/logo.rle \

# Configuration scripts
PRODUCT_COPY_FILES += \
   $(LOCAL_PATH)/prebuilt/hw_config.sh:system/etc/hw_config.sh

# USB function switching
PRODUCT_COPY_FILES += \
   $(LOCAL_PATH)/config/init.st-ericsson.usb.rc:root/init.st-ericsson.usb.rc
   
#RamDisk
PRODUCT_COPY_FILES += \
   $(LOCAL_PATH)/config/init.nypon.rc:root/init.nypon.rc

PRODUCT_COPY_FILES += \
   $(LOCAL_PATH)/config/vold.fstab:system/etc/vold.fstab \
   $(LOCAL_PATH)/config/media_profiles.xml:system/etc/media_profiles.xml

# Recovery bootstrap (device-specific part)
PRODUCT_COPY_FILES += \
   $(LOCAL_PATH)/recovery/bootrec-device:root/sbin/bootrec-device \
   $(LOCAL_PATH)/recovery.fstab:root/recovery.fstab

# Key layouts and touchscreen
PRODUCT_COPY_FILES += \
   $(LOCAL_PATH)/config/AB8500_Hs_Button.kl:system/usr/keylayout/AB8500_Hs_Button.kl \
   $(LOCAL_PATH)/config/simple_remote.kl:system/usr/keylayout/simple_remote.kl \
   $(LOCAL_PATH)/config/so34-buttons.kl:system/usr/keylayout/so34-buttons.kl \
   $(LOCAL_PATH)/config/STMPE-keypad.kl:system/usr/keylayout/STMPE-keypad.kl \
   $(LOCAL_PATH)/config/tc3589x-keypad.kl:system/usr/keylayout/tc3589x-keypad.kl \
   $(LOCAL_PATH)/config/ux500-ske-keypad.kl:system/usr/keylayout/ux500-ske-keypad.kl.kl \
   $(LOCAL_PATH)/config/ux500-ske-keypad-qwertz.kl:system/usr/keylayout/ux500-ske-keypad-qwertz.kl \
   $(LOCAL_PATH)/config/sensor00_f11_sensor0.idc:system/usr/idc/sensor00_f11_sensor0.idc \
   $(LOCAL_PATH)/config/synaptics_rmi4_i2c.idc:system/usr/idc/synaptics_rmi4_i2c.idc

# Misc configuration files
PRODUCT_COPY_FILES += \
   $(LOCAL_PATH)/config/manuf_id.cfg:system/etc/AT/manuf_id.cfg \
   $(LOCAL_PATH)/config/model_id.cfg:system/etc/AT/model_id.cfg \
   $(LOCAL_PATH)/config/system_id.cfg:system/etc/AT/system_id.cfg \
   $(LOCAL_PATH)/config/button_light_curve.cfg:system/etc/button_light_curve.cfg \
   $(LOCAL_PATH)/config/cflashlib.cfg:system/etc/cflashlib.cfg \
   $(LOCAL_PATH)/config/flashled_param_config.cfg:system/etc/flashled_param_config.cfg \
   $(LOCAL_PATH)/config/dash.conf:system/etc/dash.conf

# NFC
PRODUCT_PACKAGES += \
    libnfc \
    libnfc_jni \
    Nfc \
    Tag

# NFCEE access control
ifeq ($(TARGET_BUILD_VARIANT),user)
    NFCEE_ACCESS_PATH := device/sony/montblanc-common/config/nfcee_access.xml
else
    NFCEE_ACCESS_PATH := device/sony/montblanc-common/config/nfcee_access_debug.xml
endif
PRODUCT_COPY_FILES += \
    $(NFCEE_ACCESS_PATH):system/etc/nfcee_access.xml

$(call inherit-product-if-exists, vendor/sony/nypon/nypon-vendor.mk)

PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=240

PRODUCT_PROPERTY_OVERRIDES += \
rild.libpath=/system/lib/libu300-ril.so \
rild.libargs=-c UNIX -n 2 -p /dev/socket/at_core -s /dev/socket/at_core -i rmnet \
ro.opengles.version=131072 \
debug.sf.hw=1 \
hwui.render_dirty_regions=false \
ro.semc.sols.product-code=105 \
ro.semc.sols.company-code=5 \
ste.nmf.autoidle=1 \
ste.dbus.bus.address=unix:path=/dev/socket/dbus_ste \
ro.telephony.call_ring.multiple=false \
ro.semc.product.user_storage=emmc_only \
ro.build.characteristics=nosdcard \
ro.nfc.on.default=false \
ro.nfc.se.sim.enable=true \
ro.nfc.se.smx.enable=false \
ro.nfc.icon.enable=true \
ro.nfc.vendor.name=nxp \
ste.video.dec.mpeg4.in.size=8192 \
ste.video.enc.out.buffercnt=5 \
ste.video.dec.recycle.delay=1 \
ste.special_fast_dormancy=false \
ste.video.decoder.max.hwmem=0x3600000 \
ste.video.decoder.max.res=1080p \
ste.video.decoder.h264.max.lev=4.2 \
persist.audio.hp=true \
ro.service.swiqi.supported=false \
persist.service.swiqi.enable=0
