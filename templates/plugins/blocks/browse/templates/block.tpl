{**
 * templates/block.tpl
 *
 * Copyright (c) 2021 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file LICENSE.
 *
 * @brief Common site sidebar menu for browsing the catalog.
 *
 * @uses $browseNewReleases bool Whether or not to show a new releases link
 * @uses $browseCategoryFactory object Category factory providing access to
 *  browseable categories.
 * @uses $browseSeriesFactory object Series factory providing access to
 *  browseable series.
 *}
{material_menu_item}
	{material_menu_link}
		{translate key="plugins.block.browse"}
	{/material_menu_link}

	{material_submenu aria-label="{translate|escape key="plugins.block.browse"}"}
		{if $browseCategories}
			{material_submenu_item class="has_submenu"}
				{material_submenu_link}
					{translate key="plugins.block.browse.category"}
				{/material_submenu_link}
				{material_submenu}
					{foreach from=$browseCategories item=browseCategory}
						{if !$browseSeriesItem->getIsInactive()}
							{material_submenu_item class="category_{$browseCategory->getId()}{if $browseCategory->getParentId()} is_sub{/if}{if $browseBlockSelectedCategory == $browseCategory->getPath()} current{/if}"}
								{material_submenu_link url="{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="catalog" op="category" path=$browseCategory->getPath()|escape}"}
									{$browseCategory->getLocalizedTitle()|escape}
								{/material_submenu_link}
							{/material_submenu_item}
						{/if}
					{/foreach}
				{/material_submenu}
			{/material_submenu_item}
		{/if}
	{/material_submenu}
{/material_menu_item}<!-- .block_browse -->
