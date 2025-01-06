{**
 * plugins/blocks/information/block.tpl
 *
 * Copyright (c) 2021 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Common site sidebar menu -- information links.
 *
 *}

{if !empty($forReaders) || !empty($forAuthors) || !empty($forLibrarians)}
	{material_menu_item}
		{material_menu_link}
			{translate key="plugins.block.information.link"}
		{/material_menu_link}
		
		{material_submenu}
			{if !empty($forReaders)}
				{material_submenu_item}
					{material_submenu_link url="{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="information" op="readers"}"}
						{translate key="navigation.infoForReaders"}
					{/material_submenu_link}
				{/material_submenu_item}
			{/if}
			{if !empty($forAuthors)}
				{material_submenu_item}
					{material_submenu_link url="{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="information" op="authors"}"}
						{translate key="navigation.infoForAuthors"}
					{/material_submenu_link}
				{/material_submenu_item}
			{/if}
			{if !empty($forLibrarians)}
				{material_submenu_item}
					{material_submenu_link url="{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="information" op="librarians"}"}
						{translate key="navigation.infoForLibrarians"}
					{/material_submenu_link}
				{/material_submenu_item}
			{/if}
		{/material_submenu}
	{/material_menu_item}
{/if}
