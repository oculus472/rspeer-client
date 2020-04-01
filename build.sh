#!/usr/bin/env sh
CURRENT_VERSION_FILE=".currentVersion"

LATEST_VERSION=$(curl "http://services.rspeer.org/api/bot/currentVersion?game=0" | jq ".version")
CURRENT_VERSION=""

if [ -r $CURRENT_VERSION_FILE ]; then
  printf "Reading current version file\n"
  CURRENT_VERSION=$(cat $CURRENT_VERSION_FILE)
fi

printf "Current Version: \"%s\"\n" "$CURRENT_VERSION"
printf "Latest Version: \"%s\"\n" "$LATEST_VERSION"
if [ "$LATEST_VERSION" != "$CURRENT_VERSION" ]; then
  printf "Downloading latest version\n"
  curl "https://services.rspeer.org/v2/bot/currentJar?game=186" --output rspeer.jar
  echo "$LATEST_VERSION" >$CURRENT_VERSION_FILE

  curl -X PUT \
    "https://maven.pkg.github.com/oculus472/rspeer-client/org/rspeer/$LATEST_VERSION/rspeer-$LATEST_VERSION.jar" \
    -H "Authorization: token $GITHUB_TOKEN" \
    --upload-file "./rspeer.jar" -vvv

    REMOTE_REPO="https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"

    git config --local user.email "action@github.com"
    git config --local user.name "GitHub Action"
    git commit -m "Updated Current Version file" -a
    git push "${REMOTE_REPO}" HEAD:master --follow-tags
    return 0
fi

return 0
