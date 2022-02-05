include vendor/statix/build/core/vendor/*.mk

ifneq ($(TARGET_DOES_NOT_USE_GAPPS), true)
$(call inherit-product-if-exists, vendor/gms/products/gms.mk)
endif

ifeq ($(PRODUCT_USES_QCOM_HARDWARE), true)
include vendor/statix/build/core/ProductConfigQcom.mk
$(call inherit-product-if-exists, device/qcom/common/common.mk)
endif

$(call inherit-product, vendor/qcom/opensource/power/power-vendor-board.mk)

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

ifeq ($(TARGET_USES_BLUR), true)
PRODUCT_PRODUCT_PROPERTIES += \
    ro.sf.blurs_are_expensive=1 \
    ro.surface_flinger.supports_background_blur=1
endif

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    keyguard.no_require_sim=true \
    dalvik.vm.debug.alloc=0 \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dataroaming=false \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.com.android.dateformat=MM-dd-yyyy \
    persist.sys.disable_rescue=true \
    ro.build.selinux=1

# copy privapp permissions
PRODUCT_COPY_FILES += \
    vendor/statix/prebuilt/common/etc/permissions/privapp-permissions-statix-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-statix-product.xml \
    vendor/statix/prebuilt/common/etc/permissions/privapp-permissions-statix-system.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-statix-system.xml

# Copy quick tap enable sysconfig
ifneq ($(DISABLE_COLUMBUS), true)
PRODUCT_COPY_FILES += \
    vendor/statix/prebuilt/common/etc/sysconfig/quick_tap.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/quick_tap.xml
endif

# Enable support of one-handed mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_one_handed_mode=true

# IORap app launch prefetching using Perfetto traces and madvise
PRODUCT_PRODUCT_PROPERTIES += \
    ro.iorapd.enable=true

# Statix-specific init file
PRODUCT_COPY_FILES += \
    vendor/statix/prebuilt/common/etc/init.statix.rc:system/etc/init/init.statix.rc

# Sysconfig
PRODUCT_COPY_FILES += \
    vendor/statix/prebuilt/common/etc/sysconfig/game_overlay.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/game_overlay.xml

# Build ID
PRODUCT_BUILD_PROP_OVERRIDES += \
    BUILD_DISPLAY_ID="$(BUILD_ID)-$(TARGET_BUILD_VARIANT)"

# Packages
include vendor/statix/config/packages.mk

# Branding
include vendor/statix/config/branding.mk

# Bootanimation
include vendor/statix/config/bootanimation.mk

# Fonts
include vendor/statix/config/fonts.mk

# Overlays
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/statix/overlay
DEVICE_PACKAGE_OVERLAYS += vendor/statix/overlay/common

# Artifact path requirements
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/etc/init/init.statix.rc \
    system/etc/permissions/privapp-permissions-statix-system.xml \
    system/lib/libRSSupport.so \
    system/lib/libblasV8.so \
    system/lib/librsjni.so \
    system/lib64/libRSSupport.so \
    system/lib64/libblasV8.so \
    system/lib64/librsjni.so
