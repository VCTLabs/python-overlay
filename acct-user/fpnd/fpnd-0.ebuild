# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-user

DESCRIPTION="user for fpnd daemon"
ACCT_USER_ID=229
ACCT_USER_GROUPS=( fpnd )

acct-user_add_deps
