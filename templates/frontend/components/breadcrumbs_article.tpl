{**
 * templates/frontend/components/breadcrumbs_article.tpl
 *
 * Copyright (c) 2014-2021 Simon Fraser University
 * Copyright (c) 2003-2021 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display a breadcrumb nav item showing the current page. This basic
 *  version is for top-level pages which only need to show the Home link. For
 *  category- and series-specific breadcrumb generation, see
 *  templates/frontend/components/breadcrumbs_catalog.tpl.
 *
 * @uses $currentTitle string The title to use for the current page.
 * @uses $currentTitleKey string Translation key for title of current page.
 * @uses $issue Issue Issue this article was published in.
 *}
{assign var="materialBaseColour" value=$activeTheme->getOption('materialBaseColour')}

<nav class="cmp_breadcrumbs text-slate-500" role="navigation" aria-label="{translate key="navigation.breadcrumbLabel"}">
	<ol class="not-prose flex space-x-1 list-none overflow-none">
		<li class="flex space-x-1 truncate">
			<a class="hover:text-slate-700 dark:hover:text-slate-400" href="{url page="index" router=\PKP\core\PKPApplication::ROUTE_PAGE}">
				{translate key="common.homepageNavigationLabel"}
			</a>
			<span class="separator">{translate key="navigation.breadcrumbSeparator"}</span>
		</li>
		<li class="flex space-x-1 truncate">
			<a class="hover:text-slate-700" href="{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="issue" op="archive"}">
				{translate key="navigation.archives"}
			</a>
			<span class="separator">{translate key="navigation.breadcrumbSeparator"}</span>
		</li>
		{if $issue}
			<li class="flex space-x-1 truncate">
				<a class="hover:text-slate-700" href="{url page="issue" op="view" path=$issue->getBestIssueId()}">
					{$issue->getIssueIdentification()}
				</a>
				<span class="separator">{translate key="navigation.breadcrumbSeparator"}</span>
			</li>
		{/if}
		<li class="current text-{$materialBaseColour}-500 truncate" aria-current="page">
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
