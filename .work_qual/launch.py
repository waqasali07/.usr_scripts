#!/usr/bin/python
LAUNCH_BRANCH_NAME = "launch/SYNC-v1.3.0"
from git import Repo, GitCommandError
from os import getcwd
import re
import sys
from contextlib import suppress
try:
    import sh
except ImportError:
    # fallback: emulate the sh API with pbs
    import pbs
    class Sh(object):
        def __getattr__(self, attr):
            return pbs.Command(attr)
    sh = Sh()

repo = Repo(getcwd())
_git = repo.git

def pull_from_remote(git_cmd):
    with suppress(Exception):
        git_cmd.pull()

def push_launch_branch(git_cmd, launch_branch):
    # Push the launch branch
    git_cmd.push("-u", "-f", "origin", launch_branch)
    # Delete the temp local branch
    print("Launch Branch Pushed to Remote Repo....", flush=True)

def find_commit_id(pr_num, git_cmd):
    print("Checking out master and pull the changes")
    git_cmd.checkout("master")
    pull_from_remote(git_cmd)
    print("Finding the Squashed commit ID", flush=True)
    commits = git_cmd.log("--graph", "--decorate", "--oneline").split("\n")
    for commit in commits:
        commit_info = commit.split(" ")
        if commit_info:
            last_word = commit_info[-1]
        else:
            continue
        # remove bracket and # sign
        number = re.findall('\d+', last_word )
        if number and number[0] == str(pr_num):
            return commit_info[1]

def create_launch_branch(git_cmd, int_branch):
    launch_branch = f"launch_{int_branch}"
    # Create branch to be raised against launch branch
    try:
        print(f"Create {launch_branch}", flush=True)
        git_cmd.checkout("-b", launch_branch, f"origin/{LAUNCH_BRANCH_NAME}")
    except Exception:
        git_cmd.checkout(int_branch)
        with suppress(Exception):
            git_cmd.branch("-D", launch_branch)
        git_cmd.checkout("-b", launch_branch, f"origin/{LAUNCH_BRANCH_NAME}")
    print(f"Created Launch Branch {launch_branch}...", flush=True)
    return launch_branch

def process_with_commit_id(commit_id, sh_cmd, git_cmd, launch_branch):
    try:
        if not sh_cmd:
            git_cmd.cherry_pick(commit_id)
        else:
            sh.git("cherry-pick", commit_id)
    except Exception as e:
        print(f"Conflict while cherry picking {commit_id}. Resolve and try again")
        if not sh_cmd:
            git_cmd.cherry_pick("--abort")
        else:
            sh.git("cherry-pick", "--abort")
        return
        # Push the launch branch
    push_launch_branch(git_cmd, launch_branch)
    print(f"PR is ready to be raised against {LAUNCH_BRANCH_NAME} "
          f"with branch name {launch_branch}!!", flush=True)

def process_unmerged_branch(int_branch, git_cmd, sh_cmd):
    update_master(git_cmd)
    print(f"Cherry picking the changes from branch: {int_branch}")
    git_cmd.checkout(int_branch)
    pull_from_remote(git_cmd)
    print("Soft Resetting to master..")
    git_cmd.reset("--soft", "master")
    print(f"Squashing the commits from {int_branch}")
    git_cmd.commit("-a", "-m", "Squashing commits")
    commit_id = _git.rev_parse("HEAD").split()[0]
    launch_branch = create_launch_branch(git_cmd, int_branch)
    process_with_commit_id(commit_id, sh_cmd, git_cmd, launch_branch)

def update_master(git_cmd):
    print("Updating master...")
    git_cmd.checkout("master")
    git_cmd.pull()

def run():
    sh_cmd = False
    try:
        if len(sys.argv) > 2:
            print('You have specified too many arguments', flush=True)
            sys.exit()
        elif len(sys.argv) == 2:
            if sys.argv[1] == "-sh":
                print("Running the script in Bash shell", flush=True)
                git_cmd = sh.git.bake(_cwd=getcwd())
                sh_cmd = True
            else:
                print('Invalid option: Valid option is "-sh". '
                      'Use this if you are running the script in bash shell', flush=True)
                sys.exit()
        else:
            print("Running the script in CMD", flush=True)
            git_cmd = repo.git
        print("Fetching from remote", flush=True)
        git_cmd.fetch()
        # Get GIT command line
        print("Get the Integration branch name", flush=True)
        int_branch = _git.rev_parse("--abbrev-ref", "HEAD")
        print(f"Changes from {int_branch} will be cherry picked to launch_{int_branch}")
        print(f"If the branch you are intending to cherry-pick changes is not {int_branch}, stop the script, "
              f"Checkout the intended branch and then re-run the script")
        print("===========================================================================================")
        print(f"Fetching the changes from remote {int_branch}")
        commit_id = input("Enter the COMMIT_ID of Integration Branch "
                          "IF THE PR IS MERGED to Master else press Enter to continue..: ")
        if commit_id:
            print(f"commit id is: {commit_id}", flush=True)
            launch_branch = create_launch_branch(git_cmd, int_branch)
            process_with_commit_id(commit_id, sh_cmd, git_cmd, launch_branch)
        else:
            process_unmerged_branch(int_branch, git_cmd, sh_cmd)
    except Exception as e:
        print(e)
    finally:
        with suppress(Exception):
            git_cmd.checkout(int_branch)
        sys.exit()


if __name__ == "__main__":
    run()
