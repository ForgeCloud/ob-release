#!/usr/bin/env bash
set -e

# This script will do a release of the artifact according to http://maven.apache.org/maven-release/maven-release-plugin/
git config --global user.email "openbankbot@forgerock.com";
git config --global user.name "openbankbot";

git config --global commit.gpgsign true
git config --global user.signingkey $GITHUB_GPG_KEY_ID
echo "GITHUB_GPG_KEY_ID = $GITHUB_GPG_KEY_ID"

echo  "$GITHUB_GPG_KEY" | base64 -d > private.key
gpg --import ./private.key


MAVEN_REPO_LOCAL="";

if [ -n "$1" ]
then
     MAVEN_REPO_LOCAL="-Dmaven.repo.local=$1"
fi
mvn -ntp $MAVEN_REPO_LOCAL -Dusername=$GITHUB_ACCESS_TOKEN release:prepare -B -Darguments="-DskipTests -DskipITs -Ddockerfile.skip -DdockerCompose.skip"
mvn -ntp $MAVEN_REPO_LOCAL release:perform -B -Darguments="-Dmaven.javadoc.skip=true -DskipTests -DskipITs -Ddockerfile.skip -DdockerCompose.skip"
