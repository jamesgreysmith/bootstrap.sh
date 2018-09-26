#!/bin/sh
#
# Copyright (C) James Grey Smith <jamesgreysmith@gmail.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
# bootstrap.sh:  Make a really generic toolchain+stage 1 compiler without a libc
# Version: 0.1.8
#
# Notes:
#          Tested with GNU bash (v4.3.48)
#

# It's assumed that we're in the 'tools' subdirectory.
export SCRIPTDIR=`pwd`

# Our core configuration.
[ -z ${BOOTSTRAP_DEBUG} ] || ${ECHO_CMD} "SCRIPTDIR is ${SCRIPTDIR}"
[ ! -z ${SRCDIR} ] || export SRCDIR="${SCRIPTDIR}/.."
[ -z ${BOOTSTRAP_DEBUG} ] || ${ECHO_CMD} "SRCDIR is ${SRCDIR}"
[ ! -z ${TARGET_MACHARCH} ] || export TARGET_MACHARCH="i686"
BOOTSRAP_GLOBAL_CFG="${SCRIPTDIR}/bootstrap.cfg"
BOOTSRAP_TARGET_CFG="${SCRIPTDIR}/bootstrap_target_${TARGET_MACHARCH}.cfg"
[ -z ${BOOTSTRAP_DEBUG} ] || ${ECHO_CMD} "BOOTSRAP_GLOBAL_CFG is ${BOOTSRAP_GLOBAL_CFG}"
[ -z ${BOOTSTRAP_DEBUG} ] || ${ECHO_CMD} "BOOTSRAP_TARGET_CFG is ${BOOTSRAP_TARGET_CFG}"

