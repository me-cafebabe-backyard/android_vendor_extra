LOCAL_PATH := $(call my-dir)

include $(call all-makefiles-under,$(LOCAL_PATH))

ifeq ($(PRODUCT_USE_DYNAMIC_PARTITIONS),true)
LPFLASH := $(HOST_OUT_EXECUTABLES)/lpflash$(HOST_EXECUTABLE_SUFFIX)
INSTALLED_SUPERIMAGE_EMPTY_RAW_TARGET := $(PRODUCT_OUT)/super_empty_raw.img

$(INSTALLED_SUPERIMAGE_EMPTY_RAW_TARGET): $(LPFLASH) $(PRODUCT_OUT)/super_empty.img
	$(call pretty,"Target empty super fs raw image: $@")
	$(hide) touch $@
	$(hide) echo $(CURDIR)
	$(hide) $(LPFLASH) $@ $(PRODUCT_OUT)/super_empty.img

.PHONY: superimage_empty_raw
superimage_empty_raw: $(INSTALLED_SUPERIMAGE_EMPTY_RAW_TARGET)

ALL_DEFAULT_INSTALLED_MODULES += $(INSTALLED_SUPERIMAGE_EMPTY_RAW_TARGET)
endif
