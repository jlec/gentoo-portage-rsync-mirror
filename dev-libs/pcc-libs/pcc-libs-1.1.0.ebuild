# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pcc-libs/pcc-libs-1.1.0.ebuild,v 1.1 2014/12/29 02:51:41 patrick Exp $

EAPI=5

inherit eutils versionator

DESCRIPTION="pcc compiler support libs"
HOMEPAGE="http://pcc.ludd.ltu.se"

SRC_URI="ftp://pcc.ludd.ltu.se/pub/pcc-releases/${P}.tgz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~amd64-fbsd"

IUSE=""
DEPEND=""
RDEPEND="${DEPEND}"
S=${WORKDIR}/${PN}-${PVR/*_pre/}/

src_compile() {
	# not parallel-safe yet
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