# The defaults.
if [ -f ${BOOTSRAP_GLOBAL_CFG} ]; then
	. ${BOOTSRAP_GLOBAL_CFG}
	if [ "${BOOTSTRAP_DEBUG}" == "True" ]; then
	#
	#  Debugging: dump the global configuration.
	#
		${ECHO_CMD} "SIG_VERIFY_CMD is ${SIG_VERIFY_CMD}"
		${ECHO_CMD} "DISTDIR_LIST is ${DISTDIR_LIST}"
		${ECHO_CMD} "GET_CMD is ${GET_CMD}"
		${ECHO_CMD} "TAR_CMD is ${TAR_CMD}"
		${ECHO_CMD} "GMAKE is ${GMAKE}"
		${ECHO_CMD} "LOGFILE is ${LOGFILE}"
		${ECHO_CMD} "CHECK_SIGS [${CHECK_SIGS}]"
		${ECHO_CMD} "PKGCONF_DIST_NAME is ${PKGCONF_DIST_NAME}"
		${ECHO_CMD} "TEXINFO_DIST_NAME is ${TEXINFO_DIST_NAME}"
		${ECHO_CMD} "BINUTILS_DIST_NAME is ${BINUTILS_DIST_NAME}"
		${ECHO_CMD} "GMP_DIST_NAME is ${GMP_DIST_NAME}"
		${ECHO_CMD} "MPFR_DIST_NAME is ${MPFR_DIST_NAME}"
		${ECHO_CMD} "MPC_DIST_NAME is ${MPC_DIST_NAME}"
		${ECHO_CMD} "CLOOG_ISL_DIST_NAME is ${CLOOG_ISL_DIST_NAME}"
		${ECHO_CMD} "GCC_DIST_NAME is ${GCC_DIST_NAME}"
		${ECHO_CMD} "BISON_DIST_NAME is ${BISON_DIST_NAME}"
		${ECHO_CMD} "FLEX_DIST_NAME is ${FLEX_DIST_NAME}"
		${ECHO_CMD} "PKGCONF_DIST_VERSION is ${PKGCONF_DIST_VERSION}"
		${ECHO_CMD} "TEXINFO_DIST_VERSION is ${TEXINFO_DIST_VERSION}"
		${ECHO_CMD} "BINUTILS_DIST_VERSION is ${BINUTILS_DIST_VERSION}"
		${ECHO_CMD} "GMP_DIST_VERSION is ${GMP_DIST_VERSION}"
		${ECHO_CMD} "MPFR_DIST_VERSION is ${MPFR_DIST_VERSION}"
		${ECHO_CMD} "MPC_DIST_VERSION is ${MPC_DIST_VERSION}"
		${ECHO_CMD} "CLOOG_ISL_DIST_VERSION is ${CLOOG_ISL_DIST_VERSION}"
		${ECHO_CMD} "GCC_DIST_VERSION is ${GCC_DIST_VERSION}"
		${ECHO_CMD} "BISON_DIST_VERSION is ${BISON_DIST_VERSION}"
		${ECHO_CMD} "FLEX_DIST_VERSION is ${FLEX_DIST_VERSION}"
		${ECHO_CMD} "PKGCONF_DIST_ARCHIVE is ${PKGCONF_DIST_ARCHIVE}"
		${ECHO_CMD} "TEXINFO_DIST_ARCHIVE is ${TEXINFO_DIST_ARCHIVE}"
		${ECHO_CMD} "BINUTILS_DIST_ARCHIVE is ${BINUTILS_DIST_ARCHIVE}"
		${ECHO_CMD} "GMP_DIST_ARCHIVE is ${GMP_DIST_ARCHIVE}"
		${ECHO_CMD} "MPFR_DIST_ARCHIVE is ${MPFR_DIST_ARCHIVE}"
		${ECHO_CMD} "MPC_DIST_ARCHIVE is ${MPC_DIST_ARCHIVE}"
		${ECHO_CMD} "CLOOG_ISL_DIST_ARCHIVE is ${CLOOG_ISL_DIST_ARCHIVE}"
		${ECHO_CMD} "GCC_DIST_ARCHIVE is ${GCC_DIST_ARCHIVE}"
		${ECHO_CMD} "BISON_DIST_ARCHIVE is ${BISON_DIST_ARCHIVE}"
		${ECHO_CMD} "FLEX_DIST_ARCHIVE is ${FLEX_DIST_ARCHIVE}"
		${ECHO_CMD} "PKGCONF_DIST is ${PKGCONF_DIST}"
		${ECHO_CMD} "TEXINFO_DIST is ${TEXINFO_DIST}"
		${ECHO_CMD} "BINUTILS_DIST is ${BINUTILS_DIST}"
		${ECHO_CMD} "GMP_DIST is ${GMP_DIST}"
		${ECHO_CMD} "MPFR_DIST is ${MPFR_DIST}"
		${ECHO_CMD} "MPC_DIST is ${MPC_DIST}"
		${ECHO_CMD} "CLOOG_ISL_DIST is ${CLOOG_ISL_DIST}"
		${ECHO_CMD} "GCC_DIST is ${GCC_DIST}"
		${ECHO_CMD} "BISON_DIST is ${BISON_DIST}"
		${ECHO_CMD} "FLEX_DIST is ${FLEX_DIST}"
		${ECHO_CMD} "PKGCONF_DIST_SIG is ${PKGCONF_DIST_SIG}"
		${ECHO_CMD} "TEXINFO_DIST_SIG is ${TEXINFO_DIST_SIG}"
		${ECHO_CMD} "BINUTILS_DIST_SIG is ${BINUTILS_DIST_SIG}"
		${ECHO_CMD} "GMP_DIST_SIG is ${GMP_DIST_SIG}"
		${ECHO_CMD} "MPFR_DIST_SIG is ${MPFR_DIST_SIG}"
		${ECHO_CMD} "MPC_DIST_SIG is ${MPC_DIST_SIG}"
		${ECHO_CMD} "CLOOG_ISL_DIST_SIG is ${CLOOG_ISL_DIST_SIG}"
		${ECHO_CMD} "GCC_DIST_SIG is ${GCC_DIST_SIG}"
		${ECHO_CMD} "BISON_DIST_SIG is ${BISON_DIST_SIG}"
		${ECHO_CMD} "FLEX_DIST_SIG is ${FLEX_DIST_SIG}"
	fi
