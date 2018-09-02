LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := SDL2_mixer

# Enable this if you want to support loading MOD music via modplug
# The library path should be a relative path to this directory.
SUPPORT_MOD_MODPLUG := false
MODPLUG_LIBRARY_PATH := external/libmodplug-0.8.8.4

# Enable this if you want to support loading MOD music via mikmod
# The library path should be a relative path to this directory.
SUPPORT_MOD_MIKMOD := false
MIKMOD_LIBRARY_PATH := external/libmikmod-3.1.12

# Enable this if you want to support loading MP3 music via SMPEG
# The library path should be a relative path to this directory.
SUPPORT_MP3_SMPEG := false
SMPEG_LIBRARY_PATH := external/smpeg2-2.0.0

# Enable this if you want to support loading OGG Vorbis music via Tremor
# The library path should be a relative path to this directory.
SUPPORT_OGG := true
OGG_LIBRARY_PATH := src/external/libogg-1.3.1
VORBIS_LIBRARY_PATH := src/external/libvorbisidec-1.2.1


LOCAL_C_INCLUDES := $(LOCAL_PATH)
LOCAL_CFLAGS := -DWAV_MUSIC

# LOCAL_SRC_FILES := $(notdir $(filter-out %/playmus.c %/playwave.c, $(wildcard $(LOCAL_PATH)/*.c)))

LOCAL_SRC_FILES := \
src/dynamic_flac.c           \
src/dynamic_fluidsynth.c     \
src/dynamic_mod.c            \
src/dynamic_modplug.c        \
src/dynamic_mp3.c            \
src/dynamic_ogg.c            \
src/effect_position.c        \
src/effects_internal.c       \
src/effect_stereoreverse.c   \
src/fluidsynth.c             \
src/load_aiff.c              \
src/load_flac.c              \
src/load_mp3.c               \
src/load_ogg.c               \
src/load_voc.c               \
src/mixer.c                  \
src/music.c                  \
src/music_cmd.c              \
src/music_flac.c             \
src/music_mad.c              \
src/music_mod.c              \
src/music_modplug.c          \
src/music_ogg.c              \
src/wavestream.c


# $(info LOCAL_SRC_FILES is $(LOCAL_SRC_FILES))

LOCAL_LDLIBS := 
LOCAL_STATIC_LIBRARIES :=
LOCAL_SHARED_LIBRARIES := SDL2

SDL_PATH := ../SDL2

LOCAL_C_INCLUDES += $(LOCAL_PATH)/$(SDL_PATH)/include/

LOCAL_ARM_MODE := arm

ifeq ($(SUPPORT_MOD_MODPLUG),true)
    LOCAL_C_INCLUDES += $(LOCAL_PATH)/$(MODPLUG_LIBRARY_PATH)/src $(LOCAL_PATH)/$(MODPLUG_LIBRARY_PATH)/src/libmodplug
    LOCAL_CFLAGS += -DMODPLUG_MUSIC -DHAVE_SETENV -DHAVE_SINF
    LOCAL_SRC_FILES += \
        $(MODPLUG_LIBRARY_PATH)/src/fastmix.cpp \
        $(MODPLUG_LIBRARY_PATH)/src/load_669.cpp \
        $(MODPLUG_LIBRARY_PATH)/src/load_abc.cpp \
        $(MODPLUG_LIBRARY_PATH)/src/load_amf.cpp \
        $(MODPLUG_LIBRARY_PATH)/src/load_ams.cpp \
        $(MODPLUG_LIBRARY_PATH)/src/load_dbm.cpp \
        $(MODPLUG_LIBRARY_PATH)/src/load_dmf.cpp \
        $(MODPLUG_LIBRARY_PATH)/src/load_dsm.cpp \
        $(MODPLUG_LIBRARY_PATH)/src/load_far.cpp \
        $(MODPLUG_LIBRARY_PATH)/src/load_it.cpp \
        $(MODPLUG_LIBRARY_PATH)/src/load_j2b.cpp \
        $(MODPLUG_LIBRARY_PATH)/src/load_mdl.cpp \
        $(MODPLUG_LIBRARY_PATH)/src/load_med.cpp \
        $(MODPLUG_LIBRARY_PATH)/src/load_mid.cpp \
        $(MODPLUG_LIBRARY_PATH)/src/load_mod.cpp \
        $(MODPLUG_LIBRARY_PATH)/src/load_mt2.cpp \
        $(MODPLUG_LIBRARY_PATH)/src/load_mtm.cpp \
        $(MODPLUG_LIBRARY_PATH)/src/load_okt.cpp \
        $(MODPLUG_LIBRARY_PATH)/src/load_pat.cpp \
        $(MODPLUG_LIBRARY_PATH)/src/load_psm.cpp \
        $(MODPLUG_LIBRARY_PATH)/src/load_ptm.cpp \
        $(MODPLUG_LIBRARY_PATH)/src/load_s3m.cpp \
        $(MODPLUG_LIBRARY_PATH)/src/load_stm.cpp \
        $(MODPLUG_LIBRARY_PATH)/src/load_ult.cpp \
        $(MODPLUG_LIBRARY_PATH)/src/load_umx.cpp \
        $(MODPLUG_LIBRARY_PATH)/src/load_wav.cpp \
        $(MODPLUG_LIBRARY_PATH)/src/load_xm.cpp \
        $(MODPLUG_LIBRARY_PATH)/src/mmcmp.cpp \
        $(MODPLUG_LIBRARY_PATH)/src/modplug.cpp \
        $(MODPLUG_LIBRARY_PATH)/src/snd_dsp.cpp \
        $(MODPLUG_LIBRARY_PATH)/src/snd_flt.cpp \
        $(MODPLUG_LIBRARY_PATH)/src/snd_fx.cpp \
        $(MODPLUG_LIBRARY_PATH)/src/sndfile.cpp \
        $(MODPLUG_LIBRARY_PATH)/src/sndmix.cpp
