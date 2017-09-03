FROM ubuntu:16.04

RUN apt-key update && \
    sh -c 'curl -sL https://deb.nodesource.com/setup_6.x | bash -' && \
    apt-get update && \
    apt-get install -y curl git unzip bzip2 build-essential gcc-multilib libssl-dev srecord openocd pkg-config nodejs s3cmd python && \
    apt-get clean all

# NRF51 SDK v14
ADD https://developer.nordicsemi.com/nRF5_SDK/nRF5_SDK_v14.x.x/nRF5_SDK_14.0.0_3bcc1f7.zip /nRF5_SDK_14.0.0_3bcc1f7.zip
RUN mkdir -p /nrf51/nRF51_SDK_14.0.0 && unzip -q ../../nRF5_SDK_14.0.0_3bcc1f7.zip -d /nrf51/nRF51_SDK_14.0.0

# GCC ARM toolchain 2016q3
RUN curl -L -o /opt/gcc-arm-none-eabi-5.tar.bz2 https://launchpad.net/gcc-arm-embedded/5.0/5-2016-q3-update/+download/gcc-arm-none-eabi-5_4-2016q3-20160926-linux.tar.bz2 2>/dev/null && \
    tar xjf /opt/gcc-arm-none-eabi-5.tar.bz2 -C /opt && \
    rm /opt/gcc-arm-none-eabi-5.tar.bz2 && \
    ln -s /opt/gcc-arm-none-eabi-5_4-2016q3 /opt/gcc-arm-none-eabi-5
ENV PATH="${PATH}:/opt/gcc-arm-none-eabi-5/bin"