else
	${ECHO_CMD} "Global configuration file not found. Exiting."
	exit 1
fi

# Platform specific overrides.
if [ -f ${BOOTSRAP_TARGET_CFG} ]; then
	. ${BOOTSRAP_TARGET_CFG}
	if [ "${BOOTSTRAP_DEBUG}" == "True" ]; then
		${ECHO_CMD} "TARGET_MACHTYPE is ${TARGET_MACHTYPE}"
		${ECHO_CMD} "TARGET_MACHARCH is ${TARGET_MACHARCH}"
		${ECHO_CMD} "TARGET_PREFIX is ${TARGET_PREFIX}"
		${ECHO_CMD} "BOOTSTRAP_RESET_BUILD is [${BOOTSTRAP_RESET_BUILD}]"
		${ECHO_CMD} "BOOTSTRAP_RESET_PREFIX is [${BOOTSTRAP_RESET_PREFIX}]"
		${ECHO_CMD} "BOOTSTRAP_RESET_ALL is [${BOOTSTRAP_RESET_ALL}]"
	fi
else
	${ECHO_CMD} "Architecture configuration file not found. Exiting."
	exit 1
fi

# Evil globals..

ErrorString=""
AT_STEP="none"
AT_STEP_N=""
AT_STEP_VAR=""
AT_STEP_DIST=""
AT_STEP_DIST_SUBDIR=""
AT_STEP_DIST_ARCHIVE=""
AT_STEP_DIST_SHA512=""
AT_STEP_DIST_SIG=""
AT_STEP_DIST_SIG_FILE=""
AT_STEP_DIST_CONFIGURE_OPTS=""

