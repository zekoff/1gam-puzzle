# run this script in a terminal instance to start file watching

coffee --watch --output bin/ --compile src/ &
watchify bin/startup.js -o bundle.js --verbose --debug

# also, here's a handy alias
# alias commit='git add --all; git commit; git push'