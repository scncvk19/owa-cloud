<!--
SPDX-FileCopyrightText: 2026 OWA Lab contributors
SPDX-License-Identifier: AGPL-3.0-or-later
-->

# OWA Cloud customization

OWA Cloud is a branded distribution of the open-source Nextcloud Android client.

## Android identity

- App name: **OWA Cloud**
- Application ID: `labs.owa.cloud`
- Flavor: `owa`
- Branding branch: `owa-branding`
- Upstream: `nextcloud/android:master`

The OWA-specific Android resources live under `app/src/owa/`. This keeps most branding outside Nextcloud's normal source files and reduces merge conflicts during upstream updates.

## Update model

The scheduled upstream workflow fetches the official Nextcloud Android `master` branch and prepares a separate update branch. It checks that the OWA flavor and branding resources still exist, then opens a pull request against `owa-branding`.

It never auto-merges upstream changes.

## APKs

A pull request into `owa-branding` builds an installable debug-signed APK for validation. Changes pushed to `owa-branding` create an automated GitHub pre-release with:

- `OWA-Cloud.apk`
- `OWA-Cloud.apk.sha256`

Debug signing is intentional for the current self-hosted/testing distribution. A permanent release key should be introduced before Play Store distribution.
