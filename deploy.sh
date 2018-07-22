#!/bin/bash

set -e
set -x

git push || echo "Git push failed..."
ssh noah@codefol.io ". ~/.bash_profile && cd checkouts/codefolio_octopress && git pull && rvm use 2.3.1 && bundle && bundle exec rake generate"

