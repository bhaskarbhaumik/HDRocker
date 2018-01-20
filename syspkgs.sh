#!/bin/bash

yum -y update || errexit
RUN     yum -y install  epel-release tar psmisc bash-completion gcc gcc-c++ gcc-gfortran make ccache file git git-extras git-tools \
                        openssh openssh-clients openssl openssl-devel libxml2-devel rsync zip unzip \
                        udunits2-devel proj-devel libX11-devel geos-devel mesa-libOSMesa-devel libpng-devel mesa-libGLU-devel \
                        freetype-devel gdal-devel proj-epsg unixODBC-devel which sudo ksh \
                        python mysql-connector-java mysql-connector-odbc mysql-connector-python mysql-utilities
# Install some additional fonts that can be used in R plots
RUN     yum -y install  abattis-cantarell-fonts adobe-source-code-pro-fonts dejavu-fonts-common dejavu-sans-fonts dejavu-sans-fonts \
                        dejavu-sans-mono-fonts dejavu-serif-fonts fontawesome-fonts ghostscript-fonts gnu-free-fonts-common \
                        gnu-free-mono-fonts gnu-free-sans-fonts gnu-free-serif-fonts lato-fonts open-sans-fonts \
                        roboto-fontface-common roboto-fontface-fonts xorg-x11-font-utils xorg-x11-server-utils xorg-x11-fonts*
# Install MS Core TrueType fonts
RUN     [ -f msttcore-fonts-installer-2.6-1.noarch.rpm ] && yum -y --nogpgcheck localinstall msttcore-fonts-installer-2.6-1.noarch.rpm



exit 0
