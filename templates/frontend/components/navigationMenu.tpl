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
	<ul id="{$id|escape}" class="{$ulClass|escape} navbar-nav ml-auto">

		{foreach
			key=field
			item=navigationMenuItemAssignment
			from=$navigationMenu->menuTree}
			{if !$navigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
				{continue}
			{/if}
			<li class="{$liClass|escape} nav-item">
				{if $navigationMenuItemAssignment->navigationMenuItem->getIsChildVisible()}
					<div class="dropdown">
						<a
							href="{$navigationMenuItemAssignment->navigationMenuItem->getUrl()}"
							class="dropdown-toggle nav-link"
							type="button"
							id="{$id|escape}"
							data-mdb-toggle="dropdown"
							aria-expanded="false" >
							{$navigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
						</a>
						<ul
							class="dropdown-menu dropdown-menu-xxl-end dropdown-menu-light"
							aria-labelledby="{$id|escape}">
							{foreach
								key=childField
								item=childNavigationMenuItemAssignment
								from=$navigationMenuItemAssignment->children}
								{if $childNavigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
									<li class="{$liClass|escape}">
										<a
											href="{$childNavigationMenuItemAssignment->navigationMenuItem->getUrl()}"
											class="dropdown-item">
											{$childNavigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
										</a>
									</li>
								{/if}
							{/foreach}
						</ul>
					</div>
				{else}
					{assign var="url" value=$navigationMenuItemAssignment->navigationMenuItem->getUrl()}
					<a href="{$navigationMenuItemAssignment->navigationMenuItem->getUrl()}" class="nav-link">
						{$navigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
					</a>
				{/if}
			</li>
		{/foreach}
	</ul>
{/if}
