EXTRA_PATH := vendor/extra

# Properties
TARGET_ODM_PROP += \
    $(EXTRA_PATH)/props/common/odm.prop \
    $(EXTRA_PATH)/props/$(EXTRA_DEVICE_BRACKET)/odm.prop
TARGET_PRODUCT_PROP += \
    $(EXTRA_PATH)/props/common/product.prop \
    $(EXTRA_PATH)/props/$(EXTRA_DEVICE_BRACKET)/product.prop

ifeq ($(EXTRA_DEVICE_BRACKET),low-end)
TARGET_SYSTEM_EXT_PROP += \
    $(EXTRA_PATH)/props/go.prop
endif

# SEPolicy
ifeq ($(call math_gt,$(PLATFORM_SDK_VERSION),30),true)
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += $(EXTRA_PATH)/sepolicy/private
else
BOARD_PLAT_PRIVATE_SEPOLICY_DIR += $(EXTRA_PATH)/sepolicy/private
endif

# Inherit private extra if exists
-include vendor/extra-priv/BoardConfigExtraPriv.mk
