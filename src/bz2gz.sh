#!/bin/bash
#   bz2gz -- compress a file to .bz2 and .gz and keeps the smallest
#   Copyright (C) 2018 Francisco Gómez Carrasco
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.


if [ "$#" -ne 1 ]; then
  echo "bz2g v0.0.1 -- compress a file to .bz2 and .gz and keeps the smallest one" >&2
  echo "Copyright (C) 2018 Francisco Gómez Carrasco" >&2
  echo "" >&2
  echo "usage: bz2g filename" >&2
  echo "" >&2
  exit 1
fi
if ! [ -e "$1" ]; then
  echo "$1 not found" >&2
  exit 1
fi
if [ -d "$1" ]; then
  echo "$1 is a directory" >&2
  exit 1
fi

echo "--------------------"

size0=`stat --printf="%s" "$1"`

echo "$1"

if [[ $size0 < 1 ]]; then
	exit 0
fi

gzip -n9k "$1" && bzip2 -9 "$1" || exit 1

size1=`stat --printf="%s" "$1.gz"`
size2=`stat --printf="%s" "$1.bz2"`

echo -n "$size0 >> .gz=$size1 >> .bz2: $size2 "

if [[ $size1 < 1 ]]; then
	exit 1
fi

if [[ $size2 < 1 ]]; then
	exit 1
fi

if [[ $size1 > $size2 ]]; then
	rm "$1.gz"
	echo ">>>> .bz2"
else
	rm "$1.bz2"
	echo ">>>> .gz"
fi

