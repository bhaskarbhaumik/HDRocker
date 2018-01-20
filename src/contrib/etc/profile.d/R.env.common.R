#R.env.common.R
# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
# [   C o m m o n   R   E n v i r o n m e n t   ]
# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
#
#  C u r r e n t   R   V e r s i o n
#
ThdREnv.R_VER <<- '3.3'

#
#----- Do not change below this line -------
ThdREnv.FILESEP <- .Platform$file.sep # OS specific file seperator
ThdREnv.PATHSEP <- .Platform$path.sep # OS specific path seperator

if(exists('R_VER_USER')) ThdREnv.R_VER <<- R_VER_USER;
Sys.setenv(R_VER=ThdREnv.R_VER)

RProfileDir <- paste0('/opt/isv/R-base/contrib/etc/profile.d')

if(file.exists(paste0(RProfileDir, '/R.env.common.functions.R'))) {
    source(paste0(RProfileDir, '/R.env.common.functions.R'))
}

if(file.exists(paste0(RProfileDir, '/R.env.common.variables.R'))) {
    source(paste0(RProfileDir, '/R.env.common.variables.R'))
}

options(prompt = paste0('R-', ThdREnv.R_VER, '> '))
options(continue = '       + ')
cat(paste0('\nShell environment set for R-', ThdREnv.R_VER, '\nR.home() is set to \'', ThdREnv.RHOME, '\'\n\n'))
SysInfo <- Sys.info()
cat(paste0('Session started at: ', date(), ' for user: ', SysInfo['user'], ' (logon: ', SysInfo['effective_user'], ') in host: ', SysInfo['nodename']))
rm(SysInfo)
rm(RProfileDir)
#
# End of File
