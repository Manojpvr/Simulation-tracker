#!/bin/bash
open http://localhost:8787/simulation-tracker.html &
python3 -m http.server 8787
