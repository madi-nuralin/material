{**
 * templates/frontend/components/breadcrumbs_catalog.tpl
 *
 * Copyright (c) 2014-2021 Simon Fraser University
 * Copyright (c) 2003-2021 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display a breadcrumb nav item showing the location in the catalog.
 *  This only supports one-level of nesting, as does the category hierarchy data.
 *
 * @uses $type string What kind of page should we use to construct urls
 *       (category, series, new)?
 * @uses $parent Category A parent category if one exists
 * @uses $currentTitle string The title to use for the current page.
 * @uses $currentTitleKey string Translation key for title of current page.
 *}
{assign var="materialBaseColour" value=$activeTheme->getOption('materialBaseColour')}

<nav class="cmp_breadcrumbs cmp_breadcrumbs_catalog" role="navigation">
	<ol class="not-prose flex space-x-1 list-none">
		<li class="flex space-x-1">
			<a class="hover:text-slate-700" href="{url page="index" router=\PKP\core\PKPApplication::ROUTE_PAGE}">
				{translate key="common.homepageNavigationLabel"}
			</a>
			<span class="separator">{translate key="navigation.breadcrumbSeparator"}</span>
		</li>
		{if $parent}
			<li class="flex space-x-1">
				<a class="hover:text-slate-700" href="{url op=$type path=$parent->getPath()}">
					{$parent->getLocalizedTitle()|escape}
				</a>
				<span class="separator">{translate key="navigation.breadcrumbSeparator"}</span>
			</li>
		{/if}
		<li class="current text-{$materialBaseColour}-500" aria-current="page">
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
