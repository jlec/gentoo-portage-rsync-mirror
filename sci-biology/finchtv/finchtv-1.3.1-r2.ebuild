# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/finchtv/finchtv-1.3.1-r2.ebuild,v 1.1 2015/04/07 08:00:34 jlec Exp $

EAPI=5

MY_PV="${PV//./_}"
MY_P=${PN}_${MY_PV}

DESCRIPTION="Graphical viewer for chromatogram files"
HOMEPAGE="http://www.geospiza.com/finchtv/"
SRC_URI="http://www.geospiza.com/finchtv/download/programs/linux/${MY_P}.tar.gz"

LICENSE="finchtv"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

S="${WORKDIR}/${MY_P}"

QA_PREBUILT="opt/bin/*"

src_install() {
	exeinto /opt/bin
	doexe finchtv
	dodoc ReleaseNotes.txt
	dohtml -r Help/*
	insinto /usr/share/doc/${PN}
	doins -r SampleData
}
