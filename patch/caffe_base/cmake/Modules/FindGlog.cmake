# - Try to find Glog
#
# The following variables are optionally searched for defaults
#  GLOG_ROOT_DIR:            Base directory where all GLOG components are found
#
# The following are set after configuration is done:
#  GLOG_FOUND
#  GLOG_INCLUDE_DIRS
#  GLOG_LIBRARIES
#  GLOG_LIBRARYRARY_DIRS

include(FindPackageHandleStandardArgs)
# modified by guyadong
set(GLOG_ROOT_DIR "" CACHE PATH "Folder contains Google glog")
if(GLOG_ROOT_DIR)
	find_package(glog REQUIRED CONFIG HINTS ${GLOG_ROOT_DIR})
	set(GLOG_INCLUDE_DIR ${GLOG_ROOT_DIR}/include)
	# glog::glog is imported target
	set(GLOG_LIBRARY glog::glog)
else(GLOG_ROOT_DIR)	
	find_path(GLOG_INCLUDE_DIR glog/logging.h
	    PATHS ${GLOG_ROOT_DIR}/include
			NO_DEFAULT_PATH)
	find_path(GLOG_INCLUDE_DIR glog/logging.h
	    PATHS ${GLOG_ROOT_DIR}/include)
	
	if(MSVC)
	    find_library(GLOG_LIBRARY_RELEASE glog glog_static
	        PATHS ${GLOG_ROOT_DIR}
	        PATH_SUFFIXES lib NO_DEFAULT_PATH)
	
	    find_library(GLOG_LIBRARY_DEBUG glog glog_static
	        PATHS ${GLOG_ROOT_DIR}
	        PATH_SUFFIXES lib NO_DEFAULT_PATH)
	
	    find_library(GLOG_LIBRARY_RELEASE glog glog_static
	        PATHS ${GLOG_ROOT_DIR}
	        PATH_SUFFIXES lib)
	
	    find_library(GLOG_LIBRARY_DEBUG glog glog_static
	        PATHS ${GLOG_ROOT_DIR}/lib
	        PATH_SUFFIXES lib)
	
	    set(GLOG_LIBRARY optimized ${GLOG_LIBRARY_RELEASE} debug ${GLOG_LIBRARY_DEBUG})
	else()
	    find_library(GLOG_LIBRARY glog
	        PATHS ${GLOG_ROOT_DIR}
	        PATH_SUFFIXES lib lib64
					NO_DEFAULT_PATH)
	    find_library(GLOG_LIBRARY glog
	        PATHS ${GLOG_ROOT_DIR}
	        PATH_SUFFIXES lib lib64)
	endif()
endif(GLOG_ROOT_DIR)

find_package_handle_standard_args(Glog DEFAULT_MSG GLOG_INCLUDE_DIR GLOG_LIBRARY)

if(GLOG_FOUND)
  set(GLOG_INCLUDE_DIRS ${GLOG_INCLUDE_DIR})
  set(GLOG_LIBRARIES ${GLOG_LIBRARY})
  message(STATUS "Found glog    (include: ${GLOG_INCLUDE_DIR}, library: ${GLOG_LIBRARY})")
  mark_as_advanced(GLOG_ROOT_DIR GLOG_LIBRARY_RELEASE GLOG_LIBRARY_DEBUG
                                 GLOG_LIBRARY GLOG_INCLUDE_DIR)
endif()
