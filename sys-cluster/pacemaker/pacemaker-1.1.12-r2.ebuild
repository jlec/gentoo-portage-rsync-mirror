# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/pacemaker/pacemaker-1.1.12-r2.ebuild,v 1.4 2015/04/02 16:44:39 jer Exp $

EAPI="5"
PYTHON_COMPAT=( python2_7 )
WANT_AUTOMAKE="1.12"

inherit autotools eutils python-single-r1

MY_PN="Pacemaker"
MY_P=${MY_PN}-${PV/_/-}

DESCRIPTION="Pacemaker CRM"
HOMEPAGE="http://www.linux-ha.org/wiki/Pacemaker"
SRC_URI="https://github.com/ClusterLabs/${PN}/archive/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa x86"
REQUIRED_USE="cman? ( !heartbeat )"
IUSE="acl cman heartbeat smtp snmp static-libs"

DEPEND="${PYTHON_DEPS}
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt
	sys-cluster/cluster-glue
	>=sys-cluster/libqb-0.14.0
	sys-cluster/resource-agents
	cman? ( sys-cluster/cman )
	heartbeat? ( >=sys-cluster/heartbeat-3.0.0 )
	!heartbeat? ( sys-cluster/corosync )
	smtp? ( net-libs/libesmtp )
	snmp? ( net-analyzer/net-snmp )
"
RDEPEND="${DEPEND}"

REQUIRED_USE=${PYTHON_REQUIRED_USE}

PATCHES=(
	"${FILESDIR}"/pacemaker-1.1.10-tinfo.patch
	"${FILESDIR}"/pacemaker-1.1.12-glib.patch
	"${FILESDIR}"/pacemaker-1.1.12-stonith.patch
)

S="${WORKDIR}/${PN}-${MY_P}"

src_prepare() {
	epatch "${PATCHES[@]}"
	epatch_user

	# bug #490908
	cp "${FILESDIR}/ping" extra/resources/ping || die

	sed -i -e "/ggdb3/d" configure.ac || die
	sed -i -e "s/ -ggdb//g" configure.ac || die
	sed -i -e "s/uid2username(uid)/uid2username(uid_client)/g" lib/common/ipc.c || die
	sed -i -e "s:<glib/ghash.h>:<glib.h>:" lib/ais/plugin.c || die
	eautoreconf

	python_fix_shebang .
}

src_configure() {
	local myopts=""
	if use heartbeat ; then
		myopts="--without-corosync"
	else
		myopts="--with-ais"
	fi
	# appends lib to localstatedir automatically
	econf \
		--libdir=/usr/$(get_libdir) \
		--localstatedir=/var \
		--disable-dependency-tracking \
		--disable-fatal-warnings \
		$(use_with acl) \
		$(use_with cman cs-quorum) \
		$(use_with cman cman) \
		$(use_with heartbeat) \
		$(use_with smtp esmtp) \
		$(use_with snmp) \
		$(use_enable static-libs static) \
		${myopts}
}

src_install() {
	default
	rm -rf "${D}"/var/run "${D}"/etc/init.d
	newinitd "${FILESDIR}/${PN}.initd" ${PN} || die
	if has_version "<sys-cluster/corosync-2.0"; then
		insinto /etc/corosync/service.d
		newins "${FILESDIR}/${PN}.service" ${PN} || die
	fi
}

pkg_postinst() {
	elog " "
	elog "Looking for the crm CLI ? emerge sys-cluster/crmsh !"
	elog " "
}
