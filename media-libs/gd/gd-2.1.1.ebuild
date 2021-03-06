# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gd/gd-2.1.1.ebuild,v 1.4 2015/03/21 20:49:05 grobian Exp $

EAPI="5"

inherit libtool multilib-minimal

DESCRIPTION="A graphics library for fast image creation"
HOMEPAGE="http://libgd.org/ http://www.boutell.com/gd/"
SRC_URI="mirror://bitbucket/libgd/gd-libgd/downloads/lib${P}.tar.xz"

LICENSE="gd IJG HPND BSD"
SLOT="2/3"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="fontconfig jpeg png static-libs truetype webp xpm zlib"

# fontconfig has prefixed font paths, details see bug #518970
REQUIRED_USE="prefix? ( fontconfig )"

RDEPEND="fontconfig? ( >=media-libs/fontconfig-2.10.92[${MULTILIB_USEDEP}] )
	jpeg? ( >=virtual/jpeg-0-r2:0[${MULTILIB_USEDEP}] )
	png? ( >=media-libs/libpng-1.6.10:0[${MULTILIB_USEDEP}] )
	truetype? ( >=media-libs/freetype-2.5.0.1[${MULTILIB_USEDEP}] )
	webp? ( media-libs/libvpx[${MULTILIB_USEDEP}] )
	xpm? ( >=x11-libs/libXpm-3.5.10-r1[${MULTILIB_USEDEP}] >=x11-libs/libXt-1.1.4[${MULTILIB_USEDEP}] )
	zlib? ( >=sys-libs/zlib-1.2.8-r1[${MULTILIB_USEDEP}] )"
DEPEND="${RDEPEND}
	>=virtual/pkgconfig-0-r1[${MULTILIB_USEDEP}]"

S="${WORKDIR}/lib${P}"

src_prepare() {
	epatch "${FILESDIR}/${P}-headers.patch" #540376

	elibtoolize  # for shared library on Solaris
}

multilib_src_configure() {
	# we aren't actually {en,dis}abling X here ... the configure
	# script uses it just to add explicit -I/-L paths which we
	# don't care about on Gentoo systems.
	ECONF_SOURCE=${S} \
	econf \
		--without-x \
		$(use_enable static-libs static) \
		$(use_with fontconfig) \
		$(use_with png) \
		$(use_with truetype freetype) \
		$(use_with jpeg) \
		$(use_with webp vpx) \
		$(use_with xpm) \
		$(use_with zlib)
}

multilib_src_install_all() {
	dodoc NEWS README
	prune_libtool_files
}
