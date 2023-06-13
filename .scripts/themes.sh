#!/usr/bin/env bash

## Set GTK Themes, Icons, Cursor and Fonts

THEME='Gruvbox-Dark-BL-LB'
ICONS='MacBuntu-Mine-Y'
FONT='更纱黑体 UI SC 12'
CURSOR='Azenis'

SCHEMA='gsettings set org.gnome.desktop.interface'

apply_themes() {
	${SCHEMA} gtk-theme "$THEME"
	${SCHEMA} icon-theme "$ICONS"
	${SCHEMA} cursor-theme "$CURSOR"
	${SCHEMA} font-name "$FONT"
}

apply_themes