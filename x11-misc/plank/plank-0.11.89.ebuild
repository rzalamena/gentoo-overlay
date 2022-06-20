# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.24
inherit autotools gnome2 vala

DESCRIPTION="Plank the simplest dock on the planet"
HOMEPAGE="https://launchpad.net/plank"
SRC_URI="https://launchpad.net/plank/1.0/${PV}/+download/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

DEPEND="
	$(vala_depend)
	>=x11-libs/bamf-0.5.0
	>=gnome-base/gnome-menus-3.0
	>=dev-libs/libgee-0.8
"
RDEPEND="${DEPEND}"
BDEPEND="
	nls? ( sys-devel/gettext )
"

src_prepare() {
	default
	vala_setup
	eautoreconf
}

src_configure() {
	gnome2_src_configure $(use_enable nls)
}
