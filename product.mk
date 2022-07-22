PRODUCT_SOONG_NAMESPACES += $(LOCAL_PATH)

# Variable checks
ifeq ($(EXTRA_DEVICE_BRACKET),)
$(error EXTRA_DEVICE_BRACKET is undefined)
endif

# APPs - AOSP
PRODUCT_PACKAGES += \
    NotePad

# Build ID
TARGET_UNOFFICIAL_BUILD_ID := 0xCAFEBABE

# Overlays
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

PRODUCT_PACKAGES += \
    Extra_CaptivePortalUrlOverlay \
    Extra_NTPOverlay

# Inherits
$(call inherit-product-if-exists, ih8sn/ih8sn.mk)
$(call inherit-product-if-exists, vendor/xiaomi/ringtones/ringtones-vendor.mk)

# Inherit private extra if exists
$(call inherit-product-if-exists, vendor/extra-priv/extra-priv.mk)
