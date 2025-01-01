{**
* templates/frontend/components/navigationMenuPrimary.tpl
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

{assign var="materialBaseColour" value=$activeTheme->getOption('materialBaseColour')}

<ul id="{$id|escape}" role="list" class="{$ulClass|escape} space-y-9">
	{foreach key=field item=navigationMenuItemAssignment from=$navigationMenu->menuTree}
		{if !$navigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
			{continue}
		{/if}
		<li class="{$liClass|escape}">
			<a href="{$navigationMenuItemAssignment->navigationMenuItem->getUrl()}" class="font-display font-medium text-slate-900 dark:text-white">
				{$navigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
			</a>
			{if $navigationMenuItemAssignment->navigationMenuItem->getIsChildVisible()}
				<ul role="list" class="mt-2 space-y-2 border-l-2 border-slate-100 lg:mt-4 lg:space-y-4 lg:border-slate-200 dark:border-slate-800">
					{foreach key=childField item=childNavigationMenuItemAssignment from=$navigationMenuItemAssignment->children}
						{if $childNavigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
							<li class="{$liClass|escape} relative">
								<a href="{$childNavigationMenuItemAssignment->navigationMenuItem->getUrl()}" class="block w-full pl-3.5 before:pointer-events-none before:absolute before:-left-1 before:top-1/2 before:h-1.5 before:w-1.5 before:-translate-y-1/2 before:rounded-full font-semibold text-{$materialBaseColour}-500 before:bg-{$materialBaseColour}-500">
									{$childNavigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
								</a>
							</li>
						{/if}
					{/foreach}
				</ul>
			{/if}
		</li>
	{/foreach}
</ul>