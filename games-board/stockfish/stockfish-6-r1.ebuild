# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/stockfish/stockfish-6-r1.ebuild,v 1.2 2015/02/07 16:00:50 yngwin Exp $

EAPI=5
if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://github.com/official-stockfish/Stockfish.git"
	KEYWORDS=""
	S=${WORKDIR}/${P}/src
else
	SRC_URI="https://stockfish.s3.amazonaws.com/${P}-src.zip"
	KEYWORDS="~amd64 ~x86"
	S=${WORKDIR}/${P}-src/src
fi

DESCRIPTION="Free UCI chess engine, claimed to be the strongest in the world"
HOMEPAGE="http://stockfishchess.org/"

LICENSE="GPL-3"
SLOT="0"
IUSE="armv7 cpu_flags_x86_avx2 cpu_flags_x86_popcnt cpu_flags_x86_sse debug
	general-32 general-64 +optimize"

DEPEND="|| ( app-arch/unzip
	app-arch/zip )"
RDEPEND=""

src_prepare() {
	# prevent pre-stripping
	sed -e 's:-strip $(BINDIR)/$(EXE)::' -i Makefile || die
}

src_compile() {
	local my_arch
	# generic unoptimized first
	use general-32 && my_arch=general-32
	use general-64 && my_arch=general-64
	# x86
	use x86 && my_arch=x86-32-old
	use cpu_flags_x86_sse && my_arch=x86-32
	# amd64
	use amd64 && my_arch=x86-64
	use cpu_flags_x86_popcnt && my_arch=x86-64-modern
	# both bmi2 and avx2 are part of hni (haswell new instructions)
	use cpu_flags_x86_avx2 && my_arch=x86-64-bmi2
	# other architectures
	use armv7 && my_arch=armv7
	use ppc && my_arch=ppc
	use ppc64 && my_arch=ppc64

	emake build ARCH=${my_arch} \
		debug=$(usex debug "yes" "no") \
		optimize=$(usex optimize "yes" "no")
}

src_install() {
	emake PREFIX="${D}/usr" install
	dodoc ../AUTHORS ../Readme.md
}
