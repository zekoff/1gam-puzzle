# run this script in a separate terminal instance to start file watching
# TODO? switch to coffeeify plugin for browserify, rather than coffee --watch
alias commit='git add --all; git commit; git push'
coffee --watch --output bin/ --compile src/ &
watchify bin/startup.js -o bundle.js --verbose --debug
# beefy can't be configured to serve over anything but localhost