endif

ifeq ($(SUPPORT_MOD_MIKMOD),true)
    LOCAL_C_INCLUDES += $(LOCAL_PATH)/$(MIKMOD_LIBRARY_PATH)/include
    LOCAL_CFLAGS += -DMOD_MUSIC
    LOCAL_SHARED_LIBRARIES += mikmod
endif

ifeq ($(SUPPORT_MP3_SMPEG),true)
    LOCAL_C_INCLUDES += $(LOCAL_PATH)/$(SMPEG_LIBRARY_PATH)
    LOCAL_CFLAGS += -DMP3_MUSIC
    LOCAL_SHARED_LIBRARIES += smpeg2
endif

ifeq ($(SUPPORT_OGG),true)
    LOCAL_C_INCLUDES += $(LOCAL_PATH)/$(OGG_LIBRARY_PATH)/include $(LOCAL_PATH)/$(VORBIS_LIBRARY_PATH)
    LOCAL_CFLAGS += -DOGG_MUSIC -DOGG_USE_TREMOR -DOGG_HEADER="<ivorbisfile.h>"
    ifeq ($(TARGET_ARCH_ABI),armeabi)
	LOCAL_CFLAGS += -D_ARM_ASSEM_
    endif
    ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
	LOCAL_CFLAGS += -D_ARM_ASSEM_
    endif
    ifeq ($(TARGET_ARCH_ABI),armeabi-v7a-hard)
	LOCAL_CFLAGS += -D_ARM_ASSEM_
    endif
    ifeq ($(TARGET_ARCH_ABI),arm64-v8a_DISABLED)
	LOCAL_CFLAGS += -D_ARM_ASSEM_
    endif
    LOCAL_SRC_FILES += \
        $(VORBIS_LIBRARY_PATH)/mdct.c \
        $(VORBIS_LIBRARY_PATH)/block.c \
        $(VORBIS_LIBRARY_PATH)/window.c \
        $(VORBIS_LIBRARY_PATH)/synthesis.c \
        $(VORBIS_LIBRARY_PATH)/info.c \
        $(VORBIS_LIBRARY_PATH)/floor1.c \
        $(VORBIS_LIBRARY_PATH)/floor0.c \
        $(VORBIS_LIBRARY_PATH)/vorbisfile.c \
        $(VORBIS_LIBRARY_PATH)/res012.c \
        $(VORBIS_LIBRARY_PATH)/mapping0.c \
        $(VORBIS_LIBRARY_PATH)/registry.c \
        $(VORBIS_LIBRARY_PATH)/codebook.c \
        $(VORBIS_LIBRARY_PATH)/sharedbook.c \
        $(OGG_LIBRARY_PATH)/src/framing.c \
        $(OGG_LIBRARY_PATH)/src/bitwise.c
endif

LOCAL_EXPORT_C_INCLUDES += $(LOCAL_C_INCLUDES)

LOCAL_CFLAGS += -Wall -Wextra -Wcast-align -Wno-unused-label -Wno-unused-function -Wno-unused-parameter -Wno-unused-variable -Wno-unused-but-set-variable -Wno-sign-compare -Wno-main -Wno-parentheses -Wno-switch -Wno-array-bounds -Wno-narrowing -Wno-maybe-uninitialized -Wno-format -Wno-write-strings -Wno-unused-value

LOCAL_LDLIBS := -llog

include $(BUILD_SHARED_LIBRARY)

ifeq ($(DO_SOME_STRANGE_STUFF),true)

	include $(CLEAR_VARS)

	LOCAL_MODULE := SDL2
	ifeq ($(TARGET_ARCH_ABI),armeabi-v7a-hard)
	LOCAL_SRC_FILES := ../../SDL_merged/libs/armeabi-v7a/libSDL2.so
	else
	LOCAL_SRC_FILES := ../../SDL_merged/libs/$(TARGET_ARCH_ABI)/libSDL2.so
	endif

include $(PREBUILT_SHARED_LIBRARY)

endif
