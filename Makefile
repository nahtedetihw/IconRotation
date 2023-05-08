TARGET := iphone:clang:latest:13.0
INSTALL_TARGET_PROCESSES = SpringBoard

DEBUG = 0

FINALPACKAGE = 1
THEOS_PACKAGE_SCHEME=rootless

SYSROOT=$(THEOS)/sdks/iphoneos14.2.sdk

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = IconRotation

IconRotation_FILES = Tweak.xm
IconRotation_CFLAGS = -fobjc-arc -Wno-deprecated-declarations

include $(THEOS_MAKE_PATH)/tweak.mk
