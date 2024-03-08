{**
 * templates/frontend/objects/issue_summary.tpl
 *
 * Copyright (c) 2014-2021 Simon Fraser University
 * Copyright (c) 2003-2021 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief View of an Issue which displays a summary for use in lists
 *
 * @uses $issue Issue The issue
 *}
{if $issue->getShowTitle()}
{assign var=issueTitle value=$issue->getLocalizedTitle()|escape}
{/if}
{assign var=issueSeries value=$issue->getIssueSeries()}
{assign var=issueCover value=$issue->getLocalizedCoverImageUrl()}

<div class="_obj_issue_summary">

	{if $issueCover}
		<a class="cover" href="{url op="view" path=$issue->getBestIssueId()}">
			<img src="{$issueCover|escape}" alt="{$issue->getLocalizedCoverImageAltText()|escape|default:''}">
		</a>
	{/if}

	<h3>
		<a class="title" href="{url op="view" path=$issue->getBestIssueId()}">
			{if $issueTitle}
				{$issueTitle|escape}
			{else}
				{$issueSeries|escape}
			{/if}
		</a>
	</h3>

	{if $issueTitle && $issueSeries}
		<p class="series">
			{$issueSeries|escape}
		</p>
	{/if}

	<p class="description">
		{$issue->getLocalizedDescription()|strip_unsafe_html}
	</p>

	<hr/>
</div><!-- .obj_issue_summary -->
