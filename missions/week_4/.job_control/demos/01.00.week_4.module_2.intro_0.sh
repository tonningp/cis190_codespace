#!/bin/bash
script -q -c "
ls > listing.txt
date >> listing.txt
cat listing.txt | wc -l
sleep 5 &
jobs
" /workspaces/codespaces-blank/missions/week_4/module_2/history/session2.typescript
