#!/bin/bash

[ -f env.sh ] && . ./env.sh

# Update CentOS base packages and install some additional but required packages
task="Update CentOS base system packages"; msg "${task}"
yum -y update
status $? "${task}"

# Install some additional but required packages
task="Install few required additional system packages"; msg "${task}"
yum -y install  e2fsprogs e2fsprogs-libs epel-release tar psmisc bash-completion gcc gcc-c++ gcc-gfortran make ccache file git git-extras git-tools \
                openssh openssh-clients openssl openssl-devel libss libxml2-devel rsync zip unzip \
                udunits2-devel proj-devel libX11-devel geos-devel mesa-libOSMesa-devel libpng-devel mesa-libGLU-devel \
                freetype-devel gdal-devel proj-epsg unixODBC-devel which sudo ksh \
                python mysql-connector-java mysql-connector-odbc mysql-connector-python mysql-utilities
status $? "${task}"

# Install some additional fonts that can be used in R plots
task="Install additional fonts"; msg "${task}"
yum -y install  abattis-cantarell-fonts adobe-source-code-pro-fonts dejavu-fonts-common dejavu-sans-fonts dejavu-sans-fonts \
                dejavu-sans-mono-fonts dejavu-serif-fonts fontawesome-fonts ghostscript-fonts gnu-free-fonts-common \
                gnu-free-mono-fonts gnu-free-sans-fonts gnu-free-serif-fonts lato-fonts open-sans-fonts \
                roboto-fontface-common roboto-fontface-fonts xorg-x11-font-utils xorg-x11-server-utils xorg-x11-fonts*
status $? "${task}"

# Install MS Core TrueType fonts
task="Install Microsoft core TrueType fonts"; msg "${task}"
if [ ! -f msttcore-fonts-installer-2.6-1.noarch.rpm ]; then
    curl -sLk 'https://sourceforge.net/projects/mscorefonts2/files/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm/download' -o msttcore-fonts-installer-2.6-1.noarch.rpm || \
    gitpull msttcore-fonts-installer-2.6-1.noarch.rpm
    status $? "Downloading Microsoft core TrueType fonts"
fi
if [ -f msttcore-fonts-installer-2.6-1.noarch.rpm ]; then
    yum -y --nogpgcheck localinstall msttcore-fonts-installer-2.6-1.noarch.rpm
    status $? "${task}"
    rm -f msttcore-fonts-installer-2.6-1.noarch.rpm
fi

# Install Oracle JDK 1.8.151
task="Install Oracle JDK 1.8.162"; msg "${task}"
java_orig=`realpath -eq /usr/bin/java 2>/dev/null`
if [ ! -f jdk-8u162-linux-x64.rpm ]; then
    curl -sLOk -b "oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u162-b12/0da788060d494f5095bf8624735fa2f1/jdk-8u162-linux-x64.rpm" || \
    gitpull jdk-8u162-linux-x64.rpm
    status $? "Downloading Oracle JDK 1.8.162"
fi
if [ -f jdk-8u162-linux-x64.rpm ]; then
    yum -y --nogpgcheck localinstall jdk-8u162-linux-x64.rpm
    status $? "${task}"
    rm -f jdk-8u162-linux-x64.rpm
fi
 alternatives --remove java ${java_orig}

# Install Microsoft R Open (MRO)
task="Install Microsoft R Open 3.4.2"; msg "${task}"
if [ ! -f microsoft-r-open-3.4.2.tar.gz ]; then
    curl -sLOk "https://mran.blob.core.windows.net/install/mro/3.4.2/microsoft-r-open-3.4.2.tar.gz" || \
    gitpull microsoft-r-open-3.4.2.tar.gz
    status $? "Downloading Microsoft R Open 3.4.2"
