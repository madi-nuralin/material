{**
 * templates/frontend/objects/issue_toc.tpl
 *
 * Copyright (c) 2014-2021 Simon Fraser University
 * Copyright (c) 2003-2021 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief View of an Issue which displays a full table of contents.
 *
 * @uses $issue Issue The issue
 * @uses $issueTitle string Title of the issue. May be empty
 * @uses $issueSeries string Vol/No/Year string for the issue
 * @uses $issueGalleys array Galleys for the entire issue
 * @uses $hasAccess bool Can this user access galleys for this context?
 * @uses $publishedSubmissions array Lists of articles published in this issue
 *   sorted by section.
 * @uses $primaryGenreIds array List of file genre ids for primary file types
 * @uses $heading string HTML heading element, default: h2
 *}
{if !$heading}
	{assign var="heading" value="h2"}
{/if}
{assign var="articleHeading" value="h3"}
{if $heading == "h3"}
	{assign var="articleHeading" value="h4"}
{elseif $heading == "h4"}
	{assign var="articleHeading" value="h5"}
{elseif $heading == "h5"}
	{assign var="articleHeading" value="h6"}
{/if}
<div class="obj_issue_toc">

	{* Indicate if this is only a preview *}
{if !$issue->getPublished()}
	{include file="frontend/components/notification.tpl" type="warning" messageKey="editor.issues.preview"}
{/if}
	<div class="not-prose mt-6 grid grid-cols-1 gap-x-6 gap-y-10 sm:grid-cols-2 lg:grid-cols-3 xl:gap-x-6">
		{assign var=issueCover value=$issue->getLocalizedCoverImageUrl()}
		{if $issueCover}
			<div class="group relative">
				<img src="{$issueCover|escape}" alt="{$issue->getLocalizedCoverImageAltText()|escape|default:''}" class="aspect-square lg:aspect-auto w-full border border-slate-100 dark:border-slate-800" style="margin: 0 !important;">
			</div>
		{/if}
		
		<div class="group relative lg:col-span-2">
			<div class="flex-1">
				{* Issue Title & Description *}
				{if $issue->hasDescription()}
					<p class="text-gray-700 text-sm">{$issue->getLocalizedDescription()|strip_unsafe_html}</p>
				{/if}
				{* Published Date *}
				{if $issue->getDatePublished()}
					<p class="text-gray-600 dark:text-gray-400 text-sm mt-2">
						<span class="font-semibold">{translate key="submissions.published"}:</span>
						{$issue->getDatePublished()|date_format:$dateFormatShort}
					</p>
				{/if}
			</div>
		</div>
	</div>

	<div class="py-6 max-w-4xl">
		{* Full-issue Galleys *}
		{if $issueGalleys}
			<div class="mt-6">
				<h2 class="text-lg font-semibold text-gray-900 dark:text-gray-200">{translate key="issue.fullIssue"}</h2>
				<ul class="not-prose space-x-2 list-none">
					{foreach from=$issueGalleys item=galley}
						<li>
							{include file="frontend/objects/galley_link.tpl" parent=$issue labelledBy="issueTocGalleyLabel" purchaseFee=$currentJournal->getData('purchaseIssueFee') purchaseCurrency=$currentJournal->getData('currency')}
						</li>
					{/foreach}
				</ul>
			</div>
		{/if}

		{* Articles *}
		<div class="mt-8 space-y-6">
			{foreach name=sections from=$publishedSubmissions item=section}
				{if $section.articles}
					<div>
						{if $section.title}
							<h2 class="text-lg font-semibold text-gray-900 dark:text-gray-200">{$section.title|escape}</h2>
						{/if}
						<ul role="list" class="divide-y divide-gray-100 dark:divide-gray-800" style="padding: 0;">
							{foreach from=$section.articles item=article}
								<li class="flex justify-between gap-x-6 pl-0 py-5">
									{include file="frontend/objects/article_summary.tpl" heading=$articleHeading}
								</li>
							{/foreach}
						</ul>
					</div>
				{/if}
			{/foreach}
		</div>
	</div>
</div>
