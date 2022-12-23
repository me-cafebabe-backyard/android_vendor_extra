PRODUCT_SOONG_NAMESPACES += $(LOCAL_PATH)

# Variable checks
ifeq ($(EXTRA_DEVICE_BRACKET),)
$(error EXTRA_DEVICE_BRACKET is undefined)
endif

# Android Go
ifeq ($(EXTRA_DEVICE_BRACKET),low-end)
include $(LOCAL_PATH)/product/go.mk
endif

# APPs - AOSP
PRODUCT_PACKAGES += \
    NotePad

# Freeform Multiwindow
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.freeform_window_management.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.freeform_window_management.xml

# Overlays
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

PRODUCT_PACKAGES += \
    Extra_BromiteWebViewOverlay \
    Extra_NTPOverlay

ifeq ($(EXTRA_DEVICE_BRACKET),low-end)
ifeq ($(call math_lt,$(PLATFORM_SDK_VERSION),33),true)
PRODUCT_PACKAGES += \
    Extra_InProcessCaptivePortalUrlOverlay
else
PRODUCT_PACKAGES += \
    Extra_CaptivePortalUrlOverlay
endif
else # EXTRA_DEVICE_BRACKET
PRODUCT_PACKAGES += \
    Extra_CaptivePortalUrlOverlay \
    Extra_SQLiteModeOverlay
endif # EXTRA_DEVICE_BRACKET

# Inherits
ifneq ($(PRODUCT_EXCLUDE_IH8SN),true)
$(call inherit-product-if-exists, ih8sn/ih8sn.mk)
endif
$(call inherit-product-if-exists, vendor/xiaomi/ringtones/ringtones-vendor.mk)

# Inherit private extra if exists
$(call inherit-product-if-exists, vendor/extra-priv/extra-priv.mk)
