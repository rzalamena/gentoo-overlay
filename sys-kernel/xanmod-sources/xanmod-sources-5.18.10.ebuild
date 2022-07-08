# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="13"
UNIPATCH_LIST="${UNIPATCH_LIST} ${DISTDIR}/patch-${PV}-xanmod1.xz "
K_SECURITY_UNSUPPORTED="1"

inherit kernel-2
detect_version
detect_arch

KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"
HOMEPAGE="https://xanmod.org"
LICENSE="${LICENSE} CDDL"

DESCRIPTION="Linux source with XanMod and Gentoo patchset"
SRC_URI="
	${KERNEL_URI}
	${GENPATCHES_URI}
	${ARCH_URI}
	https://github.com/xanmod/linux/releases/download/${OKV}-xanmod1/patch-${OKV}-xanmod1.xz
"

src_unpack() {
	# Remove patch version since XanMod includes it
	UNIPATCH_EXCLUDE=""
	for patchver in $(seq 1 ${KV_PATCH}); do
		base=$(expr 1000 + $(expr ${patchver} - 1))
		UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE} ${base}_linux-${KV_MAJOR}.${KV_MINOR}.${patchver}.patch"
	done

	# Remove patch already available
	UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE} 1950_cifs-fix-minor-compile-warning.patch"

	kernel-2_src_unpack
}

src_prepare() {
	# Reset extra version string
	sed -i -r 's/EXTRAVERSION = .+/EXTRAVERSION = /' "${S}/Makefile"

	kernel-2_src_prepare
}

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}

pkg_postrm() {
	kernel-2_pkg_postrm
}
