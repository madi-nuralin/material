{**
 * plugins/blocks/developedBy/block.tpl
 *
 * Copyright (c) 2021 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Common site sidebar menu -- "Developed By" block.
 *}
{material_menu_item}
	{material_menu_link}
		{translate key="plugins.block.developedBy.blockTitle"}
	{/material_menu_link}

	{material_submenu}
		{material_submenu_item}
			{material_submenu_link url="https://pkp.sfu.ca/ojs/"}
				{translate key="common.software"}
			{/material_submenu_link}
		{/material_submenu_item}
	{/material_submenu}
{/material_menu_item}
