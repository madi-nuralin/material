{**
 * templates/frontend/components/navigationMenuUser.tpl
 *
 * Copyright (c) 2025 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Primary navigation menu list for OJS
 *
 * @uses navigationMenu array Hierarchical array of navigation menu item assignments
 * @uses id string Element ID to assign the outer <ul>
 * @uses ulClass string Class name(s) to assign the outer <ul>
 * @uses liClass string Class name(s) to assign all <li> elements
 *}

<ul id="{$id|escape}" role="list" class="{$ulClass|escape} flex space-x-2 space-y-2">
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
