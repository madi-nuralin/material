{**
 * templates/frontend/components/breadcrumbs_announcement.tpl
 *
 * Copyright (c) 2014-2021 Simon Fraser University
 * Copyright (c) 2003-2021 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display a breadcrumb nav item for announcements.
 *
 * @uses $currentTitle string The title to use for the current page.
 * @uses $currentTitleKey string Translation key for title of current page.
 *}
{assign var="materialBaseColour" value=$activeTheme->getOption('materialBaseColour')}

<nav class="cmp_breadcrumbs cmp_breadcrumbs_announcement text-slate-500" role="navigation">
	<ol class="not-prose flex space-x-1 list-none overflow-none">
		<li class="flex space-x-1 truncate">
			<a class="hover:text-slate-700 dark:hover:text-slate-400" href="{url page="index" router=\PKP\core\PKPApplication::ROUTE_PAGE}">
				{translate key="common.homepageNavigationLabel"}
			</a>
			<span class="separator">{translate key="navigation.breadcrumbSeparator"}</span>
		</li>
		<li class="flex space-x-1 truncate">
			<a class="hover:text-slate-700" href="{url page="announcement" router=\PKP\core\PKPApplication::ROUTE_PAGE}">
				{translate key="announcement.announcements"}
			</a>
			<span class="separator">{translate key="navigation.breadcrumbSeparator"}</span>
		</li>
		<li class="current text-{$materialBaseColour}-500 truncate">
			<span aria-current="page">{$currentTitle|escape}</span>
		</li>
	</ol>
</nav>

