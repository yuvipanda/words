#!/bin/bash
git push origin master
ssh words.yuvi.in 'cd words && git pull origin master'