#
# The core functions in order of dependentcy.
#
makeDirectories()
{
	for i in ${DISTDIR_LIST}; do
		[ -d ./${i} ] || ${MKDIR_CMD} ./${i}
		# Empty our build dirrectories & stagging files.
		if [ "${BOOTSTRAP_RESET_BUILD}" == "True" ]; then
			if [ -d ./${i} ]; then
				${RM_CMD} -fr ${i}/*
				[ "${BOOTSTRAP_DEBUG}" != "True" ] || ${ECHO_CMD} "RM: ./${i}/*"
			fi
			if [ -f .${i}_done ]; then
				${RM_CMD} -f .${i}_done
				[ "${BOOTSTRAP_DEBUG}" != "True" ]  || ${ECHO_CMD} "RM: .${i}_done"
			fi
		fi
	done
}

prepLogfile()
{
	if [ "${BOOTSTRAP_RESET_ALL}" == "True" ]; then
		if [ -f ${LOGFILE} ]; then
			[ "${BOOTSTRAP_DEBUG}" != "True" ] || ${ECHO_CMD} "Removing ${LOGFILE}."
			${RM_CMD} ${LOGFILE}
		fi
	fi

	if [ ! -f ${LOGFILE} ]; then
		touch ${LOGFILE}
	fi

	# Log the time the script was run.
	${ECHO_CMD} "-------------------| bootstrap.sh |-------------------" >> ${LOGFILE}
	${ECHO_CMD} "${DATE_CMD}" >> ${LOGFILE}
	${ECHO_CMD} "------------------------------------------------------" >> ${LOGFILE}
}

beforeStepsPrep()
{
	# Some friendly output.
	${ECHO_CMD} "===================| bootstrap.sh |==================="
	${ECHO_CMD} -n "Date: "
	${ECHO_CMD} "${DATE_CMD}"
	${ECHO_CMD} ""
	${ECHO_CMD} "Building toolchain in ${TARGET_PREFIX} in 5 secconds..."
	sleep 5

	# Special debugging output.
	[ "${BOOTSTRAP_DEBUG}" != "True" ] || ${ECHO_CMD} "PATH is ${PATH}" >> ${LOGFILE}
	[ "${BOOTSTRAP_DEBUG}" != "True" ] || ${ECHO_CMD} "LD_LIBRARY_PATH is ${LD_LIBRARY_PATH}" >> ${LOGFILE}
	[ "${BOOTSTRAP_DEBUG}" != "True" ] || ${ECHO_CMD} "PKG_CONFIG_PATH is ${PKG_CONFIG_PATH}" >> ${LOGFILE}

	# Reset control vars.
	[ "${BOOTSTRAP_RESET_ALL}" != "True" ] || export BOOTSTRAP_RESET_PREFIX="True"
	[ "${BOOTSTRAP_RESET_ALL}" != "True" ] || export BOOTSTRAP_RESET_BUILD="True"

	# Remove the contents of our distrib prefix.
	if [ "${BOOTSTRAP_RESET_PREFIX}" == "True" ]; then
		${ECHO_CMD} "Info: clearing ${TARGET_PREFIX}"
		${RM_CMD} -fr ${TARGET_PREFIX}/*
	fi

	# Import the checksum cache if it there.
	if [ -f ${CHECKSUM_CACHE} ]; then
		[ "${BOOTSTRAP_DEBUG}" != "True" ] || ${ECHO_CMD} "Info: getting hashes from ${CHECKSUM_CACHE}."
		${ECHO_CMD} "Info: getting hashes from ${CHECKSUM_CACHE}." >> ${LOGFILE}
		. ${CHECKSUM_CACHE}
	fi
}

doStepPrep()
{
	${RM_CMD} -fr ./${AT_STEP_DIST_SUBDIR}/*

	if [ ! -e ./${AT_STEP_DIST_ARCHIVE} ]; then
		${ECHO_CMD} "... downloading ${AT_STEP} ... "
		${GET_CMD} -O ${AT_STEP_DIST_ARCHIVE} ${AT_STEP_DIST} || ${ECHO_CMD} "FatalBootstrapError: failed to get ${AT_STEP} archive." &>> ${LOGFILE}
	fi
	if [ "${CHECK_SIGS}" == "True" ]; then
		if [ "${AT_STEP_DIST_SIG}" != "none" ]; then
			if [ ! -e ./${AT_STEP_DIST_SIG_FILE} ]; then
				${ECHO_CMD} "... downloading ${AT_STEP} sig file ... "
				${ECHO_CMD} ""
				${GET_CMD} ${AT_STEP_DIST_SIG} || ${ECHO_CMD} "FatalBootstrapError: couldn't get archive sig." &>> ${LOGFILE}
			fi
			${SIG_VERIFY_CMD} ./${AT_STEP_DIST_SIG_FILE} ./${AT_STEP_DIST_ARCHIVE} || ${ECHO_CMD} "FatalBootstrapError: archive sigcheck failed." &>> ${LOGFILE}
			${ECHO_CMD} ""
		fi
		if [ "${AT_STEP_DIST_SHA512}" != "none" ]; then
			[ "`${SHA512SUM_CMD} ./${AT_STEP_DIST_ARCHIVE} | ${CUT_CMD} -d ' ' -f 1`" == "${AT_STEP_DIST_SHA512}" ] || ${ECHO_CMD} "FatalBootstrapError: archive checksum failed." &>> ${LOGFILE}
		fi
		if [ "${AT_STEP_DIST_SHA512}" == "none" ]; then
			${ECHO_CMD} "${AT_STEP_VAR}_DIST_SHA512=`${SHA512SUM_CMD} ./${AT_STEP_DIST_ARCHIVE} | ${CUT_CMD} -d ' ' -f 1`" &>> ${CHECKSUM_CACHE}
		fi
	fi
	${ECHO_CMD} "... extracting archive ..."
	${TAR_CMD} ${AT_STEP_DIST_ARCHIVE} &>> ${LOGFILE} || ${ECHO_CMD} "FatalBootstrapError: failed to unpack ${AT_STEP} archive." &>> ${LOGFILE}
}

checkForConfigureScript()
{
	if [ ! -x ./configure ]; then
		${ECHO_CMD} "No configure script found, so running the autogen.sh script." >> ${LOGFILE}
		# Use bash if it exists.
		BASH_OR_NO_BASH=`which bash`
		if [ ! -z ${BASH_OR_NO_BASH} ]; then
			${ECHO_CMD} "Using bash for autogen.sh" >> ${LOGFILE}
			SHELL_IT="bash"
		fi
		if [ -x ./autogen.sh ]; then
				${SHELL_IT} ./autogen.sh &>/dev/null
		else
			${ECHO_CMD} "No autogen script found. PWD was: ${PWD}. Exiting."
			exit 1
		fi
	fi
}

doStep()
{
	${ECHO_CMD} "... running configure scipt ... "
	./configure ${AT_STEP_DIST_CONFIGURE_OPTS} &>/dev/null || ${ECHO_CMD} "FatalBootstrapError: ${AT_STEP} configure script died." &>> ${LOGFILE}
	${ECHO_CMD} "... running make ... "
	${GMAKE} &>> ${LOGFILE} || ${ECHO_CMD} "FatalBootstrapError: ${AT_STEP} make failed." &>> ${LOGFILE}
	${ECHO_CMD} "... running make install ... "
	${GMAKE} install &>> ${LOGFILE} || ${ECHO_CMD} "FatalBootstrapError: ${AT_STEP} make install failed." &>> ${LOGFILE}
}

doStepInSubdir()
{
	${MKDIR_CMD} ./build
	cd ./build
	${ECHO_CMD} "... running configure scipt ... "
	../configure ${AT_STEP_DIST_CONFIGURE_OPTS} &>/dev/null || ${ECHO_CMD} "FatalBootstrapError: ${AT_STEP} configure script died." &>> ${LOGFILE}
	${ECHO_CMD} "... running make ... "
	${GMAKE} &>> ${LOGFILE} || ${ECHO_CMD} "FatalBootstrapError: ${AT_STEP} make failed." &>> ${LOGFILE}
	${ECHO_CMD} "... running make install ... "
	${GMAKE} install &>> ${LOGFILE} || ${ECHO_CMD} "FatalBootstrapError: ${AT_STEP} make install failed." &>> ${LOGFILE}
}

onStepFinish()
{
	ErrorString=$(${GREP_CMD} FatalBootstrapError ${LOGFILE})
	if [ "${ErrorString}" != "" ]; then
		${ECHO_CMD} "Hit an error. Exiting."
		exit 1
	else
		${ECHO_CMD} "Stage #${AT_STEP_N}, ${AT_STEP} ... OK"
		touch .${AT_STEP}_done
	fi
	${ECHO_CMD} ""
}

endMsg()
{
	${ECHO_CMD} -n " "
	${ECHO_CMD} -n "All done. :)"
	${ECHO_CMD} " "
}

buildCompiler()
{
	# Make sure we have a log file
	prepLogfile
	
	# Initailize stuff for our steps
	beforeStepsPrep

	# Make all the dirrectories if they're not there.
	makeDirectories
	
	# Padding.... er
	${ECHO_CMD} ""
	sleep 2

	if [ ! -f .pkgconf_done ]; then
		AT_STEP="pkgconf"
		AT_STEP_N="1"
		AT_STEP_VAR="PKGCONF"
		AT_STEP_DIST="${PKGCONF_DIST}"
		AT_STEP_DIST_SUBDIR="${PKGCONF_DIST_SUBDIR}"
		AT_STEP_DIST_ARCHIVE="${PKGCONF_DIST_ARCHIVE}"
		AT_STEP_DIST_SHA512="${PKGCONF_DIST_SHA512}"
		AT_STEP_DIST_SIG="${PKGCONF_DIST_SIG}"
		AT_STEP_DIST_SIG_FILE="${PKGCONF_DIST_SIG_FILE}"
		AT_STEP_DIST_CONFIGURE_OPTS="${PKGCONF_DIST_CONFIGURE_OPTS}"
		cd ./${AT_STEP}
		doStepPrep
		cd ./${AT_STEP_DIST_SUBDIR}
		checkForConfigureScript
		doStep
		if [ ! -e ${TARGET_PREFIX}/bin/pkg-config ]; then
			cd ${TARGET_PREFIX}/bin
			${ECHO_CMD} "... making symlink to pkgconf in ${TARGET_PREFIX}/bin ..." &>> ${LOGFILE}
			${LN_CMD} -sf pkgconf pkg-config &>> ${LOGFILE}
		fi
		cd ${SCRIPTDIR}
		export PKG_CONFIG="${TARGET_PREFIX}/bin/pkgconf"
		onStepFinish
	else
		export PKG_CONFIG="${TARGET_PREFIX}/bin/pkgconf"
		${ECHO_CMD} -n ""
	fi
	sleep 1
	if [ ! -f .texinfo_done ]; then
		AT_STEP="texinfo"
		AT_STEP_N="2"
		AT_STEP_VAR="TEXINFO"
		AT_STEP_DIST="${TEXINFO_DIST}"
		AT_STEP_DIST_SUBDIR="${TEXINFO_DIST_SUBDIR}"
		AT_STEP_DIST_ARCHIVE="${TEXINFO_DIST_ARCHIVE}"
		AT_STEP_DIST_SHA512="${TEXINFO_DIST_SHA512}"
		AT_STEP_DIST_SIG="${TEXINFO_DIST_SIG}"
		AT_STEP_DIST_SIG_FILE="${TEXINFO_DIST_SIG_FILE}"
		AT_STEP_DIST_CONFIGURE_OPTS="${TEXINFO_DIST_CONFIGURE_OPTS}"
		cd ./${AT_STEP}
		doStepPrep
		cd ./${AT_STEP_DIST_SUBDIR}
		checkForConfigureScript
		doStep
		cd ${SCRIPTDIR}
		onStepFinish
	else
		${ECHO_CMD} -n " "
		${ECHO_CMD} -n "."
	fi
	sleep 1
	if [ ! -f .binutils_done ]; then
		AT_STEP="binutils"
		AT_STEP_N="3"
		AT_STEP_VAR="BINUTILS"
		AT_STEP_DIST="${BINUTILS_DIST}"
		AT_STEP_DIST_SUBDIR="${BINUTILS_DIST_SUBDIR}"
		AT_STEP_DIST_ARCHIVE="${BINUTILS_DIST_ARCHIVE}"
		AT_STEP_DIST_SHA512="${BINUTILS_DIST_SHA512}"
		AT_STEP_DIST_SIG="${BINUTILS_DIST_SIG}"
		AT_STEP_DIST_SIG_FILE="${BINUTILS_DIST_SIG_FILE}"
		AT_STEP_DIST_CONFIGURE_OPTS="${BINUTILS_DIST_CONFIGURE_OPTS}"
		cd ./${AT_STEP}
		doStepPrep
		cd ./${AT_STEP_DIST_SUBDIR}
		checkForConfigureScript
		doStep
		cd ${SCRIPTDIR}
		onStepFinish
	else
		${ECHO_CMD} -n " "
		${ECHO_CMD} -n "."
	fi
	sleep 1
	if [ ! -f .gmp_done ]; then
		AT_STEP="gmp"
		AT_STEP_N="4"
		AT_STEP_VAR="GMP"
		AT_STEP_DIST="${GMP_DIST}"
		AT_STEP_DIST_SUBDIR="${GMP_DIST_SUBDIR}"
		AT_STEP_DIST_ARCHIVE="${GMP_DIST_ARCHIVE}"
		AT_STEP_DIST_SHA512="${GMP_DIST_SHA512}"
		AT_STEP_DIST_SIG="${GMP_DIST_SIG}"
		AT_STEP_DIST_SIG_FILE="${GMP_DIST_SIG_FILE}"
		AT_STEP_DIST_CONFIGURE_OPTS="${GMP_DIST_CONFIGURE_OPTS}"
		cd ./${AT_STEP}
		doStepPrep
		cd ./${AT_STEP_DIST_SUBDIR}
		checkForConfigureScript
		doStep
		cd ${SCRIPTDIR}
		onStepFinish
	else
		${ECHO_CMD} -n " "
		${ECHO_CMD} -n "."
	fi
	sleep 1
	if [ ! -f .mpfr_done ]; then
		AT_STEP="mpfr"
		AT_STEP_N="5"
		AT_STEP_VAR="MPFR"
		AT_STEP_DIST="${MPFR_DIST}"
		AT_STEP_DIST_SUBDIR="${MPFR_DIST_SUBDIR}"
		AT_STEP_DIST_ARCHIVE="${MPFR_DIST_ARCHIVE}"
		AT_STEP_DIST_SHA512="${MPFR_DIST_SHA512}"
		AT_STEP_DIST_SIG="${MPFR_DIST_SIG}"
		AT_STEP_DIST_SIG_FILE="${MPFR_DIST_SIG_FILE}"
		AT_STEP_DIST_CONFIGURE_OPTS="${MPFR_DIST_CONFIGURE_OPTS}"
		cd ./${AT_STEP}
		doStepPrep
		cd ./${AT_STEP_DIST_SUBDIR}
		checkForConfigureScript
		doStep
		cd ${SCRIPTDIR}
		onStepFinish
	else
		${ECHO_CMD} -n ""
		${ECHO_CMD} -n "."
	fi
	sleep 1
	if [ ! -f .mpc_done ]; then
		AT_STEP="mpc"
		AT_STEP_N="6"
		AT_STEP_VAR="MPC"
		AT_STEP_DIST="${MPC_DIST}"
		AT_STEP_DIST_SUBDIR="${MPC_DIST_SUBDIR}"
		AT_STEP_DIST_ARCHIVE="${MPC_DIST_ARCHIVE}"
		AT_STEP_DIST_SHA512="${MPC_DIST_SHA512}"
		AT_STEP_DIST_SIG="${MPC_DIST_SIG}"
		AT_STEP_DIST_SIG_FILE="${MPC_DIST_SIG_FILE}"
		AT_STEP_DIST_CONFIGURE_OPTS="${MPC_DIST_CONFIGURE_OPTS}"
		cd ./${AT_STEP}
		doStepPrep
		cd ./${AT_STEP_DIST_SUBDIR}
		checkForConfigureScript
		doStep
		cd ${SCRIPTDIR}
		onStepFinish
	else
		${ECHO_CMD} -n " "
		${ECHO_CMD} -n "."
	fi
	sleep 1
	if [ ! -f .cloog-isl_done ]; then
		AT_STEP="cloog-isl"
		AT_STEP_N="7"
		AT_STEP_VAR="CLOOG_ISL"
		AT_STEP_DIST="${CLOOG_ISL_DIST}"
		AT_STEP_DIST_SUBDIR="${CLOOG_ISL_DIST_SUBDIR}"
		AT_STEP_DIST_ARCHIVE="${CLOOG_ISL_DIST_ARCHIVE}"
		AT_STEP_DIST_SHA512="${CLOOG_ISL_DIST_SHA512}"
		AT_STEP_DIST_SIG="${CLOOG_ISL_DIST_SIG}"
		AT_STEP_DIST_SIG_FILE="${CLOOG_ISL_DIST_SIG_FILE}"
		AT_STEP_DIST_CONFIGURE_OPTS="${CLOOG_ISL_DIST_CONFIGURE_OPTS}"
		cd ./${AT_STEP}
		doStepPrep
		cd ./${AT_STEP_DIST_SUBDIR}
		checkForConfigureScript
		doStep
		cd ${SCRIPTDIR}
		onStepFinish
	else
		${ECHO_CMD} -n " "
		${ECHO_CMD} -n "."
	fi
	sleep 1
	if [ ! -f .bison_done ]; then
		AT_STEP="bison"
		AT_STEP_N="8"
		AT_STEP_VAR="BISON"
		AT_STEP_DIST="${BISON_DIST}"
		AT_STEP_DIST_SUBDIR="${BISON_DIST_SUBDIR}"
		AT_STEP_DIST_ARCHIVE="${BISON_DIST_ARCHIVE}"
		AT_STEP_DIST_SHA512="${BISON_DIST_SHA512}"
		AT_STEP_DIST_SIG="${BISON_DIST_SIG}"
		AT_STEP_DIST_SIG_FILE="${BISON_DIST_SIG_FILE}"
		AT_STEP_DIST_CONFIGURE_OPTS="${BISON_DIST_CONFIGURE_OPTS}"
		cd ./${AT_STEP}
		doStepPrep
		cd ./${AT_STEP_DIST_SUBDIR}
		checkForConfigureScript
		doStep
		cd ${SCRIPTDIR}
		onStepFinish
	else
		${ECHO_CMD} -n " "
		${ECHO_CMD} -n "."
	fi
	sleep 1
	if [ ! -f .flex_done ]; then
		AT_STEP="flex"
		AT_STEP_N="9"
		AT_STEP_VAR="FLEX"
		AT_STEP_DIST="${FLEX_DIST}"
		AT_STEP_DIST_SUBDIR="${FLEX_DIST_SUBDIR}"
		AT_STEP_DIST_ARCHIVE="${FLEX_DIST_ARCHIVE}"
		AT_STEP_DIST_SHA512="${FLEX_DIST_SHA512}"
		AT_STEP_DIST_SIG="${FLEX_DIST_SIG}"
		AT_STEP_DIST_SIG_FILE="${FLEX_DIST_SIG_FILE}"
		AT_STEP_DIST_CONFIGURE_OPTS="${FLEX_DIST_CONFIGURE_OPTS}"
		cd ./${AT_STEP}
		doStepPrep
		cd ./${AT_STEP_DIST_SUBDIR}
		checkForConfigureScript
		doStep
		cd ${SCRIPTDIR}
		onStepFinish
	else
		${ECHO_CMD} -n " "
		${ECHO_CMD} -n "."
	fi
	sleep 1
	if [ ! -f .gcc_done ]; then
		AT_STEP="gcc"
		AT_STEP_N="10"
		AT_STEP_VAR="GCC"
		AT_STEP_DIST="${GCC_DIST}"
		AT_STEP_DIST_SUBDIR="${GCC_DIST_SUBDIR}"
		AT_STEP_DIST_ARCHIVE="${GCC_DIST_ARCHIVE}"
		AT_STEP_DIST_SHA512="${GCC_DIST_SHA512}"
		AT_STEP_DIST_SIG="${GCC_DIST_SIG}"
		AT_STEP_DIST_SIG_FILE="${GCC_DIST_SIG_FILE}"
		AT_STEP_DIST_CONFIGURE_OPTS="${GCC_DIST_CONFIGURE_OPTS}"
		cd ./${AT_STEP}
		doStepPrep
		cd ./${AT_STEP_DIST_SUBDIR}
		checkForConfigureScript
		doStepInSubdir
		cd ${SCRIPTDIR}
		onStepFinish
		endMsg
	else
		endMsg
	fi
}

export PATH="${TARGET_PREFIX}/bin:${PATH}"
export LD_LIBRARY_PATH="${TARGET_PREFIX}/lib:${LD_LIBRARY_PATH}"
export PKG_CONFIG_PATH="${TARGET_PREFIX}/lib/pkgconfig"

if [ "${1}" == "--build-compiler" ]; then
	# Call the function with all the guts.
	buildCompiler
fi
