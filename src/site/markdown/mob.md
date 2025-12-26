# Mob

## Information

A collaboration tool for **remote pair or mob programming**.
Automates git handovers and branch management for TDD / ping-pong style development.

## Installation

```shell
su -
curl -sL install.mob.sh | sh
```

## Configuration

If your Git server does not support the --push-option ci.skip option (e.g. Bitbucket), disable it:

```shell
# *nix
export MOB_SKIP_CI_PUSH_OPTION_ENABLED=false
# Windows
set MOB_SKIP_CI_PUSH_OPTION_ENABLED=false
```

### Coding tips and tricks

Usual workflow

Start a timer (optional) to coordinate rotations (for example, "mobelisk-company-name"):

[timer.mob.sh](https://timer.mob.sh/)

```shell
export MOB_TIMER_ROOM="mobelisk-company-name"
export MOB_SKIP_CI_PUSH_OPTION_ENABLED=false

#mob start 10
#mob timer 20
#mob break 5

# Developer A develops and shares screen
git checkout master
git checkout -b base-branch
git branch
git push

mob start
git branch
# Edit code
mob next

# Developer B and screen sharing swap
git fetch
git checkout mob/base-branch
# Edit code
mob next

# Developer A and screen sharing swap
git pull
# Edit code
mob next

# Developer B and screen sharing swap
git pull
# Edit code
mob next

# Finalizing development
mob done
git branch
git status
git commit -m "PREFIX-1234 all functionality done."
git push
```

## See also

* [Mob](https://mob.sh/)
* [Mob GIT](https://github.com/remotemobprogramming/mob/)
* [Mob timer](https://timer.mob.sh/)
