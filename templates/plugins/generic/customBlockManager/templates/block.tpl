{**
 * plugins/generic/customBlockManager/templates/block.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Sidebar custom block.
 *
 *}

{material_menu_item class="pkp_block block_custom" id="{$customBlockId|escape}"}
	{material_menu_link class="title{if !$showName} pkp_screen_reader{/if}"}
		{$customBlockTitle}
	{/material_menu_link}

	{material_submenu class="content"}
		{material_submenu_item}
			<div class="block w-full pl-3.5 before:pointer-events-none before:absolute before:-left-1 before:top-1/2 before:h-1.5 before:w-1.5 before:-translate-y-1/2 before:rounded-full text-slate-500 before:hidden before:bg-slate-300 hover:text-slate-600 hover:before:block dark:text-slate-400 dark:before:bg-slate-700 dark:hover:text-slate-300">
				{$customBlockContent}
			</div>
		{/material_submenu_item}
	{/material_submenu}
{/material_menu_item}
