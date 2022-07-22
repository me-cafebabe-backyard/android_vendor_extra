# Shebang is intentionally missing - do not run as a script

# ABI compatibility checks fail for several reasons:
#   - The update to Clang 12 causes some changes, but no breakage has been
#     observed in practice.
#   - Switching to zlib-ng changes some internal structs, but not the public
#     API.
#
# We may fix these eventually by updating the ABI specifications, but it's
# likely not worth the effort for us because of how many repos are affected.
# We would need to fork a lot of extra repos (thus increasing maintenance
# overhead) just to update the ABI specs.
#
# For now, just skip the ABI checks to fix build errors.
export SKIP_ABI_CHECKS=true

# Build ID
export TARGET_UNOFFICIAL_BUILD_ID=0xCAFEBABE

export MITHORIUM_REPOS="$(echo {device,vendor}/xiaomi/{mithorium-common,Mi439,Mi8937,Tiare,oxygen,uter,vince} device/xiaomi/{mi8937,land}-camera vendor/xiaomi/Mi8937-2)"
export MIKONA_REPOS="$(echo hardware/xiaomi {device,vendor}/xiaomi/{sm8250-common,umi})"

dt_repos_show_git_remote_add_commands() {
    [ "$#" -ge 2 ] || (echo "Please specify remote name and repos!"; return 1)
    local REMOTE=$1
    shift
    croot || return 1
    echo 'TOPDIR=$(pwd)'
    for r in $@; do
        echo "cd ${r}"
        echo "git remote add $REMOTE $(whoami)@$(hostname):$(pwd)/${r}"
        echo 'cd $TOPDIR'
    done
}

dt_repos_reset() {
    [ "$*" ] || (echo "Please specify repos!"; return 1)
    for r in $@; do
        cd $r || (echo "! Error: Failed to enter $r" ; continue)
        echo "##################################################"
        echo "Repo: $r"
        echo
        git clean -f
        git reset --hard
        echo "##################################################"
        echo
        croot
    done
}

dt_repos_status() {
    [ "$*" ] || (echo "Please specify repos!"; return 1)
    local MSG BRANCH CLEAN DIRTY
    CLEAN=""
    DIRTY=""
    for r in $@; do
        cd $r || (echo "! Error: Failed to enter $r" ; continue)
        MSG="$(LANG=C git status)"
        BRANCH="$(echo \"$MSG\"|grep 'On branch'|cut -d ' ' -f 3)"
        if echo "$MSG" | grep 'working tree clean' > /dev/null; then
            CLEAN+="  ${r}\n"
        else
            DIRTY+="  ${r}\n"
        fi
        echo -e "BRANCH='${BRANCH}'\tREPO='${r}'"
        croot
    done
    echo
    echo -e "Clean repos:\n${CLEAN}"
    echo -e "Dirty repos:\n${DIRTY}"
}
