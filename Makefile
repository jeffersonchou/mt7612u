# SPDX-License-Identifier: GPL-2.0-only
obj-m += mt7612u_sta.o

# Default target
mt7612u_sta-objs := \
	util.o agg-rx.o dma.o debugfs.o eeprom.o mac80211.o\
	mcu.o trace.o tx.o \
	usb.o usb_trace.o mmio.o \
	mt76x02_beacon.o mt76x02_debugfs.o mt76x02_dfs.o \
	mt76x02_eeprom.o mt76x02_mac.o mt76x02_mcu.o \
	mt76x02_mmio.o mt76x02_phy.o mt76x02_trace.o mt76x02_txrx.o \
	mt76x02_usb_core.o mt76x02_usb_mcu.o mt76x02_util.o \
	mt7612/mac.o \
	mt7612/mcu.o \
	mt7612/init.o \
	mt7612/phy.o \
	mt7612/usb_init.o \
	mt7612/usb_mac.o \
	mt7612/usb_mcu.o \
	mt7612/usb_main.o \
	mt7612/eeprom.o \
	mt7612/usb_phy.o \
	mt7612/usb.o

# Define path
KDIR := /lib/modules/$(shell uname -r)/build
PWD := $(shell pwd)
BASE_PATH := "/home/ad/data/mt7612u54"
EXTRA_CFLAGS += -Wno-error
# EXTRA_CFLAGS += -DCONFIG_NL80211_TESTMODE

# Add compile flags for trace
CFLAGS_trace.o := -DTRACE_INCLUDE_PATH="$(BASE_PATH)" -DTRACE_INCLUDE_FILE="trace"
CFLAGS_mt76x02_trace.o := -DTRACE_INCLUDE_PATH="$(BASE_PATH)" -DTRACE_INCLUDE_FILE="mt76x02_trace"
CFLAGS_usb_trace.o := -DTRACE_INCLUDE_PATH="$(BASE_PATH)" -DTRACE_INCLUDE_FILE="usb_trace"

EXTRA_CFLAGS += -I$(KDIR)/include/net/mac80211
EXTRA_CFLAGS += -I$(KDIR)/include

ccflags-y := -I$(KDIR)/include/net/mac80211
ccflags-y += -I$(KDIR)/include
# 如果使用 KBUILD_EXTRA_SYMBOLS 来引用外部符号文件
# KBUILD_EXTRA_SYMBOLS := /path/to/other/module/Module.symvers

all:
	$(MAKE) -C $(KDIR) M=$(PWD) modules

clean:
	$(MAKE) -C $(KDIR) M=$(PWD) clean
	rm -f Module.symvers modules.order
