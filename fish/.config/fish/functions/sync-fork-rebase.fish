function sync-fork-rebase
    # 1. Check for 'upstream' remote
    if not git remote | grep -q upstream
        echo (set_color red)"Error:"(set_color normal) "The 'upstream' remote is not configured."
        echo "Please run: git remote add upstream <URL_of_original_repo>"
        return 1
    end

    set -l default_branch (git symbolic-ref --short HEAD 2>/dev/null)
    if [ -z "$default_branch" ]
        echo (set_color red)"Error:"(set_color normal) "Could not determine current branch. Please 'git checkout' a branch first."
        return 1
    end

    echo (set_color cyan)"🔄 Syncing fork branch '$default_branch' with upstream..."(set_color normal)

    # 2. Fetch upstream changes
    if not git fetch upstream
        echo (set_color red)"Error:"(set_color normal) "Failed to fetch from upstream."
        return 1
    end

    # 3. Rebase onto upstream branch
    # Note: Assumes the upstream branch is also named 'main' or whatever your current branch is.
    if not git rebase upstream/$default_branch
        echo (set_color red)"Error:"(set_color normal) "Rebase failed. Please resolve conflicts and run 'git rebase --continue'."
        return 1
    end

    # 4. Force push to origin (your fork)
    echo (set_color yellow)"⚠️ Force pushing rewritten history to origin/$default_branch..."(set_color normal)
    if not git push --force-with-lease origin $default_branch
        echo (set_color red)"Error:"(set_color normal) "Force push failed. Your local branch is rebased, but the remote is not updated."
        return 1
    end

    echo (set_color green)"✅ Success! Fork '$default_branch' is now clean and in sync with upstream."(set_color normal)
end
