
<ul id="{$id|escape}"
	role="list"
	class="{$ulClass|escape} {if !$mobile}flex space-x-2{else}space-y-2{/if}">
	{foreach key=field item=navigationMenuItemAssignment from=$navigationMenu->menuTree}
		{if !$navigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
			{continue}
		{/if}
		<li class="{$liClass|escape}">
			<div class="relative inline-block text-left" {if !$mobile}{literal}x-data="{ openModal: false }"{/literal}{/if}>
				<div {literal}@mouseover="openModal = true" @mouseleave="openModal = false"{/literal}>
					<a href="{$navigationMenuItemAssignment
						->navigationMenuItem
						->getUrl()}"
						{if !$mobile}
							class="flex h-8 items-center justify-center rounded-lg shadow-md shadow-black/5 ring-1 ring-black/5 dark:bg-slate-700 dark:ring-inset dark:ring-white/5 px-3 text-sm dark:text-slate-400 dark:before:bg-slate-700 dark:hover:text-slate-300"
						{/if}>
						{$navigationMenuItemAssignment
							->navigationMenuItem
							->getLocalizedTitle()}
					</a>
				</div>

				{if $navigationMenuItemAssignment->navigationMenuItem->getIsChildVisible()}

					<div {if !$mobile}class="absolute right-0 z-10 mt-2 w-56 origin-top-right rounded-md bg-white shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none dark:bg-slate-800" role="menu" {literal} x-show="openModal" @mouseover="openModal = true" @mouseleave="openModal = false"{/literal}{/if}>
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