# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Flashing tool using block maps and sparse files"
HOMEPAGE="https://github.com/intel/bmap-tools"

if [[ ${PV} = 9999* ]]; then
	EGIT_REPO_URI="https://github.com/intel/bmap-tools.git"
	EGIT_BRANCH="master"
	inherit git-r3
else
	SRC_URI="https://github.com/intel/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="test"

BDEPEND="${PYTHON_DEPS}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}] )
"

RDEPEND="
	app-arch/pigz
	app-arch/lzop
	app-arch/lz4
	app-arch/pbzip2
	app-arch/xz-utils
	app-arch/bzip2
	app-arch/gzip
	app-arch/tar
"

DOCS=( "${S}/docs/README" )

# tests are hanging using default below
RESTRICT="!test? ( test )"

distutils_enable_tests nose

python_test() {
	# remaining tests involve way too much file I/O
	nosetests -sx --verbosity=3 --detailed-errors \
		tests/test_bmap_helpers.py \
		tests/test_compat.py || die "Tests fail with ${EPYTHON}"
}
