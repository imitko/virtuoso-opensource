#! /bin/sh
#
#  autogen.sh
#
#  Bootstrap the project so we do not need to maintain the
#  files generated by autoconf, automake and libtool
#  
#  This file is part of the OpenLink Software Virtuoso Open-Source (VOS)
#  project.
#  
#  Copyright (C) 1998-2022 OpenLink Software
#  
#  This project is free software; you can redistribute it and/or modify it
#  under the terms of the GNU General Public License as published by the
#  Free Software Foundation; only version 2 of the License, dated June 1991.
#  
#  This program is distributed in the hope that it will be useful, but
#  WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
#  General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License along
#  with this program; if not, write to the Free Software Foundation, Inc.,
#  51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
#  
#  

# ----------------------------------------------------------------------
#  Globals
# ----------------------------------------------------------------------
DIE=0
ELINES=3


# ----------------------------------------------------------------------
#  Fix issues with LOCALE
# ----------------------------------------------------------------------
LANG=C
LC_ALL=POSIX
export LANG LC_ALL


# ----------------------------------------------------------------------
#  Color settings
# ----------------------------------------------------------------------
B=`tput bold 2>/dev/null`
N=`tput sgr0 2>/dev/null`

ERROR="${B}** ERROR **${N}"
WARNING="${B}* WARNING *${N}"


# ----------------------------------------------------------------------
#  Functions
# ----------------------------------------------------------------------
CHECK() {
    cmd=$1
    shift

    for PROG in $*
    do
	VERSION=`$PROG $cmd 2>/dev/null | head -1`
	if test \! -z "$VERSION"
	then
	    echo "Using $VERSION"
	    USE_PROG=$PROG
	    break
	fi
    done

    if test -z "$VERSION"
    then
	echo
	echo "${ERROR} : You must have \`${B}${PROG}${N}' installed on your system."
	echo
	DIE=1
    fi
}


RUN() {
    PROG=$1; shift
    ARGS=$*

    echo "Running ${B}${PROG}${N} ..."
    $PROG $ARGS 2>> autogen.log
    if test $? -ne 0
    then
	echo
	echo "${ERROR}"
	tail -$ELINES autogen.log
	echo
	echo "Bootstrap script aborting (see autogen.log for details) ..."
	exit 1
    fi
}


#
#  Check availability of build tools
#
echo
echo "${B}Checking build environment${N} ..."

CHECK --version aclocal
CHECK --version autoconf
CHECK --version autoheader
CHECK --version automake
CHECK --version libtoolize glibtoolize; LIBTOOLIZE=$USE_PROG

CHECK --version bison
CHECK --version flex
CHECK --version gawk
CHECK --version gperf

CHECK version openssl

if test "$DIE" -eq 1
then
    echo
    echo "Please read the ${B}README${N} file for a list of packages you need"
    echo "to install on your system before bootstrapping this project."
    echo
    echo "Bootstrap script aborting ..."
    exit 1
fi


#
#  Generate the build scripts
#
> autogen.log

echo
echo "${B}Generating build scripts${N} ..."

RUN $LIBTOOLIZE --force --copy
RUN aclocal -I binsrc/config
RUN autoheader
RUN automake --copy --add-missing
RUN autoconf

echo
echo "Please check the ${B}INSTALL${N} and ${B}README${N} files for instructions to"
echo "configure, build and install Virtuoso on your system."
echo
echo "Certain build targets are only enabled in maintainer mode:"
echo
echo "    ./configure --enable-maintainer-mode ..."
echo
echo "Bootstrap script completed successfully."

exit 0
