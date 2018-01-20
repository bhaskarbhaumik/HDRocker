#R.env.common.variables.R
# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
# [   C o m m o n   R   E n v i r o n m e n t   ]
# [             V A R I A B L E S               ]
# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
#
# Define Environment Variables
#

if(!exists('ThdREnv.REnvInitialized')) ThdREnv.REnvInitialized <<- FALSE;

if(!ThdREnv.REnvInitialized) {
    # Set Initial POSIX Path & Libraries
    ThdREnv.setPath("/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin")
    ThdREnv.setLibs("/usr/local/lib64:/usr/lib64:/lib64:/usr/local/lib:/usr/lib:/lib")
    
    # Add User's Path & Libraries
    ThdREnv.HOME <<- Sys.getenv("HOME")
    ThdREnv.addPath(paste0(ThdREnv.HOME, "/bin"))
    ThdREnv.addLibs(paste0(ThdREnv.HOME, "/lib"))
    ThdREnv.addLibs(paste0(ThdREnv.HOME, "/lib64"))
    
    # Set Java Environment
    ThdREnv.JAVA_VER <<- '1.8.0_111'; Sys.setenv(JAVA_VER=ThdREnv.JAVA_VER)
    ThdREnv.JAVA_HOME <<- paste0('/usr/java/jdk', ThdREnv.JAVA_VER); Sys.setenv(JAVA_HOME=ThdREnv.JAVA_HOME)
    ThdREnv.JDK_HOME <<- ThdREnv.JAVA_HOME; Sys.setenv(JDK_HOME=ThdREnv.JDK_HOME)
    ThdREnv.JRE_HOME <<- paste0(ThdREnv.JAVA_HOME, '/jre'); Sys.setenv(JRE_HOME=ThdREnv.JRE_HOME)
    
    ThdREnv.addPath(paste0(ThdREnv.JAVA_HOME, '/bin'))
    ThdREnv.addLibs(paste0(ThdREnv.JRE_HOME, "/lib/amd64/server"))
    ThdREnv.addLibs(paste0(ThdREnv.JRE_HOME, "/lib/amd64"))
    
    # Set DB2 Environment
    ThdREnv.INSTANCE <<- 'db2con01'; Sys.setenv(INSTANCE=ThdREnv.INSTANCE)
    ThdREnv.INSTHOME <<- paste0('/opt/hd/db/db2/instance/', ThdREnv.INSTANCE); Sys.setenv(INSTHOME=ThdREnv.INSTHOME)
    ThdREnv.DB2_HOME <<- paste0(ThdREnv.INSTHOME, '/sqllib'); Sys.setenv(DB2_HOME=ThdREnv.DB2_HOME)
    ThdREnv.DB2LIB <<- paste0(ThdREnv.DB2_HOME, '/lib'); Sys.setenv(DB2LIB=ThdREnv.DB2LIB)

    ThdREnv.addPath('/opt/hd/db/db2/bin')
    ThdREnv.addPath(paste0(ThdREnv.INSTHOME, '/bin'))
    ThdREnv.addPath(paste0(ThdREnv.DB2_HOME, '/bin'))
    ThdREnv.addPath(paste0(ThdREnv.DB2_HOME, '/adm'))
    ThdREnv.addPath(paste0(ThdREnv.DB2_HOME, '/misc'))
    ThdREnv.addPath(paste0(ThdREnv.DB2_HOME, '/db2tss/bin'))

    ThdREnv.addLibs(paste0(ThdREnv.DB2_HOME, "/lib64"))
    ThdREnv.addLibs(paste0(ThdREnv.DB2_HOME, "/lib64/gskit"))

    # Set Teradata TTU Environment
    ThdREnv.TTU_VER <<- '15.10'; Sys.setenv(TTU_VER=ThdREnv.TTU_VER)
    ThdREnv.TTU_PATH <<- paste0('/opt/teradata/client/', ThdREnv.TTU_VER); Sys.setenv(TTU_PATH=ThdREnv.TTU_PATH)
    
    ThdREnv.addPath(paste0(ThdREnv.TTU_PATH, '/bin'))
    ThdREnv.addLibs(paste0(ThdREnv.TTU_PATH, "/lib"))
    ThdREnv.addLibs(paste0(ThdREnv.TTU_PATH, "/lib64"))
    
    # Set Microsoft ODBC for SQL Server Environment
    ThdREnv.MSODBC_VER <<- '13.1.4.0-1'; Sys.setenv(MSODBC_VER=ThdREnv.MSODBC_VER)
    ThdREnv.MSODBC_HOME <<- '/opt/microsoft/msodbcsql'; Sys.setenv(MSODBC_HOME=ThdREnv.MSODBC_HOME)
    ThdREnv.MSTOOLS_HOME <<- '/opt/mssql-tools'; Sys.setenv(MSTOOLS_HOME=ThdREnv.MSTOOLS_HOME)
    
    ThdREnv.addPath(paste0(ThdREnv.MSTOOLS_HOME, '/bin'))
    ThdREnv.addLibs(paste0(ThdREnv.MSODBC_HOME, "/lib64"))
    
    # Set Hortonworks HDP Hadoop/Hive Environment
    ThdREnv.HDP_VER <<- '2.2.4.5-1'; Sys.setenv(HDP_VER=ThdREnv.HDP_VER)
    ThdREnv.HDP_BASE <<- paste0('/usr/hdp/', ThdREnv.HDP_VER); Sys.setenv(HDP_BASE=ThdREnv.HDP_BASE)
    ThdREnv.HADOOP_HOME <<- paste0(ThdREnv.HDP_BASE, '/hadoop'); Sys.setenv(HADOOP_HOME=ThdREnv.HADOOP_HOME)
    ThdREnv.HADOOP_CMD <<- paste0(ThdREnv.HADOOP_HOME, '/bin/hadoop'); Sys.setenv(HADOOP_CMD=ThdREnv.HADOOP_CMD)
    ThdREnv.HADOOP_CONF <<- paste0(ThdREnv.HADOOP_HOME, '/conf'); Sys.setenv(HADOOP_CONF=ThdREnv.HADOOP_CONF)
    ThdREnv.HADOOP_CONF_DIR <<- paste0(ThdREnv.HADOOP_HOME, '/conf'); Sys.setenv(HADOOP_CONF_DIR=ThdREnv.HADOOP_CONF_DIR)
    ThdREnv.HIVE_HOME <<- paste0(ThdREnv.HDP_BASE, '/hive'); Sys.setenv(HIVE_HOME=ThdREnv.HIVE_HOME)
    
    ThdREnv.addPath(paste0(ThdREnv.HIVE_HOME, '/bin'))
    ThdREnv.addPath(paste0(ThdREnv.HADOOP_HOME, '/bin'))
    ThdREnv.addLibs(paste0(ThdREnv.HADOOP_HOME, "/lib/native"))
    
    # Set R/RStudio Environment
    ThdREnv.RBASE <<- '/opt/isv/R-base'; Sys.setenv(RBASE=ThdREnv.RBASE)
    #ThdREnv.RHOME <<- paste0(ThdREnv.RBASE, '/R-', ThdREnv.R_VER, '/lib64/R'); Sys.setenv(RHOME=ThdREnv.RHOME)
    ThdREnv.RHOME <<- paste0(ThdREnv.RBASE, '/microsoft-r/', ThdREnv.R_VER, '/lib64/R'); Sys.setenv(RHOME=ThdREnv.RHOME)
    ThdREnv.R_HOME <<- ThdREnv.RHOME; Sys.setenv(R_HOME=ThdREnv.R_HOME)
    ThdREnv.R_CONTRIB <<- paste0(ThdREnv.RBASE, '/contrib'); Sys.setenv(R_CONTRIB=ThdREnv.R_CONTRIB)
    ThdREnv.PKG_CONFIG_PATH <<- paste0(ThdREnv.R_CONTRIB, '/lib/pkgconfig', ThdREnv.R_VER); Sys.setenv(PKG_CONFIG_PATH=ThdREnv.PKG_CONFIG_PATH)
    
    ThdREnv.addPath(paste0(ThdREnv.R_CONTRIB, '/bin'))
    ThdREnv.addPath(paste0(ThdREnv.R_HOME, '/bin'))
    ThdREnv.addLibs(paste0(ThdREnv.R_CONTRIB, "/lib"))
    ThdREnv.addLibs(paste0(ThdREnv.R_CONTRIB, "/lib64"))
    ThdREnv.addLibs(paste0(ThdREnv.R_HOME, "/lib64/R/modules"))
    ThdREnv.addLibs(paste0(ThdREnv.R_HOME, "/lib64/R/lib"))
    
    # Set ODBC Environment
    ThdREnv.ODBCINSTINI <<- paste0(ThdREnv.R_CONTRIB, '/etc/odbcinst.ini'); Sys.setenv(ODBCINSTINI=ThdREnv.ODBCINSTINI)
    ThdREnv.ODBCINI <<- paste0(ThdREnv.R_CONTRIB, '/etc/odbc.ini'); Sys.setenv(ODBCINI=ThdREnv.ODBCINI)
    
    # Set CLASSPATH for Java
    ThdREnv.CLASSFILE <<- paste0(ThdREnv.R_CONTRIB, '/etc/profile.d/R-', ThdREnv.R_VER, '.classpath');
    ThdREnv.CLASSPATH <<- readChar(ThdREnv.CLASSFILE, file.info(ThdREnv.CLASSFILE)[ThdREnv.CLASSFILE, "size"] - 1)
    Sys.setenv(CLASSFILE=ThdREnv.CLASSFILE)
    Sys.setenv(CLASSPATH=ThdREnv.CLASSPATH)
    ThdREnv.REnvInitialized <<- TRUE;

    # Set TCL/TK Environment
    ThdREnv.TCL_VER <<- '8.6'; Sys.setenv(TCL_VER=ThdREnv.TCL_VER)
    ThdREnv.TK_VER <<- '8.6'; Sys.setenv(TK_VER=ThdREnv.TK_VER)
    ThdREnv.TCL_LIBRARY <<- paste0(ThdREnv.R_HOME, '/share/tcl', ThdREnv.TCL_VER); Sys.setenv(TCL_LIBRARY=ThdREnv.TCL_LIBRARY)
    ThdREnv.TK_LIBRARY <<- paste0(ThdREnv.R_HOME, '/share/tk', ThdREnv.TK_VER); Sys.setenv(TK_LIBRARY=ThdREnv.TK_LIBRARY)
}
#
# End of File
