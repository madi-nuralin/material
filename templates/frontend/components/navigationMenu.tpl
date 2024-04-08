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
		{* Large screen *}
		<div class="md:flex hidden">
			{include file="frontend/components/local/navigationUser.tpl"
				id=$id
				ulClass=$ulClass
				liClass=$liClass
				navigationMenu=$navigationMenu
				mobile=false}
		</div>

		{* Mobile version *}
		<div {literal}x-data="{ open: false }"{/literal}>
			<button class="flex h-8 items-center justify-center rounded-lg shadow-md shadow-black/5 ring-1 ring-black/5 dark:bg-slate-700 dark:ring-inset dark:ring-white/5 px-3 text-sm dark:text-slate-400 dark:before:bg-slate-700 dark:hover:text-slate-300 md:hidden" {literal}x-on:click="open = true"{/literal}>
				<svg xmlns="http://www.w3.org/2000/svg"
					class="h-4 w-4 text-slate-400"
					viewBox="0 0 24 24"
					fill="none"
					stroke="currentColor"
					stroke-width="2"
					stroke-linecap="round"
					stroke-linejoin="round">
					<path d="M20 9v11a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V9"/>
					<path d="M9 22V12h6v10M2 10.6L12 2l10 8.6"/>
				</svg>
			</button>
			<div x-show="open">
				<div class="fixed inset-0 z-50" id="headlessui-dialog-:Rmdla:" role="dialog" aria-modal="true" data-headlessui-state="open">
					<div class="fixed inset-0 bg-slate-900/50 backdrop-blur">
					</div>
					<div class="fixed inset-0 overflow-y-auto px-4 py-4 sm:px-6 sm:py-20 md:py-32 lg:px-8 lg:py-[15vh]">
						<div class="mx-auto transform-gpu overflow-hidden rounded-xl bg-white shadow-xl sm:max-w-xl dark:bg-slate-800 dark:ring-1 dark:ring-slate-700 rounded-lg p-4">
							<div class="flex justify-end pb-4">
								<button type="button"
									class="relative"
									aria-label="Open navigation"
									{literal}x-on:click="open = !open"{/literal}>
									<svg aria-hidden="true"
										viewBox="0 0 24 24"
										fill="none"
										stroke-width="2"
										stroke-linecap="round"
										class="h-6 w-6 stroke-slate-500">
										<path d="M5 5l14 14M19 5l-14 14"></path>
									</svg>
								</button>
							</div>
							{include file="frontend/components/local/navigationUser.tpl"
								id=$id
								ulClass=$ulClass
								liClass=$liClass
								navigationMenu=$navigationMenu
								mobile=true}
						</div>
					</div>
				</div>
			</div>
		</div>
	{/if}
{/if}

{*block w-full pl-3.5 before:pointer-events-none before:absolute before:-left-1 before:top-1/2 before:h-1.5 before:w-1.5 before:-translate-y-1/2 before:rounded-full text-slate-500 before:hidden before:bg-slate-300 hover:text-slate-600 hover:before:block dark:text-slate-400 dark:before:bg-slate-700 dark:hover:text-slate-300*}
