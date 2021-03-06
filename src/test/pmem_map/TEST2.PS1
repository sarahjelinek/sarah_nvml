#
# Copyright 2014-2016, Intel Corporation
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in
#       the documentation and/or other materials provided with the
#       distribution.
#
#     * Neither the name of the copyright holder nor the names of its
#       contributors may be used to endorse or promote products derived
#       from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

#
# src/test/pmem_map/TEST2 -- unit test for pmem_map
#
[CmdletBinding(PositionalBinding=$false)]
Param(
    [alias("d")]
    $DIR = ""
    )
$Env:UNITTEST_NAME = "pmem_map\TEST2"
$Env:UNITTEST_NUM = "2"

# standard unit test setup
. ..\unittest\unittest.ps1

require_test_type medium
require_dax_devices 1
require_fs_type any

# XXX: we don't have valgrind in Windows yet
# configure_valgrind memcheck force-disable

setup

# XXX: no AddressSanitizer on Windows
# this test invokes sigsegvs by design
# export ASAN_OPTIONS=handle_segv=0

# <path> <size> <flags> <mode> <use_mlen> <use_is_pmem>

# pass the file of zero length
expect_normal_exit $Env:EXE_DIR/pmem_map$Env:EXESUFFIX `
    $DEVICE_DAX_PATH 0 D 0666 1 1 `
    $DEVICE_DAX_PATH 0 DSC 0666 1 1 `
    $DEVICE_DAX_PATH 0 DT 0666 1 1 `
    $DEVICE_DAX_PATH 0 DCE 0666 1 1 `
    $DEVICE_DAX_PATH 0 DC 0666 1 1 `
    $DEVICE_DAX_PATH 2097152 DC 0666 1 1  # len != 0

check

pass
