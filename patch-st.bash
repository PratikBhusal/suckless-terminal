#!/usr/bin/env bash

if [ -d st-0.8.4/ ]; then
    echo "st folder already exists."
    read -r -p "Delete folder and re-patch? (y/N): " user_input

    if [[  -z "$user_input" ||  ! "$user_input" =~ (y|Y) ]]; then
        exit
    else
        echo "Deleting st-0.8.4 folder"
        \rm -rf st-0.8.4/
    fi
fi

git clone --depth 1 --branch 0.8.4 https://git.suckless.org/st st-0.8.4
ln -s ../config.h st-0.8.4/config.h

# Patch Suckless Simple Terminal {{{ --------------------------------------------
# Boxdraw {{{
if [ ! -s boxdraw.diff  ]; then
    curl \
        https://st.suckless.org/patches/boxdraw/st-boxdraw_v2-0.8.3.diff \
        -o boxdraw.diff
fi
cd st-0.8.4 \
    && git am -3 ../boxdraw.diff \
    && cd ../
# Boxdraw }}}
# Ligatures {{{
if [ -s custom-patches/st-ligatures-boxdraw-0.8.4.diff ]; then
    cd st-0.8.4 \
        && git am -3 ../custom-patches/st-ligatures-boxdraw-0.8.4.diff \
        && cd ../
fi
# Ligatures }}}
# Clipboard {{{
if [ -s custom-patches/st-clipboard-0.8.4.diff ]; then
    cd st-0.8.4 \
        && git am -3 ../custom-patches/st-clipboard-0.8.4.diff \
        && cd ../
fi
# Clipboard }}}
# Bold is Not Bright {{{
if [ ! -s bolt-is-not-bright.diff  ]; then
    curl \
        https://st.suckless.org/patches/bold-is-not-bright/st-bold-is-not-bright-20190127-3be4cf1.diff \
        -o bold-is-not-bright.diff
fi
cd st-0.8.4 \
    && git am -3 ../bold-is-not-bright.diff \
    && cd ../
# Bold is Not Bright }}}
# X Clear Window Before Redraw {{{
if [ ! -s xclearwin.diff  ]; then
    curl \
        https://st.suckless.org/patches/xclearwin/st-xclearwin-20200419-6ee7143.diff \
        -o xclearwin.diff
fi
cd st-0.8.4 \
    && git am -3 ../xclearwin.diff \
    && cd ../
# X Clear Window Before Redraw }}}
# Spoiler {{{
if [ -s custom-patches/st-spoiler-0.8.4.diff ]; then
    cd st-0.8.4 \
        && git am -3 ../custom-patches/st-spoiler-0.8.4.diff \
        && cd ../
fi
# Spoiler }}}
# XDG Desktop Entry {{{
if [ ! -s desktopentry.diff  ]; then
    curl \
        https://st.suckless.org/patches/desktopentry/st-desktopentry-0.8.4.diff \
        -o desktopentry.diff
fi

cd st-0.8.4 \
    && git am -3 ../desktopentry.diff \
    && cd ../
# XDG Desktop Entry }}}
# Net Window Manager Icon {{{
if [ ! -s netwmicon.diff  ]; then
    curl \
        https://st.suckless.org/patches/netwmicon/st-netwmicon-0.8.4.diff \
        -o netwmicon.diff
fi

cd st-0.8.4 \
    && git am -3 ../netwmicon.diff \
    && cd ../
# Net Window Manager Icon }}}
# Any Size {{{
if [ -s custom-patches/st-anysize-0.8.4.diff ]; then
    cd st-0.8.4 \
        && git am -3 ../custom-patches/st-anysize-0.8.4.diff \
        && cd ../
fi
# Any Size }}}
# Vertical Center {{{
if [ -s custom-patches/st-vertcenter-0.8.4.diff ]; then
    cd st-0.8.4 \
        && git am -3 ../custom-patches/st-vertcenter-0.8.4.diff \
        && cd ../
fi
# Vertical Center }}}
# Hide Cursor {{{
if [ -s custom-patches/st-hidecursor-0.8.4.diff ]; then
    cd st-0.8.4 \
        && git am -3 ../custom-patches/st-hidecursor-0.8.4.diff \
        && cd ../
fi
# Hide Cursor }}}
# Xresources {{{
if [ ! -s xresources.diff  ]; then
    curl \
        https://st.suckless.org/patches/xresources/st-xresources-20200604-9ba7ecf.diff \
        -o xresources.diff
fi
cd st-0.8.4 \
    && git apply -3 ../xresources.diff \
    && cd ../
# Xresources }}}
# Synchronized Rendering {{{
if [ ! -s appsync.diff  ]; then
    curl \
        https://st.suckless.org/patches/sync/st-appsync-20200618-b27a383.diff \
        -o appsync.diff
fi
cd st-0.8.4 \
    && git apply -3 ../appsync.diff \
    && cd ../
# Synchronized Rendering }}}
# Patch Suckless Simple Terminal }}} --------------------------------------------


# TODO: Patches to convert to git patch format

# TODO: universcroll (depends on scrollback, which is built in)
# TODO: ligatures (depends on scrollback & boxdraw patch)

# # Relative Border {{{
# if [ -s custom-patches/st-relativeborder-0.8.4.diff  ]; then
#     cd st-0.8.4 \
#         && git am -3 ../custom-patches/st-relativeborder-0.8.4.diff \
#         && cd ../
# fi
# # Relative Border }}}
# # Relative border {{{
# if [ ! -s relativeborder.diff  ]; then
#     curl \
#         https://st.suckless.org/patches/relativeborder/st-relativeborder-0.8.3.diff \
#         -o relativeborder.diff
# fi

# cd st-0.8.4 \
#     && git apply -3 ../relativeborder.diff \
#     && cd ../
# # Relative border }}}


# OPTIONAL: rightclickpaste - Might not need since tmux takes over right click.
# Default is middle click

# # OPTIONAL: W3M Images {{{
# if [ ! -s w3m.diff  ]; then
#     curl \
#         https://st.suckless.org/patches/w3m/st-w3m-0.8.3.diff \
#         -o w3m.diff
# fi
# cd st-0.8.4 \
#     && git am -3 ../w3m.diff \
#     && cd ../
# # OPTIONAL: W3M Images }}}


# OPTIONAL TODO: externalpipe (depends on scrollback, which is built in) - I don't
# have a use for it yet. I might in the future.
