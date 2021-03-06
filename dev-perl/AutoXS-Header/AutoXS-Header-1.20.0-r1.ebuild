# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/AutoXS-Header/AutoXS-Header-1.20.0-r1.ebuild,v 1.1 2014/08/22 17:33:37 axs Exp $

EAPI=5

MODULE_AUTHOR=SMUELLER
MODULE_VERSION=1.02
inherit perl-module

DESCRIPTION="Container for the AutoXS header files"

SLOT="0"
KEYWORDS="amd64 ppc x86 ~ppc-aix ~ppc-macos ~x86-solaris"
IUSE=""

SRC_TEST=do
