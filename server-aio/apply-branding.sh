#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 OWA Lab contributors
# SPDX-License-Identifier: AGPL-3.0-or-later

set -euo pipefail

NEXTCLOUD_CONTAINER="${NEXTCLOUD_CONTAINER:-nextcloud-aio-nextcloud}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOCAL_LOGO="${OWA_LOGO:-$SCRIPT_DIR/branding/owa-labs-logo.webp}"
FALLBACK_LOGO_URL="https://raw.githubusercontent.com/scncvk19/website_OWA_LABS/main/public/images/owa-labs-logo.webp"
TEMP_LOGO=""

cleanup() {
  if [ -n "$TEMP_LOGO" ] && [ -f "$TEMP_LOGO" ]; then
    rm -f "$TEMP_LOGO"
  fi
}
trap cleanup EXIT

if ! docker inspect "$NEXTCLOUD_CONTAINER" >/dev/null 2>&1; then
  echo "Container '$NEXTCLOUD_CONTAINER' was not found."
  echo "Finish the AIO setup and start the Nextcloud containers first."
  exit 1
fi

occ() {
  docker exec --user www-data "$NEXTCLOUD_CONTAINER" php occ "$@"
}

echo "Applying OWA Cloud theming..."
occ theming:config name "OWA Cloud"
occ theming:config url "https://owa-labs.vercel.app"
occ theming:config slogan "OWA Lab"
occ theming:config primary_color "#4F6D5A"
occ theming:config background_color "#2C3B31"
occ theming:config background backgroundColor
occ config:app:set theming AndroidClientUrl --value "https://github.com/scncvk19/owa-cloud/releases/latest"

if [ ! -f "$LOCAL_LOGO" ] && command -v curl >/dev/null 2>&1; then
  TEMP_LOGO="$(mktemp --suffix=.webp)"
  echo "Local OWA logo not found. Downloading the current OWA Labs logo..."
  if curl --fail --location --silent --show-error "$FALLBACK_LOGO_URL" --output "$TEMP_LOGO"; then
    LOCAL_LOGO="$TEMP_LOGO"
  else
    echo "Logo download failed; text and color branding were still applied."
  fi
fi

if [ -f "$LOCAL_LOGO" ]; then
  docker cp "$LOCAL_LOGO" "$NEXTCLOUD_CONTAINER:/tmp/owa-cloud-logo.webp"
  occ theming:config logo /tmp/owa-cloud-logo.webp
  docker exec "$NEXTCLOUD_CONTAINER" rm -f /tmp/owa-cloud-logo.webp
else
  echo "No logo file available. Add branding/owa-labs-logo.webp and run this script again."
fi

echo
echo "OWA Cloud branding applied."
echo "Android app link: https://github.com/scncvk19/owa-cloud/releases/latest"
