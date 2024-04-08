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
										<a href="{$childNavigationMenuItemAssignment->navigationMenuItem->getUrl()}" class="block w-full pl-3.5 before:pointer-events-none before:absolute before:-left-1 before:top-1/2 before:h-1.5 before:w-1.5 before:-translate-y-1/2 before:rounded-full font-semibold text-sky-500 before:bg-sky-500">
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
	{elseif $id == "navigationUser"}
		<ul id="{$id|escape}" role="list" class="{$ulClass|escape} flex space-x-2">
			{foreach key=field item=navigationMenuItemAssignment from=$navigationMenu->menuTree}
				{if !$navigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
					{continue}
				{/if}
				<li class="{$liClass|escape}">
					<div class="relative inline-block text-left" {literal}x-data="{ open: false }"{/literal}>
						<div {literal}@mouseover="open = true" @mouseleave="open = false"{/literal}>
							<a href="{$navigationMenuItemAssignment->navigationMenuItem->getUrl()}" class="flex h-8 items-center justify-center rounded-lg shadow-md shadow-black/5 ring-1 ring-black/5 dark:bg-slate-700 dark:ring-inset dark:ring-white/5 px-3 text-sm dark:text-slate-400 dark:before:bg-slate-700 dark:hover:text-slate-300">
								{$navigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
								<!--svg class="-mr-1 h-5 w-5 text-gray-400" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
							        <path fill-rule="evenodd" d="M5.23 7.21a.75.75 0 011.06.02L10 11.168l3.71-3.938a.75.75 0 111.08 1.04l-4.25 4.5a.75.75 0 01-1.08 0l-4.25-4.5a.75.75 0 01.02-1.06z" clip-rule="evenodd" />
							    </svg-->
							</a>
						</div>

						{if $navigationMenuItemAssignment->navigationMenuItem->getIsChildVisible()}

							<!--
							    Dropdown menu, show/hide based on menu state.

							    Entering: "transition ease-out duration-100"
							      From: "transform opacity-0 scale-95"
							      To: "transform opacity-100 scale-100"
							    Leaving: "transition ease-in duration-75"
							      From: "transform opacity-100 scale-100"
							      To: "transform opacity-0 scale-95"
							-->
							<div class="absolute right-0 z-10 mt-2 w-56 origin-top-right rounded-md bg-white shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none dark:bg-slate-800" role="menu" aria-orientation="vertical" aria-labelledby="menu-button" tabindex="-1" x-show="open" {literal}@mouseover="open = true" @mouseleave="open = false"{/literal}>
					    		<ul class="py-1" role="list">
									{foreach key=childField item=childNavigationMenuItemAssignment from=$navigationMenuItemAssignment->children}
											{if $childNavigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
												<li class="{$liClass|escape}">
													<a href="{$childNavigationMenuItemAssignment->navigationMenuItem->getUrl()}" class="text-gray-700  dark:text-gray-400 block px-4 py-2 text-sm" role="menuitem" tabindex="-1" id="menu-item-0">
														{$childNavigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
													</a>
												</li>
											{/if}
									{/foreach}
								</ul>
							</div>
						{/if}
					</div>
				</li>
			{/foreach}
		</ul>
	{/if}
{/if}

{*block w-full pl-3.5 before:pointer-events-none before:absolute before:-left-1 before:top-1/2 before:h-1.5 before:w-1.5 before:-translate-y-1/2 before:rounded-full text-slate-500 before:hidden before:bg-slate-300 hover:text-slate-600 hover:before:block dark:text-slate-400 dark:before:bg-slate-700 dark:hover:text-slate-300*}
