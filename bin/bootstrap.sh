#! /usr/bin/env bash

cd $HOME/code/cf/Buildpacks

echo "buildpack:"
for m in *-buildpack/manifest.yml ; do
  buildpack=$(dirname $m)
  echo "  ${buildpack}:"
  
  pushd $buildpack 2>&1 > /dev/null
    url=$(git remote -v | fgrep fetch | awk '{print $2}')
    echo "    git: ${url}"
    echo "    branch: develop"
  popd 2>&1 > /dev/null
done

