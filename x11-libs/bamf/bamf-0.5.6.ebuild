# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.24
inherit autotools vala

DESCRIPTION="Removes the headache of applications matching into a simple DBus daemon and c wrapper library."
HOMEPAGE="https://launchpad.net/bamf"
SRC_URI="https://launchpad.net/bamf/0.5/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	$(vala_depend)
	>=sys-apps/dbus-1.8
	>=gnome-base/libgtop-2.0
	>=x11-libs/libwnck-3.4.7
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	default
	vala_setup
	eautoreconf
}

src_configure() {
	local econfargs=(
		VALA_API_GEN="${VAPIGEN}"
	)
	econf "${econfargs[@]}" "$@" || die
}