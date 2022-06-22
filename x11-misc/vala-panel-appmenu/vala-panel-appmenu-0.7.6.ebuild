# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.24

inherit gnome2 meson vala

DESCRIPTION="Global Menu for Vala Panel (and xfce4-panel and mate-panel)"
HOMEPAGE="https://gitlab.com/vala-panel-project/vala-panel-appmenu"
SRC_URI="https://gitlab.com/vala-panel-project/${PN}/-/archive/${PV}/${P}.tar.bz2"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bamf mate xfce"

DEPEND="
	$(vala_depend)
	bamf? ( >=x11-libs/bamf-0.5.0 )
	!bamf? ( >=x11-libs/libwnck-3.4.8 )
	mate? ( >=mate-base/mate-panel-1.20 )
	xfce? ( >=xfce-base/xfce4-panel-4.12 )
	>=x11-libs/gtk+-3.22.0
"
RDEPEND="${RDEPEND}"
BDEPEND="
	sys-devel/gettext
"

PATCHES=(
	"${FILESDIR}"/${P}-fix-configure.patch
)

src_prepare() {
	default
	vala_setup
}

src_configure() {
	emesonargs=(
		-Dwm_backend=$(usex bamf bamf wnck)
		$(meson_feature mate)
		$(meson_feature xfce)
		-Dappmenu-gtk-module=enabled
	)

	meson_src_configure
}

pkg_preinst() {
	gnome2_pkg_preinst
}

pkg_postinst() {
	gnome2_pkg_postinst
}

pkg_postrm() {
	gnome2_pkg_postrm
}
