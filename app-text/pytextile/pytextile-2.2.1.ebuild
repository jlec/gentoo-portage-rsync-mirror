# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pytextile/pytextile-2.2.1.ebuild,v 1.2 2014/11/11 01:07:46 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy )

inherit distutils-r1

MY_PN="textile"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A Python implementation of Textile, Dean Allen's Human Text Generator for creating (X)HTML"
HOMEPAGE="http://github.com/textile/python-textile"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"
RDEPEND="
	dev-python/regex[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"

python_prepare_all() {
	# This resolves a nasty race condition, courtesy of Arfrever
	sed -e 's:with-id = 1::' -i setup.cfg || die
	distutils-r1_python_prepare_all
}

python_test() {
	nosetests textile/tests/ || die "Tests failed under ${EPYTHON}"
}
