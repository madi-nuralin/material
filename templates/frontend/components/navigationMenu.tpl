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
	<ul id="{$id|escape}" class="{$ulClass|escape} navbar-nav mr-auto align-items-center">

		{if $id && $id == '_navigationUser'}
			<li class="{$liClass|escape} nav-item m-1">
				<a href="{url page="search"}" class="btn btn-light btn-floating">
					{*translate key="common.search"*}<i class="fas fa-search"></i>
				</a>
			</li>
			{* Sidebars *}
			{if empty($isFullWidth)}
				{capture assign="sidebarCode"}{call_hook name="Templates::Common::Sidebar"}{/capture}
				{if $sidebarCode}
					<li class="{$liClass|escape} nav-item m-1" role="complementary" aria-label="{translate|escape key="common.navigation.sidebar"}">
						<div class="dropdown">
							<a href="#" class="btn btn-light btn-floating dropdown-toggle" type="button" id="dropdownSidebar" data-mdb-toggle="dropdown" aria-expanded="false">
								<i class="fas fa-globe"></i>
							</a>
							<ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownSidebar">
								{$sidebarCode}
							</ul>
						</div>
					</li><!-- pkp_sidebar.left -->
				{/if}
			{/if}
		{/if}

		{foreach key=field item=navigationMenuItemAssignment from=$navigationMenu->menuTree}
			{if !$navigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
				{continue}
			{/if}
			<li class="{$liClass|escape} nav-item m-1">
				{if $navigationMenuItemAssignment->navigationMenuItem->getIsChildVisible()}
					<div class="dropdown">
						<a href="{$navigationMenuItemAssignment->navigationMenuItem->getUrl()}" class="nav-link dropdown-toggle text-truncate" type="button" id="{$id|escape}" data-mdb-toggle="dropdown" aria-expanded="false">
							{$navigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
						</a>
						<ul class="dropdown-menu dropdown-menu-end" aria-labelledby="{$id|escape}">
							{foreach key=childField item=childNavigationMenuItemAssignment from=$navigationMenuItemAssignment->children}
								{if $childNavigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
									<li class="{$liClass|escape}">
										<a href="{$childNavigationMenuItemAssignment->navigationMenuItem->getUrl()}" class="dropdown-item text-truncate">
											{$childNavigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
										</a>
									</li>
								{/if}
							{/foreach}
						</ul>
					</div>
				{else}
					{assign var="url" value=$navigationMenuItemAssignment->navigationMenuItem->getUrl()}
					{if str_contains($url, 'login')} 
						<a href="{$navigationMenuItemAssignment->navigationMenuItem->getUrl()}" class="btn btn-primary">
							{$navigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
							<!--i class="fas fa-sign-in-alt"></i-->
						</a>
					{elseif str_contains($url, 'register')}
						<!--a href="{$navigationMenuItemAssignment->navigationMenuItem->getUrl()}" class="btn btn-light">
							{$navigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
						</a-->
					{else}
						<a href="{$navigationMenuItemAssignment->navigationMenuItem->getUrl()}" class="nav-link text-center">
							{$navigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
						</a>
					{/if}
				{/if}
			</li>
		{/foreach}
	</ul>
{/if}
