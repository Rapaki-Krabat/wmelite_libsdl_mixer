
# pull in local SDL2 copy if building standalone
if (USE_LOCAL_SDL2)
	add_subdirectory(external/SDL2)
endif()

add_library(ogg STATIC
external/libogg-1.3.1/src/bitwise.c
external/libogg-1.3.1/src/framing.c
)

target_include_directories(ogg PUBLIC external/libogg-1.3.1/include/)

add_library(vorbisidec STATIC 
external/libvorbisidec-1.2.1/block.c
external/libvorbisidec-1.2.1/codebook.c
external/libvorbisidec-1.2.1/floor0.c
external/libvorbisidec-1.2.1/floor1.c
external/libvorbisidec-1.2.1/info.c
external/libvorbisidec-1.2.1/mapping0.c
external/libvorbisidec-1.2.1/mdct.c
external/libvorbisidec-1.2.1/registry.c
external/libvorbisidec-1.2.1/res012.c
external/libvorbisidec-1.2.1/sharedbook.c
external/libvorbisidec-1.2.1/synthesis.c
external/libvorbisidec-1.2.1/vorbisfile.c
external/libvorbisidec-1.2.1/window.c
)

target_include_directories(vorbisidec PUBLIC external/libvorbisidec-1.2.1/)

target_link_libraries(vorbisidec ogg)

add_library(SDL_mixer 
mixer.c
music_cmd.c
music_ogg.c
music.c
wavestream.c
effect_position.c
effect_stereoreverse.c
effects_internal.c
load_aiff.c
load_voc.c
load_ogg.c
dynamic_mp3.c
dynamic_ogg.c
dynamic_flac.c
dynamic_fluidsynth.c
fluidsynth.c
load_mp3.c
)

target_include_directories(SDL_mixer PUBLIC ./)

target_compile_definitions(SDL_mixer PRIVATE -DWAV_MUSIC  -DOGG_MUSIC -DOGG_USE_TREMOR -DOGG_HEADER=<ivorbisfile.h> -DHAVE_STDINT_H -DHAVE_SETENV -DHAVE_SINF)

target_link_libraries(SDL_mixer vorbisidec SDL2)
