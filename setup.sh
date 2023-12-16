#!/usr/bin/env sh

if [ -d st-0.9/ ]; then
    echo "st folder already exists."
    printf "Delete folder and re-patch? (y/N): "
    read -r user_input

    if [  -z "$user_input" ] || echo "$user_input" | grep -E '^[^Yy]$' > /dev/null; then
        exit
    else
        echo "Deleting st-0.9 folder"
        \rm -rf st-0.9/
    fi
fi

# use --depth 2 when debugging
git clone --depth 1 --branch 0.9 https://git.suckless.org/st st-0.9
ln -s ../config.h st-0.9/config.h

# Patch Suckless Simple Terminal {{{ --------------------------------------------
# Boxdraw {{{
if [ -s custom-patches/st-boxdraw-0.9.diff ]; then
    cd st-0.9 \
        && git am -3 ../custom-patches/st-boxdraw-0.9.diff \
        && cd ../
fi
# Boxdraw }}}
# Ligatures {{{
if [ -s custom-patches/st-ligatures-boxdraw-0.9.diff ]; then
    cd st-0.9 \
        && git am -3 ../custom-patches/st-ligatures-boxdraw-0.9.diff \
        && cd ../
fi
# Ligatures }}}
# Clipboard {{{
if [ -s custom-patches/st-clipboard-0.9.diff ]; then
    cd st-0.9 \
        && git am -3 ../custom-patches/st-clipboard-0.9.diff \
        && cd ../
fi
# Clipboard }}}
# Bold is Not Bright {{{
if [ ! -s bold-is-not-bright.diff  ]; then
    curl \
        https://st.suckless.org/patches/bold-is-not-bright/st-bold-is-not-bright-20190127-3be4cf1.diff \
        -o bold-is-not-bright.diff
fi
cd st-0.9 \
    && git am -3 ../bold-is-not-bright.diff \
    && cd ../
# Bold is Not Bright }}}
# X Clear Window Before Redraw {{{
if [ -s custom-patches/st-xclearwin-0.9.diff ]; then
    cd st-0.9 \
        && git am -3 ../custom-patches/st-xclearwin-0.9.diff \
        && cd ../
fi
# X Clear Window Before Redraw }}}
# Spoiler {{{
if [ -s custom-patches/st-spoiler-0.9.diff ]; then
    cd st-0.9 \
        && git am -3 ../custom-patches/st-spoiler-0.9.diff \
        && cd ../
fi
# Spoiler }}}
# XDG Desktop Entry {{{
if [ ! -s desktopentry.diff  ]; then
    curl \
        https://st.suckless.org/patches/desktopentry/st-desktopentry-0.8.5.diff \
        -o desktopentry.diff
fi

cd st-0.9 \
    && git am -3 ../desktopentry.diff \
    && cd ../
# XDG Desktop Entry }}}
# Net Window Manager Icon {{{
if [ ! -s st.png  ]; then
    curl -O \
        https://st.suckless.org/patches/netwmicon/st.png
fi
cp st.png st-0.9/

if [ -s custom-patches/st-netwmicon-0.9.diff ]; then
    cd st-0.9 \
        && git am -3 ../custom-patches/st-netwmicon-0.9.diff \
        && cd ../
fi
# Net Window Manager Icon }}}
# Any Size {{{
if [ -s custom-patches/st-anysize-0.9.diff ]; then
    cd st-0.9 \
        && git am -3 ../custom-patches/st-anysize-0.9.diff \
        && cd ../
fi
# Any Size }}}
# Vertical Center {{{
if [ -s custom-patches/st-vertcenter-0.9.diff ]; then
    cd st-0.9 \
        && git am -3 ../custom-patches/st-vertcenter-0.9.diff \
        && cd ../
fi
# Vertical Center }}}
# Hide Cursor {{{
if [ -s custom-patches/st-hidecursor-0.9.diff ]; then
    cd st-0.9 \
        && git am -3 ../custom-patches/st-hidecursor-0.9.diff \
        && cd ../
fi
# Hide Cursor }}}
# Xresources {{{
if [ -s custom-patches/st-xresources-0.9.diff ]; then
    cd st-0.9 \
        && git am -3 ../custom-patches/st-xresources-0.9.diff \
        && cd ../
fi
# Xresources }}}
# Synchronized Rendering {{{
if [ -s custom-patches/st-appsync-0.9.diff ]; then
    cd st-0.9 \
        && git am -3 ../custom-patches/st-appsync-0.9.diff \
        && cd ../
fi
# Synchronized Rendering }}}
# Patch Suckless Simple Terminal }}} --------------------------------------------


# TODO: Patches to convert to git patch format

# TODO: universcroll (depends on scrollback, which is built in)
# TODO: ligatures (depends on scrollback & boxdraw patch)

# # Relative Border {{{
# if [ -s custom-patches/st-relativeborder-0.9.diff  ]; then
#     cd st-0.9 \
#         && git am -3 ../custom-patches/st-relativeborder-0.9.diff \
#         && cd ../
# fi
# # Relative Border }}}
# # Relative border {{{
# if [ ! -s relativeborder.diff  ]; then
#     curl \
#         https://st.suckless.org/patches/relativeborder/st-relativeborder-0.9.diff \
#         -o relativeborder.diff
# fi

# cd st-0.9 \
#     && git apply -3 ../relativeborder.diff \
#     && cd ../
# # Relative border }}}
# # Wide Glyphs - disabled due to difficulties patching on top of ligatures {{{
# if [ -s custom-patches/st-wideglyph-0.9.diff ]; then
#     cd st-0.9 \
#         && git am -3 ../custom-patches/st-wideglyph-0.9.diff \
#         && cd ../
# fi
# # Wide Glyphs - disabled due to difficulties patching on top of ligatures }}}

# OPTIONAL: rightclickpaste - Might not need since tmux takes over right click.
# Default is middle click

# # OPTIONAL: W3M Images {{{
# if [ ! -s w3m.diff  ]; then
#     curl \
#         https://st.suckless.org/patches/w3m/st-w3m-0.9.diff \
#         -o w3m.diff
# fi
# cd st-0.9 \
#     && git am -3 ../w3m.diff \
#     && cd ../
# # OPTIONAL: W3M Images }}}


# OPTIONAL TODO: externalpipe (depends on scrollback, which is built in) - I don't
# have a use for it yet. I might in the future.
