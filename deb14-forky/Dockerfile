FROM debian:forky

RUN sed -i 's/Types: deb/Types: deb deb-src/g' /etc/apt/sources.list.d/debian.sources \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
            build-essential \
            cdbs \
            devscripts \
            equivs \
            fakeroot

RUN apt source openvswitch \
 && cd openvswitch-*/ \
 && mk-build-deps -ir -t "apt-get -o Debug::pkgProblemResolver=yes -y --no-install-recommends"

COPY ./add-noviflow-experimenter-actions.patch /tmp/add-noviflow-experimenter-actions.patch

RUN cd openvswitch-*/ \
 && patch -p2 < /tmp/add-noviflow-experimenter-actions.patch \
 && DEB_BUILD_OPTIONS='nocheck' debuild -b -uc -us

RUN tar -czf ovs-ext-novi.tgz *.deb
