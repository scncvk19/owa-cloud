/*
 * OWA Cloud - Android Client
 *
 * SPDX-FileCopyrightText: 2026 OWA Lab contributors
 * SPDX-License-Identifier: AGPL-3.0-or-later
 */
package com.nextcloud.android.appReview

import androidx.appcompat.app.AppCompatActivity
import com.nextcloud.appReview.InAppReviewHelper
import com.nextcloud.client.preferences.AppPreferences

/**
 * OWA Cloud is distributed directly for self-hosted use, so Play Store
 * in-app reviews are intentionally disabled for this flavor.
 */
class InAppReviewHelperImpl(
    @Suppress("UNUSED_PARAMETER") appPreferences: AppPreferences
) : InAppReviewHelper {
    override fun resetAndIncrementAppRestartCounter() = Unit

    override fun showInAppReview(activity: AppCompatActivity) = Unit
}
