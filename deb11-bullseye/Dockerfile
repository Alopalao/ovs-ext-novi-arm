FROM debian:bullseye AS builder

RUN echo "deb-src http://deb.debian.org/debian/ bullseye main" | tee -a /etc/apt/sources.list \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
            build-essential \
            cdbs \
            devscripts \
            equivs \
            fakeroot

RUN apt source openvswitch \
 && cd /openvswitch-*/ \
 && mk-build-deps -ir -t "apt-get -o Debug::pkgProblemResolver=yes -y --no-install-recommends"

COPY ./add-noviflow-experimenter-actions.patch /tmp/add-noviflow-experimenter-actions.patch

RUN cd openvswitch-*/ \
 && patch -p2 < /tmp/add-noviflow-experimenter-actions.patch \
 && env DEBEMAIL="Italo Valcy <italo@amlight.net>" dch --nmu "Add support for Noviflow Experimenter actions" \
 && env DEB_BUILD_OPTIONS='nocheck' debuild -b -uc -us

RUN tar -czf ovs-ext-novi.tgz *.deb
