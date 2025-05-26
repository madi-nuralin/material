{**
 * plugins/blocks/mostRead/block.tpl
 *
 * Copyright (c) 2014-2024 Simon Fraser University
 * Copyright (c) 2003-2024 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * "Most Read" block.
 *}
{material_menu_item}
	{material_menu_link}
		{if isset($blockTitle) }<span class="title">{$blockTitle}</span>{/if}
	{/material_menu_link}

	{material_submenu}
		{foreach from=$mostRead item=submission}
			{material_submenu_item}
				{material_submenu_link url="{$submission.url}" class="block"}
					{$submission.title}
					<span class="inline-flex items-center rounded-md bg-green-50 px-2 py-1 text-xs font-medium text-green-700 ring-1 ring-green-600/20 ring-inset dark:bg-green-500/10 dark:text-green-400 space-x-2">
						{$submission.metric}
					</span>
				{/material_submenu_link}
			{/material_submenu_item}
		{/foreach}
	{/material_submenu}
{/material_menu_item}
