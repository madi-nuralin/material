{**
 * templates/frontend/components/navigationMenuUser.tpl
 *
 * Copyright (c) 2025 Madi N.
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Primary navigation menu list for OJS
 *
 * @uses navigationMenu array Hierarchical array of navigation menu item assignments
 * @uses id string Element ID to assign the outer <ul>
 * @uses ulClass string Class name(s) to assign the outer <ul>
 * @uses liClass string Class name(s) to assign all <li> elements
 *}

<ul id="{$id|escape}" role="list" class="{$ulClass|escape} md:flex hidden space-x-2">
	{foreach key=field item=navigationMenuItemAssignment from=$navigationMenu->menuTree}
		{if !$navigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
			{continue}
		{/if}
		<li class="{$liClass|escape}">
			{material_dropdown}
				{material_dropdown_trigger url="{$navigationMenuItemAssignment->navigationMenuItem->getUrl()}"}
					{$navigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
				{/material_dropdown_trigger}
				{if $navigationMenuItemAssignment->navigationMenuItem->getIsChildVisible()}
					{material_dropdown_body}
						{foreach key=childField item=childNavigationMenuItemAssignment from=$navigationMenuItemAssignment->children}
							{if $childNavigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
								{material_dropdown_item url="{$childNavigationMenuItemAssignment->navigationMenuItem->getUrl()}" class="{$liClass|escape}"}
									{$childNavigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
								{/material_dropdown_item}
							{/if}
						{/foreach}
					{/material_dropdown_body}
				{/if}
			{/material_dropdown}
		</li>
	{/foreach}
</ul>

{material_menu class="{$ulClass|escape} md:hidden"}
	{foreach key=field item=navigationMenuItemAssignment from=$navigationMenu->menuTree}
		{if !$navigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
			{continue}
		{/if}
		{material_menu_item class="{$liClass|escape}"}
			{material_menu_link url="{$navigationMenuItemAssignment->navigationMenuItem->getUrl()}"}
				{$navigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
			{/material_menu_link}
			{if $navigationMenuItemAssignment->navigationMenuItem->getIsChildVisible()}
				{material_submenu}
					{foreach key=childField item=childNavigationMenuItemAssignment from=$navigationMenuItemAssignment->children}
						{if $childNavigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
							{material_submenu_item class="{$liClass|escape}"}
								{material_submenu_link url="{$childNavigationMenuItemAssignment->navigationMenuItem->getUrl()}" }
									{$childNavigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
								{/material_submenu_link}
							{/material_submenu_item}
						{/if}
					{/foreach}
				{/material_submenu}
			{/if}
		{/material_menu_item}
	{/foreach}
{/material_menu}
