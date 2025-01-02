{**
 * templates/frontend/components/navigationMenu.tpl
 *
 * Copyright (c) 2021 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Primary navigation menu list for OJS
 *
 * @uses navigationMenu array Hierarchical array of navigation menu item assignments
 * @uses id string Element ID to assign the outer <ul>
 * @uses ulClass string Class name(s) to assign the outer <ul>
 * @uses liClass string Class name(s) to assign all <li> elements
 *}

{if $navigationMenu}
	{if $id == "navigationPrimary"}
		{include file="frontend/components/navigationMenuPrimary.tpl"
			id=$id
			ulClass=$ulClass
			liClass=$liClass
			navigationMenu=$navigationMenu}
	{elseif $id == "navigationUser"}
		{include file="frontend/components/navigationMenuUser.tpl"
			id=$id
			ulClass=$ulClass
			liClass=$liClass
			navigationMenu=$navigationMenu}
	{/if}
{/if}
