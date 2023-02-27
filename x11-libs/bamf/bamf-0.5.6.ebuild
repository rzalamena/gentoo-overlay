# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.24

inherit autotools vala

DESCRIPTION="Wrapper library to simplify window matching"
HOMEPAGE="https://launchpad.net/bamf"
SRC_URI="https://launchpad.net/bamf/$(ver_cut 1-2)/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="introspection static-libs"

DEPEND="
	$(vala_depend)
	>=sys-apps/dbus-1.8
	>=gnome-base/libgtop-2.0
	>=x11-libs/libwnck-3.4.7
	>=x11-libs/startup-notification-0.12
"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	vala_setup
	eautoreconf
}

src_configure() {
	local econfargs=(
		VALA_API_GEN="${VAPIGEN}"
		$(use_enable introspection)
	)
	econf "${econfargs[@]}" "$@" || die
}

src_install() {
	default
	if ! use static-libs ; then
		find "${ED}" -type f -name "*.la" -delete || die
	fi
}
