FROM qcastel/maven-git-gpg:latest

COPY ./src/release.sh /usr/local/bin
COPY ./src/settings.xml /usr/share/maven/conf
