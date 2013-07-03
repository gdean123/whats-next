#!/bin/sh
pwd=`pwd`
osascript -e "tell application \"Terminal\" to do script \"cd $pwd; rails s\""
osascript -e "tell application \"Terminal\" to do script \"cd $pwd; RAILS_ENV=test rails s -p 3001 -P tmp/pids/server2.pid\""
