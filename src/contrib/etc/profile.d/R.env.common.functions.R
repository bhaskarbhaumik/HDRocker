#R.env.common.functions.R
# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
# [   C o m m o n   R   E n v i r o n m e n t   ]
# [             F U N C T I O N S               ]
# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
#
# Define Functions
#
ThdREnv.setPath <- function(path) {
  for(dir in path) ThdREnv.PATH <<- paste(ThdREnv.PATH, dir, sep = ThdREnv.PATHSEP)
  ThdREnv.PATH <<- substr(ThdREnv.PATH, 2, nchar(ThdREnv.PATH))
  Sys.setenv(PATH=ThdREnv.PATH)
}

ThdREnv.setLibs <- function(path) {
  for(dir in path) ThdREnv.LD_LIBRARY_PATH <<- paste(ThdREnv.LD_LIBRARY_PATH, dir, sep = ThdREnv.PATHSEP)
  ThdREnv.LD_LIBRARY_PATH <<- substr(ThdREnv.LD_LIBRARY_PATH, 2, nchar(ThdREnv.LD_LIBRARY_PATH))
  Sys.setenv(LD_LIBRARY_PATH=ThdREnv.LD_LIBRARY_PATH)
  Sys.setenv(LIBRARY=ThdREnv.LD_LIBRARY_PATH)
  Sys.setenv(LIBPATH=ThdREnv.LD_LIBRARY_PATH)
}

ThdREnv.addPath <- function(path, append = FALSE) {
  dir <- Sys.getenv("PATH")
  if(!exists("ThdREnv.PATH") || ThdREnv.PATH == "" || ThdREnv.PATH != dir) ThdREnv.PATH <<- dir
  for(dir in path) {
    if(!grepl(paste0("(^|", ThdREnv.PATHSEP, ")", dir, "($|", ThdREnv.PATHSEP, ")"), as.character(ThdREnv.PATH))) {
      if(append) {
        ThdREnv.PATH <<- paste(ThdREnv.PATH, dir, sep = ThdREnv.PATHSEP)
      } else {
        ThdREnv.PATH <<- paste(dir, ThdREnv.PATH, sep = ThdREnv.PATHSEP)
      }
    }
  }
  Sys.setenv(PATH=ThdREnv.PATH)
}

ThdREnv.addLibs <- function(path, append = FALSE) {
  dir <- Sys.getenv("LD_LIBRARY_PATH")
  if(!exists("ThdREnv.LD_LIBRARY_PATH") || ThdREnv.LD_LIBRARY_PATH == "" || ThdREnv.LD_LIBRARY_PATH != dir) ThdREnv.LD_LIBRARY_PATH <<- dir
  for(dir in path) {
    if(!grepl(paste0("(^|", ThdREnv.PATHSEP, ")", dir, "($|", ThdREnv.PATHSEP, ")"), as.character(ThdREnv.LD_LIBRARY_PATH))) {
      if(append) {
        ThdREnv.LD_LIBRARY_PATH <<- paste(ThdREnv.LD_LIBRARY_PATH, dir, sep = ThdREnv.PATHSEP)
      } else {
        ThdREnv.LD_LIBRARY_PATH <<- paste(dir, ThdREnv.LD_LIBRARY_PATH, sep = ThdREnv.PATHSEP)
      }
    }
  }
  Sys.setenv(LD_LIBRARY_PATH=ThdREnv.LD_LIBRARY_PATH)
  Sys.setenv(LIBRARY=ThdREnv.LD_LIBRARY_PATH)
  Sys.setenv(LIBPATH=ThdREnv.LD_LIBRARY_PATH)
}
#
# End of File
