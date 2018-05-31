#!/bin/bash
. setup.sh
cd ..
bundle install
bundle exec ./setup.rb &
