FROM debian:bookworm

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
            build-essential \
            cdbs \
            devscripts \
            equivs \
            fakeroot

COPY ./debian-forky.sources /etc/apt/sources.list.d/debian-forky.sources

RUN export FORKY_KEY="04B5 4C3C DCA7 9751 B16B C6B5 2256 29DF 75B1 88BD" \
 && gpg --keyserver keyserver.ubuntu.com --recv-keys "$FORKY_KEY" \
 && gpg --output /usr/share/keyrings/debian-forky-keyring.gpg --export "$FORKY_KEY" \
 && apt-get update

RUN apt source openvswitch/forky \
 && cd openvswitch-*/ \
 && mk-build-deps -ir -t "apt-get -o Debug::pkgProblemResolver=yes -y --no-install-recommends"

COPY ./add-noviflow-experimenter-actions.patch /tmp/add-noviflow-experimenter-actions.patch

RUN cd openvswitch-*/ \
 && patch -p2 < /tmp/add-noviflow-experimenter-actions.patch \
 && DEB_BUILD_OPTIONS='nocheck' debuild -b -uc -us

RUN tar -czf ovs-ext-novi.tgz *.deb
