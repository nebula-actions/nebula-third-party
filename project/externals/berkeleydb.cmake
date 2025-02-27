# Copyright (c) 2021 vesoft inc. All rights reserved.
#
# This source code is licensed under Apache 2.0 License,
# attached with Common Clause Condition 1.0, found in the LICENSES directory.

set(name berkeleydb)
set(source_dir ${CMAKE_CURRENT_BINARY_DIR}/${name}/source/)
ExternalProject_Add(
    ${name}
    URL http://download.oracle.com/berkeley-db/db-5.1.29.tar.gz
    URL_HASH MD5=a94ea755ab695bc04f82b94d2e24a1ef
    PREFIX ${CMAKE_CURRENT_BINARY_DIR}/${name}/
    TMP_DIR ${BUILD_INFO_DIR}
    STAMP_DIR ${BUILD_INFO_DIR}
    DOWNLOAD_DIR ${DOWNLOAD_DIR}
    SOURCE_DIR ${source_dir}
    CONFIGURE_COMMAND
        ${common_configure_envs}
        "LIBS=${LIBS}"
        ./build_unix/../dist/configure ${common_configure_args}
            --libdir=${CMAKE_BERKELEYDB_LIB_INSTALL_PREFIX}
            --includedir=${CMAKE_BERKELEYDB_INCLUDE_INSTALL_PREFIX}
    BUILD_IN_SOURCE 1
    BUILD_COMMAND make -s -j${BUILDING_JOBS_NUM}
    INSTALL_COMMAND  make -s -j${BUILDING_JOBS_NUM} install
    LOG_CONFIGURE TRUE
    LOG_BUILD TRUE
    LOG_INSTALL TRUE
)

ExternalProject_Add_Step(${name} clean
    EXCLUDE_FROM_MAIN TRUE
    ALWAYS TRUE
    DEPENDEES configure
    COMMAND make clean -j
    COMMAND rm -f ${BUILD_INFO_DIR}/${name}-build
    WORKING_DIRECTORY ${source_dir}
)

ExternalProject_Add_StepTargets(${name} clean)

