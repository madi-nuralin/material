{**
 * templates/frontend/pages/search.tpl
 *
 * Copyright (c) 2014-2021 Simon Fraser University
 * Copyright (c) 2003-2021 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to search and view search results.
 *
 * @uses $query Value of the primary search query
 * @uses $authors Value of the authors search filter
 * @uses $dateFrom Value of the date from search filter (published after).
 *  Value is a single string: YYYY-MM-DD HH:MM:SS
 * @uses $dateTo Value of the date to search filter (published before).
 *  Value is a single string: YYYY-MM-DD HH:MM:SS
 * @uses $yearStart Earliest year that can be used in from/to filters
 * @uses $yearEnd Latest year that can be used in from/to filters
 *}
{assign var="baseColour2" value=$activeTheme->getOption('baseColour2')}
{include file="frontend/components/header.tpl" pageTitle="common.search"}

{if !$heading}
	{assign var="heading" value="h2"}
{/if}

<div class="page page_search">

	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="common.search"}
	<h1>
		{translate key="common.search"}
	</h1>

	{capture name="searchFormUrl"}{url escape=false}{/capture}
	{assign var=formUrlParameters value=[]}{* Prevent Smarty warning *}
	{$smarty.capture.searchFormUrl|parse_url:$smarty.const.PHP_URL_QUERY|default:""|parse_str:$formUrlParameters}
	<form class="cmp_form space-y-4" method="get" action="{$smarty.capture.searchFormUrl|strtok:"?"|escape}" role="form">
		{foreach from=$formUrlParameters key=paramKey item=paramValue}
			<input type="hidden" name="{$paramKey|escape}" value="{$paramValue|escape}"/>
		{/foreach}

		{* Repeat the label text just so that screen readers have a clear
		   label/input relationship *}
		<div class="search_input">
			<label class="pkp_screen_reader block font-medium text-sm text-gray-700 dark:text-gray-400" for="query">
				{translate key="search.searchFor"}
			</label>
			{block name=searchQuery}
				<input type="text"
					id="query"
					name="query"
					value="{$query|escape}"
					class="query border-gray-300 focus:border-{$baseColour2}-300 focus:ring focus:ring-{$baseColour2}-200 focus:ring-opacity-50 rounded-md shadow-sm dark:bg-gray-800 dark:border-gray-500 dark:text-white mt-1 block w-full"
					placeholder="{translate|escape key="common.search"}">
			{/block}
		</div>

		<fieldset class="search_advanced">
			<legend>
				{translate key="search.advancedFilters"}
			</legend>
			<div class="date_range">
				<div class="from">
					{capture assign="dateFromLegend"}
						{translate key="search.dateFrom"}
					{/capture}
					{html_select_date_a11y legend=$dateFromLegend
						prefix="dateFrom"
						time=$dateFrom
						start_year=$yearStart
						end_year=$yearEnd}
				</div>
				<div class="to">
					{capture assign="dateFromTo"}
						{translate key="search.dateTo"}
					{/capture}
					{html_select_date_a11y legend=$dateFromTo
						prefix="dateTo"
						time=$dateTo
						start_year=$yearStart
						end_year=$yearEnd}
				</div>
			</div>
			<div class="author">
				<label class="label block font-medium text-sm text-gray-700 dark:text-gray-400" for="authors">
					{translate key="search.author"}
				</label>
				{block name=searchAuthors}
					<input type="text" id="authors" name="authors" value="{$authors|escape}" class="border-gray-300 focus:border-{$baseColour2}-300 focus:ring focus:ring-{$baseColour2}-200 focus:ring-opacity-50 rounded-md shadow-sm dark:bg-gray-800 dark:border-gray-500 dark:text-white mt-1 block w-full">
				{/block}

				{if $searchableContexts}
					<label class="label label_contexts" for="searchJournal">
						{translate key="context.context"}
					</label>
					<select name="searchJournal" id="searchJournal">
						<option></option>
						{foreach from=$searchableContexts item="searchableContext"}
							<option value="{$searchableContext->id}" {if $searchJournal == $searchableContext->id}selected{/if}>
								{$searchableContext->name|escape}
							</option>
						{/foreach}
					</select>
				{/if}
			</div>
			{call_hook name="Templates::Search::SearchResults::AdditionalFilters"}
		</fieldset>

		<div class="submit">
			<button class="submit rounded-full bg-{$baseColour2}-300 py-2 px-4 text-sm font-semibold text-slate-900 hover:bg-{$baseColour2}-200 focus:outline-none focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-{$baseColour2}-300/50 active:bg-{$baseColour2}-500" type="submit">{translate key="common.search"}</button>
		</div>
	</form>

	{call_hook name="Templates::Search::SearchResults::PreResults"}

	<h2 class="pkp_screen_reader">{translate key="search.searchResults"}</h2>

	{* Results pagination *}
	{if !$results->wasEmpty()}
		{assign var="count" value=$results->count}
		<div class="pkp_screen_reader" role="status">
			{if $results->count > 1}
				{translate key="search.searchResults.foundPlural" count=$results->count}
			{else}
				{translate key="search.searchResults.foundSingle"}
			{/if}
		</div>
	{/if}

	{* Search results, finally! *}
	<ul class="search_results">
		{iterate from=results item=result}
			<li>
				{include file="frontend/objects/article_summary.tpl" article=$result.publishedSubmission journal=$result.journal showDatePublished=true hideGalleys=true heading="h3"}
			</li>
		{/iterate}
	</ul>

	{* No results found *}
	{if $results->wasEmpty()}
		<span role="status">
			{if $error}
				{include file="frontend/components/notification.tpl" type="error" message=$error|escape}
			{else}
				{include file="frontend/components/notification.tpl" type="notice" messageKey="search.noResults"}
			{/if}
		</span>

	{* Results pagination *}
	{else}
		<div class="cmp_pagination">
			{page_info iterator=$results}
			{page_links anchor="results" iterator=$results name="search" query=$query searchJournal=$searchJournal authors=$authors dateFromMonth=$dateFromMonth dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateToMonth=$dateToMonth dateToDay=$dateToDay dateToYear=$dateToYear}
		</div>
	{/if}

	{* Search Syntax Instructions *}
	{block name=searchSyntaxInstructions}{/block}
</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
