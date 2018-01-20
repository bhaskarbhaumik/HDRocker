#R.profile.common.functions.sh
# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
# [   C o m m o n   R   S h e l l   E n v i r o n m e n t   ]
# [                 V A R I A B L E S                       ]
# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
#
# Define Environment Variables
#
# Set Initial POSIX Path & Libraries
_setPath "/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"
_setLibs "/usr/local/lib64:/usr/lib64:/lib64:/usr/local/lib:/usr/lib:/lib"

# Add User's Path & Libraries
_addPath "${HOME}/bin"
_addLibs "${HOME}/lib"
_addLibs "${HOME}/lib64"

# Set Java Environment
export JAVA_VER=1.8.0_111
export JAVA_HOME=/usr/java/jdk${JAVA_VER}
export JDK_HOME=${JAVA_HOME}
export JRE_HOME=${JAVA_HOME}/jre
_addPath "${JAVA_HOME}/bin"
_addLibs "${JAVA_HOME}/jre/lib/amd64/server"
_addLibs "${JAVA_HOME}/jre/lib/amd64"

# Set DB2 Environment
export INSTANCE=db2con01
export INSTHOME=/opt/hd/db/db2/instance/${INSTANCE}
export DB2_HOME=${INSTHOME}/sqllib
export DB2LIB=${DB2_HOME}/lib
_addPath "/opt/hd/db/db2/bin"
_addPath "${INSTHOME}/bin"
_addPath "${DB2_HOME}/bin"
_addPath "${DB2_HOME}/adm"
_addPath "${DB2_HOME}/misc"
_addPath "${DB2_HOME}/db2tss/bin"
_addLibs "${DB2_HOME}/lib64"
_addLibs "${DB2_HOME}/lib64/gskit"

# Set Teradata TTU Environment
export TTU_VER=15.10
export TTU_PATH=/opt/teradata/client/${TTU_VER}
_addPath "${TTU_PATH}/bin"
_addLibs "${TTU_PATH}/lib"
_addLibs "${TTU_PATH}/lib64"

# Set Microsoft ODBC for SQL Server Environment
export MSODBC_VER=13.1.4.0-1
export MSODBC_HOME=/opt/microsoft/msodbcsql
export MSTOOLS_HOME=/opt/mssql-tools
_addPath "${MSTOOLS_HOME}/bin"
_addLibs "${MSODBC_HOME}/lib64"

# Set Hortonworks HDP Hadoop/Hive Environment
export HDP_VER=2.2.4.5-1
export HDP_BASE=/usr/hdp/${HDP_VER}
export HADOOP_HOME=${HDP_BASE}/hadoop
export HADOOP_CMD=${HADOOP_HOME}/bin/hadoop
export HADOOP_CONF=${HADOOP_HOME}/conf
export HADOOP_CONF_DIR=${HADOOP_CONF}
export HIVE_HOME=${HDP_BASE}/hive
_addPath "${HIVE_HOME}/bin"
_addPath "${HADOOP_HOME}/bin"
_addLibs "${HADOOP_HOME}/lib/native"

# Set R/RStudio Environment
export RBASE=/opt/isv/R-base
#export RHOME=${RBASE}/R-${R_VER}/lib64/R
export RHOME=${RBASE}/microsoft-r/${R_VER}/lib64/R
export R_HOME=${RHOME}
export R_CONTRIB=${RBASE}/contrib
export PKG_CONFIG_PATH=${R_CONTRIB}/lib/pkgconfig
export R_HOST=`hostname 2>/dev/null | cut -d. -f1`

_addPath "${R_CONTRIB}/bin"
_addPath "${R_HOME}/bin"
_addLibs "${R_CONTRIB}/lib"
_addLibs "${R_CONTRIB}/lib64"
_addLibs "${R_HOME}/modules"
_addLibs "${R_HOME}/lib"

# Set Other Misc Environment
export ODBCINSTINI=${R_CONTRIB}/etc/odbcinst.ini
export ODBCINI=${R_CONTRIB}/etc/odbc.ini

# Set CLASSPATH for Java
export CLASSPATH=`cat ${R_CONTRIB}/etc/profile.d/R-${R_VER}.classpath`

# Set TCL/TK Environment
export TCL_VER=8.6
export TK_VER=8.6
export TCL_LIBRARY=${R_HOME}/share/tcl${TCL_VER}
export TK_LIBRARY=${R_HOME}/share/tk${TK_VER}

#
# End of file
