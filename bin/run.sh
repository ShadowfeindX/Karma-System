#!/bin/bash
. setup.sh
cd ..
bundle install
nohup bundle exec ./setup.rb > bin/log &
cd bin