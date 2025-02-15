{**
 * templates/frontend/components/breadcrumbs.tpl
 *
 * Copyright (c) 2024 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display a breadcrumb nav item showing the current page. This basic
 *  version is for top-level pages which only need to show the Home link. For
 *  category- and series-specific breadcrumb generation, see
 *  templates/frontend/components/breadcrumbs_catalog.tpl.
 *
 * @uses $currentTitle string The title to use for the current page.
 * @uses $currentTitleKey string Translation key for title of current page.
 *}
{assign var="materialBaseColour" value=$activeTheme->getOption('materialBaseColour')}

<nav class="text-slate-500" role="navigation">
	<ol class="not-prose flex space-x-1 list-none overflow-none">
		<li class="truncate">
			<a class="hover:text-slate-700 dark:hover:text-slate-400" href="{url page="index" router=\PKP\core\PKPApplication::ROUTE_PAGE}">
				{translate key="common.homepageNavigationLabel"}
			</a>
			<span class="separator">
				{translate key="navigation.breadcrumbSeparator"}
			</span>
		</li>
		<li class="current text-{$materialBaseColour}-500 truncate">
			<span aria-current="page">
				{if $currentTitleKey}
					{translate key=$currentTitleKey}
				{else}
					{$currentTitle|escape}
				{/if}
			</span>
		</li>
	</ol>
</nav>