fi
if [ -f microsoft-r-open-3.4.2.tar.gz ]; then
    tar xvfpz microsoft-r-open-3.4.2.tar.gz
    if grep -qi GenuineIntel /proc/cpuinfo; then
        microsoft-r-open/install.sh -au
        yum -y install RdRand # Install Intel CPU based random number generators
    else
        microsoft-r-open/install.sh -u
    fi
    for d in lib64/R/lib lib64/R/modules stage/Linux/bin/x64; do
        echo /opt/microsoft/ropen/3.4.2/$d
    done >/etc/ld.so.conf.d/microsoft-r-open-3.4.2-x86_64.conf
    status $? "${task}"
    rm -rf microsoft-r-open*
fi

# Install R Studio 1.1.383
task="Install R Studio 1.1.383"; msg "${task}"
if [ ! -f rstudio-server-rhel-1.1.383-x86_64.rpm ]; then
    curl -sLOk "https://download2.rstudio.org/rstudio-server-rhel-1.1.383-x86_64.rpm" || \
    gitpull rstudio-server-rhel-1.1.383-x86_64.rpm
    status $? "Downloading R Studio 1.1.383"
fi
if [ -f rstudio-server-rhel-1.1.383-x86_64.rpm ]; then
    yum -y --nogpgcheck localinstall rstudio-server-rhel-1.1.383-x86_64.rpm
    status $? "${task}"
    rm -f rstudio-server-rhel-1.1.383-x86_64.rpm
fi

# Install Shiny Server 1.5.6.875
task="Install Shiny Server 1.5.6.875"; msg "${task}"
if [ ! -f shiny-server-1.5.6.875-rh5-x86_64.rpm ]; then
    curl -sLOk "https://download3.rstudio.org/centos5.9/x86_64/shiny-server-1.5.6.875-rh5-x86_64.rpm" || \
    gitpull shiny-server-1.5.6.875-rh5-x86_64.rpm
    status $? "Downloading Shiny Server 1.5.6.875"
fi
if [ -f shiny-server-1.5.6.875-rh5-x86_64.rpm ]; then
    yum -y --nogpgcheck localinstall shiny-server-1.5.6.875-rh5-x86_64.rpm
    status $? "${task}"
    rm -f shiny-server-1.5.6.875-rh5-x86_64.rpm
fi

# I n s t a l l   O D B C   d r i v e r s   f o r   c o n n e c t i v i t y

# Install Microsoft ODBC drivers for Microsoft SQL Server
task="Install latest Microsoft SQL Server ODBC drivers"; msg "${task}"
curl -sLk "https://packages.microsoft.com/config/rhel/7/prod.repo" -o /etc/yum.repos.d/mssql-release.repo
ACCEPT_EULA=Y yum -y --nogpgcheck install msodbcsql mssql-tools; rc=$?
if [ $rc ]; then
    curl -sLOk "https://packages.microsoft.com/rhel/7/prod/msodbcsql-13.1.9.2-1.x86_64.rpm" && \
    curl -sLOk "https://packages.microsoft.com/rhel/7/prod/mssql-tools-14.0.6.0-1.x86_64.rpm" && \
    ACCEPT_EULA=Y yum -y --nogpgcheck localinstall msodbcsql-13.1.9.2-1.x86_64.rpm mssql-tools-14.0.6.0-1.x86_64.rpm; rc=$?
    [ $rc ] || rm -f msodbcsql-*.rpm mssql-tools-*.rpm
fi
status $rc "${task}"
[ -d /opt/microsoft/msodbcsql/lib64 ] && echo /opt/microsoft/msodbcsql/lib64 >/etc/ld.so.conf.d/msodbcsql-x86_64.conf

