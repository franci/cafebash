#!/bin/bash
#   relame -- recompress .mp3 files using lame
#
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


if [ "$#" -ne 2 ]; then
  echo "relame v0.0.1 -- recompress .mp3 files using lame" >&2
  echo "Copyright (C) 2018 Francisco Gómez Carrasco" >&2
  echo "" >&2
  echo "usage: relame abr filename" >&2
  echo "" >&2
  exit 1
fi
if ! [ -e "$2" ]; then
  echo "$1 not found" >&2
  exit 1
fi
if [ -d "$2" ]; then
  echo "$1 is a directory" >&2
  exit 1
fi

echo "--------------------"

size0=`stat --printf="%s" "$2"`

echo "$2"

if [[ $size0 < 1 ]]; then
	exit 0
fi

lame --abr "$1" "$2" "$2.mp3" && mv "$2.mp3" "$2" || exit 1

size1=`stat --printf="%s" "$2"`

if [[ $size1 > 1024 && $size1 < size2 ]]; then
	exit 0
fi

echo -n "$size0 >>$1>> $size1"




