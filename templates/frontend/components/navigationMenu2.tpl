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
{assign var="locales" value=$currentJournal->getSupportedLocaleNames()}

<ul class="navbar-nav mr-auto flex-row {$ulClass|escape}">
	{* Locales *}
	<li class="nav-item {$liClass|escape}">
		<div class="dropdown">
			{if !$showIcons}
				<a href="#" class="nav-link" type="button" id="dropdownSidebar" data-mdb-toggle="dropdown" aria-expanded="false">
					<i class="fas fa-globe"></i>
				</a>
			{else}
				<a href="#" class="nav-link dropdown-toggle" type="button" id="dropdownSidebar" data-mdb-toggle="dropdown" aria-expanded="false">
					{translate key="common.language"}
				</a>
			{/if}
			<ul class="dropdown-menu dropdown-menu-xxl-end dropdown-menu-light" aria-labelledby="dropdownSidebar">
				{foreach from=$locales item=localeName key=localeKey}
					<li class="locale_{$localeKey|escape}{if $localeKey == $currentLocale} current{/if}" lang="{$localeKey|replace:"_":"-"}">
						<a href="{url router=$smarty.const.ROUTE_PAGE page="user" op="setLocale" path=$localeKey source=$smarty.server.REQUEST_URI}" class="dropdown-item">
							{$localeName}
						</a>
					</li>
				{/foreach}
			</ul>
		</div>
	</li>

	{* Search *}
	<li class="{$liClass|escape} nav-item">
		{if !$showIcons}
			<a href="{url page="search"}" class="nav-link mx-1">
				<i class="fas fa-search"></i>
			</a>
		{else}
			<a href="{url page="search"}" class="nav-link">
				{translate key="common.search"}
			</a>
		{/if}
	</li>
</ul>