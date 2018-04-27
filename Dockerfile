FROM jfloff/alpine-python:latest

RUN apk --no-cache --update add libpng-dev build-base cmake boost-dev git openssh nodejs nodejs-npm         && \
  sed -i -E -e 's/include <sys\/poll.h>/include <poll.h>/' /usr/include/boost/asio/detail/socket_types.hpp  && \
  git clone --depth 1 --recursive -b release https://github.com/ethereum/solidity                           && \
  cd /solidity && cmake -DCMAKE_BUILD_TYPE=Release -DTESTS=0 -DSTATIC_LINKING=1                             && \
  cd /solidity && make solc && install -s  solc/solc /usr/bin                                               && \
  cd / && rm -rf solidity                                                                                   && \
  python3 -m venv ~/env && source ~/env/bin/activate && pip3 install solidity-flattener
