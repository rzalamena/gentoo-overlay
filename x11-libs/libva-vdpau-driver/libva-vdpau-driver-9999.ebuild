# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit autotools multilib-minimal

DESCRIPTION="VDPAU Backend for Video Acceleration (VA) API"
HOMEPAGE="https://gitlab.com/rzalamena/libva-vdpau-driver"

if [[ ${PV} = *9999 ]] ; then
	inherit git-r3
	EGIT_BRANCH=master
	EGIT_REPO_URI="https://gitlab.com/rzalamena/libva-vdpau-driver.git"
else
	SRC_URI="https://www.freedesktop.org/software/vaapi/releases/libva-vdpau-driver/${P}.tar.bz2"
	KEYWORDS="~amd64 ~arm64 ~riscv ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="debug opengl"

RDEPEND="
	>=x11-libs/libva-2.0:=[X,opengl?,${MULTILIB_USEDEP}]
	>=x11-libs/libvdpau-0.9[${MULTILIB_USEDEP}]
	opengl? ( >=virtual/opengl-7.0-r1[${MULTILIB_USEDEP}] )
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
		$(use_enable opengl glx)
	)

	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}
