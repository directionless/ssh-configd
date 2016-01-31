# ssh-configd

Trivial script to manage `.ssh/config` from files in `.ssh/config.d/`

## Introduction

I have often had the problem where my employer has some complex ssh
bastion host setup. In those cases, they usually like to distribute a
`.ssh/config`. However, I have my own settings, and things just don't
play well.

This is a trivial script that lets me approach this using files in
`.ssh/config.d`. It's the rough equivalent of `cat .ssh/config.d/* > .ssh/config`

If you find yourself with a similar need, it may be handle.

Use at your own risk.

## Usage 

## ToDo

* Add tests (and probably port to a new language)
* Improve concatenation to tell me what file a section is from
* Auto Update Feature
