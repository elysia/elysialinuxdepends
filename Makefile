all: protobuf sdl2

boost:
	tar -jxf boost_1_39_0.tar.bz2
	cd boost_1_39_0&&CXXFLAGS="-fPIC -O2" ./bootstrap.sh --without-icu --with-libraries=system,program_options,thread,filesystem,regex,date_time --prefix=$(PWD)/installed-boost && CXXFLAGS="-fPIC -O2" ./bjam cxxflags=-fPIC 
#install --prefix=$(PWD)/installed-boost 
	cd boost_1_39_0 && mkdir -p $(PWD)/installed-boost/lib && (./bjam cxxflags=-fPIC install --prefix=$(PWD)/installed-boost || find . -name "*.a" -exec cp {} $(PWD)/installed-boost/lib/ \;)

protobuf:
	tar -zxf protobuf-2.6.0.tar.gz
	cd protobuf-2.6.0 && ./configure --prefix=$(PWD)/installed-protobufs/ && make -j2 && make install

sdl2:
	#tar -zxf SDL2-2.0.3.tar.gz
	#cd SDL2-2.0.3 && ./configure --prefix=$(PWD)/../polarity/libs/libsdl/ && ((make -j2 && make install ) || (sed -i '' -e 's/\/usr\/X[^ ]*//g' build/*.d && sed -i '' -e 's/return SDL_REVISION_NUMBER/return 0x203/' src/SDL.c && make -j2 && make install)) && cd ..
	tar -zxf SDL2_gfx-1.0.1.tar.gz
	cd SDL2_gfx-1.0.1 && ((bash configure SHELL=/bin/bash --prefix=$(PWD)/../polarity/libs/libsdl/ && make -j2 ) || (./autogen.sh && bash configure SHELL=/bin/bash --prefix=$(PWD)/../polarity/libs/libsdl/ && make -j2 ) ) && make install && cd ..
	tar -zxf SDL2_mixer-2.0.0.tar.gz
	cd SDL2_mixer-2.0.0 && ((bash configure SHELL=/bin/bash --prefix=$(PWD)/../polarity/libs/libsdl/ && make -j2 ) || (./autogen.sh && bash configure SHELL=/bin/bash --prefix=$(PWD)/../polarity/libs/libsdl/ && make -j2 ) ) && make install && cd ..
	tar -zxf freetype-2.5.5.tar.gz
	cd freetype-2.5.5 && bash configure SHELL=/bin/bash --prefix=$(PWD)/../polarity/libs/libsdl/ && make -j2 && make install && cd ..
	tar -zxf SDL2_ttf-2.0.12.tar.gz
	cd SDL2_ttf-2.0.12 && ((bash configure SHELL=/bin/bash --prefix=$(PWD)/../polarity/libs/libsdl/ && make -j2 ) || (./autogen.sh && bash configure SHELL=/bin/bash --prefix=$(PWD)/../polarity/libs/libsdl/ && make -j2 ) ) && make install && cd ..
