# OpenVSwitch builder with Noviflow Experimenter Actions

## Overview

This repo contains an modified version of OpenVSwitch to support OpenFlow vendor extensions to the protocol, specially the extensions by Noviflow Inc. (https://noviflow.com/noviswitch/), and some Experimenter Actions from Noviflow to create flows with Inband Network Telemetry (INT) capabilities.

## Getting started

**Note**: check the releases page to download binary pre-built packages.

Use the following commands to build (choose your debian version according to the dirs):
```
cd deb13-trixie
docker build -t ovs-ext-novi --pull .
docker create --name ovs-ext-novi ovs-ext-novi
docker cp ovs-ext-novi:/ovs-ext-novi.tgz .
docker rm -f ovs-ext-novi
```

As a result you will have a tarball on the current directory named `ovs-ext-novi.tgz` with the Debian packages with modified OpenVSwitch to support Noviflow Experimenter Actions.

To clean up:
```
docker image rm ovs-ext-novi
docker builder prune -a
docker image prune -a
```

## Supported Features

The following OFPAT\_EXPERIMENTER custom action types are supported:
```
    # Push INT
    NOVI_ACTION_PUSH_INT = 12

    # Modify INT
    NOVI_ACTION_ADD_INT_METADATA = 13

    # Pop INT
    NOVI_ACTION_POP_INT = 14

    # Send INT report
    NOVI_ACTION_SEND_REPORT = 15
```

## References

- Build process was based on https://github.com/tsaarni/docker-deb-builder
- OpenVSwitch documentation for adding vendor extension (experimenter actions): https://docs.openvswitch.org/en/latest/topics/ovs-extensions/
