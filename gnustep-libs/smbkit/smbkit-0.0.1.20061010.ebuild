# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/smbkit/smbkit-0.0.1.20061010.ebuild,v 1.5 2014/08/10 21:18:30 slyfox Exp $

inherit gnustep-2

DESCRIPTION="SMBKit offers a samba library and headers for GNUstep"
HOMEPAGE="http://www.gnustep.org"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

KEYWORDS="amd64 ppc x86"
LICENSE="GPL-2 LGPL-2.1"
SLOT="0"

DEPEND="net-fs/samba"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"
