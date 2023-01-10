# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit autotools multilib-minimal

DESCRIPTION="VDPAU Backend for Video Acceleration (VA) API"
HOMEPAGE="https://github.com/rzalamena/libva-vdpau-driver"

SRC_URI="https://github.com/rzalamena/${PN}/archive/refs/tags/${PV}.tar.gz"
KEYWORDS="~amd64 ~arm64 ~riscv ~x86"

LICENSE="GPL-2"
SLOT="0"
IUSE="debug static-libs"

RDEPEND="
	>=media-libs/libva-2.0:=[X,${MULTILIB_USEDEP}]
	>=x11-libs/libvdpau-0.9[${MULTILIB_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

DOCS=( NEWS README AUTHORS )

src_prepare() {
	default
	eautoreconf
}

multilib_src_configure() {
	local myeconfargs=(
		$(use_enable debug)
	)

	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}

multilib_src_install_all() {
	einstalldocs

	if ! use static-libs ; then
		find "${ED}" -type f -name "*.la" -delete || die
	fi
}
