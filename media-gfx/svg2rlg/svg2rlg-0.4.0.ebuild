# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )
DISTUTILS_USE_SETUPTOOLS=pyproject.toml

inherit distutils-r1

DESCRIPTION="Converts SVG files to PDFs or reportlab graphics"
HOMEPAGE="https://github.com/sarnold/svg2rlg https://pypi.python.org/pypi/svg2rlg/"

if [[ ${PV} = 9999* ]]; then
	EGIT_REPO_URI="https://github.com/sarnold/svg2rlg.git"
	EGIT_BRANCH="master"
	inherit git-r3
else
	SRC_URI="https://github.com/sarnold/${PN}/archive/${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="BSD"
SLOT="0"

RDEPEND="${PYTHON_DEPS}"

DEPEND="${PYTHON_DEPS}
	dev-python/reportlab[${PYTHON_USEDEP}]
"

distutils_enable_tests nose

python_test() {
	nosetests -sx test_svg2rlg.py || die "Test failed with ${EPYTHON}"
}
