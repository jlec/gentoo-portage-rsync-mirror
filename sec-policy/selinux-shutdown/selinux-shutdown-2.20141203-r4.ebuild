# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-shutdown/selinux-shutdown-2.20141203-r4.ebuild,v 1.1 2015/03/22 13:47:19 swift Exp $
EAPI="5"

IUSE=""
MODS="shutdown"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for shutdown"

if [[ $PV == 9999* ]] ; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
fi
