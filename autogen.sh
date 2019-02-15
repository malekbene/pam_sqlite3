#!/bin/sh
set -e

umask 022
touch ChangeLog
autoreconf -iv
