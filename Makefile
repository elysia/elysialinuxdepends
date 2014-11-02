all: protobuf boost

boost:
	tar -jxf boost_1_39_0.tar.bz2
	cd boost_1_39_0&&CXXFLAGS="-fPIC -O2" ./bootstrap.sh --without-icu --with-libraries=system,program_options,thread,filesystem,regex,date_time --prefix=$(PWD)/installed-boost && CXXFLAGS="-fPIC -O2" ./bjam cxxflags=-fPIC 
#install --prefix=$(PWD)/installed-boost 
	cd boost_1_39_0 && mkdir -p $(PWD)/installed-boost/lib && (./bjam cxxflags=-fPIC install --prefix=$(PWD)/installed-boost || find . -name "*.a" -exec cp {} $(PWD)/installed-boost/lib/ \;)
protobuf:
	tar -zxf protobuf-2.6.0.tar.gz
	cd protobuf-2.6.0 && ./configure --prefix=$(PWD)/installed-protobufs/ && make -j2 && make install
