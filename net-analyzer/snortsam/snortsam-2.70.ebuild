# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/snortsam/snortsam-2.70.ebuild,v 1.8 2015/03/27 16:28:33 ago Exp $

EAPI=5

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="Snort plugin that allows automated blocking of IP addresses on several firewalls"
HOMEPAGE="http://www.snortsam.net/"
SRC_URI="${HOMEPAGE}files/snortsam/${PN}-src-${PV}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch
	ecvs_clean
}

src_configure() {
	use debug && append-cflags -DFWSAMDEBUG
	tc-export CC
}

src_compile() {
	sh makesnortsam.sh || die
}

src_install() {
	dobin snortsam
	find "${S}" -depth -type f -name "*.asc" -exec rm -f {} \;
	dodoc docs/* conf/*
}

pkg_postinst() {
	echo
	elog "To use snortsam with snort, you'll have to compile snort with USE=snortsam."
	elog "Read the INSTALL file to configure snort for snortsam, and configure"
	elog "snortsam for your particular firewall."
	echo
}
