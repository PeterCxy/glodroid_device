# SPDX-License-Identifier: Apache-2.0
#
# Copyright (C) 2020 Roman Stratiienko (r.stratiienko@gmail.com)

$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)

$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_system.mk)
#PRODUCT_ENFORCE_ARTIFACT_PATH_REQUIREMENTS := relaxed

#
# All components inherited here go to system_ext image (same as GSI system_ext)
#
$(call inherit-product, $(SRC_TARGET_DIR)/product/handheld_system_ext.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/telephony_system_ext.mk)

#
# All components inherited here go to product image (same as GSI product)
#
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_product.mk)

# Exclude features that are not available on AOSP devices.
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/aosp_excluded_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/aosp_excluded_hardware.xml

$(call inherit-product, device/glodroid/common/device-common.mk)
$(call inherit-product, device/glodroid/common/device-common-sunxi.mk)
$(call inherit-product, device/glodroid/common/bluetooth/bluetooth.mk)

PRODUCT_PROPERTY_OVERRIDES += ro.sf.lcd_density=240

# Firmware
PRODUCT_COPY_FILES += \
    kernel/firmware/rockchip/dptx.bin:$(TARGET_COPY_OUT_VENDOR)/etc/firmware/rockchip/dptx.bin \
    vendor/megous/firmware/regulatory.db:$(TARGET_COPY_OUT_VENDOR)/etc/firmware/regulatory.db \
    vendor/megous/firmware/regulatory.db.p7s:$(TARGET_COPY_OUT_VENDOR)/etc/firmware/regulatory.db.p7s \
    vendor/megous/firmware/brcm/brcmfmac43455-sdio.bin:$(TARGET_COPY_OUT_VENDOR)/etc/firmware/brcm/brcmfmac43455-sdio.bin \
    vendor/megous/firmware/brcm/brcmfmac43455-sdio.txt:$(TARGET_COPY_OUT_VENDOR)/etc/firmware/brcm/brcmfmac43455-sdio.txt \
    vendor/megous/firmware/brcm/brcmfmac43455-sdio.clm_blob:$(TARGET_COPY_OUT_VENDOR)/etc/firmware/brcm/brcmfmac43455-sdio.clm_blob \
    vendor/megous/firmware/brcm/BCM4345C0.hcd:$(TARGET_COPY_OUT_VENDOR)/etc/firmware/brcm/BCM4345C0.hcd \

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/sensors.pinephonepro.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/sensors.pinephonepro.rc \
    $(LOCAL_PATH)/modem.pinephonepro.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/modem.pinephonepro.rc \

PRODUCT_COPY_FILES += \
    device/glodroid/pinephonepro/audio.pinephonepro.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio.pinephonepro.xml \
    device/glodroid/pinephonepro/camera_hal.yaml:$(TARGET_COPY_OUT_VENDOR)/etc/libcamera/camera_hal.yaml \

# Lights HAL
PRODUCT_PACKAGES += \
    android.hardware.lights-service.pinephonepro \

# Vibrator HAL
PRODUCT_PACKAGES += \
    android.hardware.vibrator-service.pinephonepro \

PRODUCT_PACKAGES += \
    sensors.iio \
    android.hardware.sensors@1.0-impl:64 \
    android.hardware.sensors@1.0-service

DEVICE_PACKAGE_OVERLAYS := \
    device/glodroid/overlays/common \
    device/glodroid/pinephonepro/overlay

# Modem packages and configuration
PRODUCT_PACKAGES += \
    libpinephonepro-ril-2 \
    libpinephonepro-rild \

PRODUCT_PROPERTY_OVERRIDES += \
    ro.boot.modem_simulator_ports=-1 \
    vendor.rild.libargs=-d/dev/ttyUSB2 \

# Checked by android.opengl.cts.OpenGlEsVersionTest#testOpenGlEsVersion. Required to run correct set of dEQP tests.
# 131072 == 0x00020000 == GLES v2.0
PRODUCT_VENDOR_PROPERTIES += \
    ro.opengles.version=131072 \
    vendor.hwc.drm.use_overlay_planes=0
