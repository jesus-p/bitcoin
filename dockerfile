FROM alpine
RUN apk update && apk add git \ 
                          make \
                          file \
                          autoconf \
                          automake \ 
                          build-base \
                          libtool \
                          db-c++ \
                          db-dev \
                          boost-system \
                          boost-program_options \
                          boost-filesystem \ 
                          boost-dev \ 
                          libressl-dev \ 
                          libevent-dev                           
RUN git clone https://github.com/jesus-p/bitcoin
RUN (cd bitcoin  && ./autogen.sh && \
                      ./configure.ac --disable-tests \
                      --disable-bench --disable-static  \
                      --without-gui --disable-zmq \ 
                      --with-incompatible-bdb \
                      CFLAGS='-w' CXXFLAGS='-w' && \
                      make -j 4 && \
                      strip src/bitcoind && \
                      strip src/bitcoin-cli && \
                      strip src/bitcoin-tx && \
                      make install )
