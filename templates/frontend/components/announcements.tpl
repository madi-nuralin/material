{**
 * templates/frontend/components/announcements.tpl
 *
 * Copyright (c) 2024 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display a list of announcements
 *
 * @uses $announcements array List of announcements
 *}

<div>
	{foreach from=$announcements item=announcement}
		<div>
			{include file="frontend/objects/announcement_summary.tpl"}
		</div>
	{/foreach}
</div>