# Install Teradata Tools and Utilities (TTU) 16.10.05.00
task="Install Teradata Tools and Utilities (TTU) 16.10.05.00"; msg "${task}"
[ -f TeradataToolsAndUtilitiesBase__linux_indep.16.10.05.00.tar.gz ] || gitpull TeradataToolsAndUtilitiesBase__linux_indep.16.10.05.00.tar.gz
[ -f TeradataToolsAndUtilitiesBase__linux_indep.16.10.05.00.tar.gz ] && tar xvfpz TeradataToolsAndUtilitiesBase__linux_indep.16.10.05.00.tar.gz
[ -e TeradataToolsAndUtilitiesBase/setup.bat ] && chmod +x TeradataToolsAndUtilitiesBase/setup.bat
[ -e TeradataToolsAndUtilitiesBase/.setup.sh ] && chmod +x TeradataToolsAndUtilitiesBase/.setup.sh
TeradataToolsAndUtilitiesBase/.setup.sh w -installdir=/opt
[ -f TeradataToolsAndUtilitiesBase/ttulistproducts_unix.sh ] && chmod +x TeradataToolsAndUtilitiesBase/ttulistproducts_unix.sh && ./TeradataToolsAndUtilitiesBase/ttulistproducts_unix.sh
echo /opt/teradata/client/16.10/lib64 >/etc/ld.so.conf.d/teradata-client-16.10-x86_64.conf
rm -rf TeradataToolsAndUtilitiesBase*
status $? "${task}"

# Install Simba Google BigQuery ODBC drivers
task="Install Simba Google BigQuery ODBC driver 2.1.6.1006"; msg "${task}"
[ -f SimbaODBCDriverforGoogleBigQuery64-2.1.6.1006.tar.gz ] || curl -sLOk "https://storage.googleapis.com/simba-bq-release/odbc/SimbaODBCDriverforGoogleBigQuery64-2.1.6.1006.tar.gz" || gitpull SimbaODBCDriverforGoogleBigQuery64-2.1.6.1006.tar.gz
[ -f SimbaODBCDriverforGoogleBigQuery64-2.1.6.1006.tar.gz ] && tar -xvpz -f SimbaODBCDriverforGoogleBigQuery64-2.1.6.1006.tar.gz --no-same-owner --owner root --group root -C /opt
echo /opt/simba/googlebigqueryodbc/lib/64 >/etc/ld.so.conf.d/simba-googlebigquery-2.1.6-x86_64.conf
rm -f SimbaODBCDriverforGoogleBigQuery64-2.1.6.1006.tar.gz
status $? "${task}"

# Install Google CloudSQL proxy client
task="Install Google CloudSQL proxy client"; msg "${task}"
curl -sLk "https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64" -o /usr/local/bin/cloud_sql_proxy && chmod +x /usr/local/bin/cloud_sql_proxy
status $? "${task}"

# Install Oracle Instant Client 12.2 ODBC drivers and tools
for _pkg in oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm oracle-instantclient12.2-jdbc-12.2.0.1.0-1.x86_64.rpm oracle-instantclient12.2-odbc-12.2.0.1.0-2.x86_64.rpm oracle-instantclient12.2-sqlplus-12.2.0.1.0-1.x86_64.rpm oracle-instantclient12.2-tools-12.2.0.1.0-1.x86_64.rpm; do
    task="Install ${_pkg}"; msg "${task}"
    if [ ! -f ${_pkg} ]; then
        curl -sLOk -b "oraclelicense=accept-ic_linuxx8664-cookie" "http://download.oracle.com/otn/linux/instantclient/122010/${_pkg}" || gitpull ${_pkg}
        status $? "Downloading ${_pkg}"
    fi
    if [ -f ${_pkg} ]; then
        yum -y --nogpgcheck localinstall ${_pkg}
        status $? "${task}"
        rm -f ${_pkg}
    fi
    status $? "${task}"
done
echo /usr/lib/oracle/12.2/client64/lib >/etc/ld.so.conf.d/oracle-instantclient12.2-x86_64.conf

# Install THD R base filesystem dirs and files
[ -f hd-r-filesystem.tar.gz ] && tar -xvpz -f hd-r-filesystem.tar.gz --no-same-owner --owner root --group root -C /opt

# Install all JDBC drivers [IBM DB2, Microsoft SQL Server, MySQL, Oracle, SAP HANA, Teradata]
[ -f jdbc-drivers.tar.gz ] && tar -xvpz -f jdbc-drivers.tar.gz --no-same-owner --owner root --group root -C /opt/hd/r/contrib/jdbc/lib

# Rebuild library cache
ldconfig

exit 0
