<!--
SPDX-FileCopyrightText: 2026 OWA Lab contributors
SPDX-License-Identifier: AGPL-3.0-or-later
-->

# OWA Cloud Server - Nextcloud AIO

This folder keeps the server side deliberately small. It uses the official Nextcloud All-in-One image and applies OWA Cloud branding through Nextcloud's supported theming configuration. No Nextcloud server core files are patched.

## Start

Requirements: Docker Engine with Docker Compose v2.

```bash
cd server-aio
docker compose up -d
```

Open the AIO setup interface on:

```text
https://SERVER-IP:8080
```

The AIO interface uses HTTPS. During the initial local setup the browser can show a certificate warning.

Complete the AIO setup, configure the domain, and start the Nextcloud containers from the AIO interface.

## Apply OWA branding

Wait until the container `nextcloud-aio-nextcloud` is running, then:

```bash
chmod +x apply-branding.sh
./apply-branding.sh
```

The script configures:

- Name: **OWA Cloud**
- OWA Lab website link
- OWA brand colors
- OWA Cloud Android release link
- OWA Labs logo when available

The script first looks for `branding/owa-labs-logo.webp`. If it is missing and `curl` is available, it downloads the current logo from the OWA Labs website repository.

## Updates

Use the normal **Nextcloud AIO update process**. The OWA branding is stored through Nextcloud's theming app rather than patched into server code, so server updates stay independent.

If a restored or migrated installation loses any appearance settings, run `./apply-branding.sh` again.

## Backups

Use AIO's built-in backup feature. Docker volumes alone are not a backup.

## Important

Do not rename:

- `nextcloud-aio-mastercontainer`
- the `nextcloud_aio_mastercontainer` volume

AIO expects those names.
