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

<ul class="{$ulClass|escape} navbar-nav mr-auto flex-row">
	{* Sidebars *}
	{if empty($isFullWidth)}
		{capture assign="sidebarCode"}{call_hook name="Templates::Common::Sidebar"}{/capture}
		{if $sidebarCode}
			<li class="{$liClass|escape} nav-item mx-1 d-flex align-items-center" role="complementary" aria-label="{translate|escape key="common.navigation.sidebar"}">
				<ul class="d-flex align-items-center list-unstyled" aria-labelledby="dropdownSidebar">
					{$sidebarCode}
				</ul>
			</li><!-- pkp_sidebar.left -->
		{/if}
	{/if}
	<li class="{$liClass|escape} nav-item">
		<a href="{url page="search"}" class="nav-link mx-1">
			{translate key="common.search"}<!--i class="fas fa-search"></i-->
		</a>
	</li>
</ul>