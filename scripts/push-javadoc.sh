#!/bin/bash

if [ "$TRAVIS_REPO_SLUG" == "openxc/openxc-android" ] && [ "$TRAVIS_JDK_VERSION" == "openjdk8" ] && [ "$TRAVIS_PULL_REQUEST" == "false" ] && [ "$TRAVIS_BRANCH" == "master" ]; then

  cp -R library/build/docs/javadoc $HOME/javadoc-latest

  cd $HOME
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis-CI"
  
  git clone --quiet --branch=master https://${GH_TOKEN}@github.com/openxc/openxc-android master > /dev/null
  cd master
  LATEST_TAG=$(git describe --abbrev=0 --tags)
  cd ../

  git clone --quiet --branch=gh-pages https://${GH_TOKEN}@github.com/openxc/openxc-android gh-pages > /dev/null
  cd gh-pages

  git rm -rf ./
  echo "android.openxcplatform.com" > CNAME
  cp -Rf $HOME/javadoc-latest/. ./
  git add -f .
  git commit -m "JavaDoc $LATEST_TAG - Travis Build $TRAVIS_BUILD_NUMBER"
  git push -fq origin gh-pages > /dev/null
  
fi