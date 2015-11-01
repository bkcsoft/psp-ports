LDFLAGS="-L$(psp-config --pspsdk-path)/lib" LIBS="-lc -lpspuser"

bzip2:
	$(MAKE) -C bzip2
	$(MAKE) -C bzip2 install

freetype:
	cd freetype && ./autogen.sh
	cd freetype && $(LDFLAGS) ./configure --host psp --prefix=$(psp-config --psp-prefix)
	$(MAKE) -C freetype
	$(MAKE) -C freetype install

jpeg:
	$(MAKE) -C jpeg
	$(MAKE) -C jpeg install

libbulletml:
	$(MAKE) -C libbulletml
	$(MAKE) -C libbulletml install

libmad:
	$(MAKE) -C libmad
	$(MAKE) -C libmad install

libogg:
	cd libogg && $(LDFLAGS) ./autogen.sh --host=psp --prefix=$(psp-config -psp-prefix)
	$(MAKE) -C libogg
	$(MAKE) -C libogg install

libpng: zlib
	$(MAKE) -C libpng
	$(MAKE) -C libpng install

libTremor:
	cd libTremor && $(LDFLAGS) ./autogen.sh --host psp --prefix=$(psp-config --psp-prefix)
	$(MAKE) -C libTremor
	$(MAKE) -C libTremor install

libvorbis: libogg
	cd libogg && $(LDFLAGS) ./autogen.sh --host psp --prefix=$(psp-config --psp-prefix)
	$(MAKE) -C libTremor
	$(MAKE) -C libTremor install

lua:
	$(MAKE) -C libTremor -f Makefile.psp
	$(MAKE) -C libTremor -f Makefile.psp install

SDL_gfx: SDL
	cd SDL_gfx && ./autogen.sh
	cd SDL_gfx && $(LDFLAGS) ./configure --host psp --with-sdl-prefix=$(psp-config --psp-prefix) --prefix=$(psp-config --psp-prefix) --disable-mmx --disable-shared
	$(MAKE) -C SDL_gfx
	$(MAKE) -C SDL_gfx install

SDL_mixer: SDL libTremor
	cd SDL_mixer && ./autogen.sh
	cd SDL_mixer && $(LDFLAGS) ./configure --host psp --with-sdl-prefix=$(psp-config --psp-prefix) \
		--disable-music-mp3 --prefix=$(psp-config --psp-prefix) \
		--disable-music-libmikmod --enable-music-mod --disable-music-ogg-tremor
	$(MAKE) -C SDL_mixer
	$(MAKE) -C SDL_mixer install

SDL:
	cd SDL && ./autogen.sh
	cd SDL && $(LDFLAGS) ./configure --host psp --prefix=$(psp-config --psp-prefix)
	$(MAKE) -C SDL
	$(MAKE) -C SDL install

SDL_ttf: freetype SDL
	cd SDL_ttf && ./autogen.sh
	cd SDL_ttf && $(LDFLAGS) ./configure --host psp --with-sdl-prefix=$(psp-config --psp-prefix) \
		--with-freetype-prefix=$(psp-config --psp-prefix) \
		--without-x --prefix=$(psp-config --psp-prefix)
	$(MAKE) -C SDL_ttf
	$(MAKE) -C SDL_ttf install

sqlite:
	cd sqlite && $(LDFLAGS) ./configure --host=psp --disable-readline --disable-tcl \
		--prefix=$(psp-config --psp-prefix)
	$(MAKE) -C sqlite
	$(MAKE) -C sqlite install

zlib:
	$(MAKE) -C zlib
	$(MAKE) -C zlib install

zziplib:
	cd zziplib && $(LDFLAGS) ./configure --host=psp --prefix=$(psp-config --psp-prefix)
	$(MAKE) -C zziplib
	$(MAKE) -C zziplib install

all: bzip2 freetype jpeg libbulletml libmad libogg libpng libTremor libvorbis lua SDL_gfx SDL_mixer SDL SDL_ttf sqlite zlib zziplib

clean:
	$(MAKE) -C bzip2 clean
	$(MAKE) -C freetype clean
	$(MAKE) -C jpeg clean
	$(MAKE) -C libbulletml clean
	$(MAKE) -C libmad clean
	$(MAKE) -C libogg clean
	$(MAKE) -C libpng clean
	$(MAKE) -C libTremor clean
	$(MAKE) -C libvorbis clean
	$(MAKE) -C lua clean
	$(MAKE) -C SDL_gfx clean
	$(MAKE) -C SDL_mixer clean
	$(MAKE) -C SDL clean
	$(MAKE) -C SDL_ttf clean
	$(MAKE) -C sqlite clean
	$(MAKE) -C zlib clean
	$(MAKE) -C zziplib clean

