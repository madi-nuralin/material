{**
 * templates/frontend/objects/announcement_full.tpl
 *
 * Copyright (c) 2024 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display the full view of an announcement, when the announcement is
 *  the primary element on the page.
 *
 * @uses $announcement Announcement The announcement to display
 *}

<article class="obj_announcement_full">
	<div class="date">
		{$announcement->getDatePosted()|date_format:$dateFormatShort}
	</div>
	<div class="description">
		{if $announcement->getLocalizedDescription()}
			{$announcement->getLocalizedDescription()|strip_unsafe_html}
		{else}
			{$announcement->getLocalizedDescriptionShort()|strip_unsafe_html}
		{/if}
	</div>
</article><!-- .obj_announcement_full -->
