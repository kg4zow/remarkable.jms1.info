all: build

build:
	rm -f theme/*.hbs
	mdbook build
	if [ -f .git2rss -a -x git2rss ] ; then ./git2rss > book/commits.xml ; fi

serve:
	rm -f theme/*.hbs
	mdbook serve --open --hostname 127.0.0.1

serve-all:
	rm -f theme/*.hbs
	mdbook serve --open --hostname 0.0.0.0

###############################################################################
#
# Change the 'push' target to reference the specific target(s) you want the
# site to be published to. Examples:
#
#   push: rsync
#   push: gh-pages

push: rsync

########################################
# IF you're going to publish the generated book to a web server, and you're
# able to use 'rsync' to upload the files ...
#
# - Change the 'push:' line to include the 'rsync' target
# - Edit the rsync command below as needed.
# - For Keybase Sites, the target will be a path under '/keybase/'. Seee
#   https://jms1.keybase.pub/kbsites/ for more specific examples.

rsync: build
	rsync -avz --delete \
		book/ \
		/keybase/team/jms1team.sites/remarkable.jms1.info/
	find /keybase/team/jms1team.sites/remarkable.jms1.info \
		-name .DS_Store -o -name '._*' -delete

########################################
# IF you're going to publish the generated book to GitHub Pages, using the
# same repo where you're tracking the source ...
#
# - Change the 'push:' line above to include the 'gh-pages' target
#
# NOTES:
# - These commands work for me using bash. If you're using some other shell,
#   you may need to adjust or remove this line.
# - The 'git worktree' commands require git version 2.0.7 or later.

gh-pages: build
	set -ex ; \
	WORK="$$( mktemp -d )" ; \
	VER="$$( git describe --always --tags --dirty )" ; \
	git worktree add --force "$$WORK" gh-pages ; \
	rm -rf "$$WORK"/* ; \
	rsync -av book/ "$$WORK"/ ; \
	if [ -f CNAME ] ; then cp CNAME "$$WORK"/ ; fi ; \
	pushd "$$WORK" ; \
	git add -A ; \
	git commit -m "Updated gh-pages $$VER" ; \
	popd ; \
	git worktree remove "$$WORK" ; \
	git push origin gh-pages
