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

	<div class="py-6 max-w-4xl mx-auto">
	    {* Issue Cover Image *}
	    {assign var=issueCover value=$issue->getLocalizedCoverImageUrl()}
	    <div class="flex items-center space-x-4">
	        <div class="w-40 h-56 rounded-md border border-slate-200 dark:border-slate-700 overflow-hidden flex items-center justify-center bg-slate-100 dark:bg-slate-800">
	            {if $issueCover}
	                <img src="{$issueCover|escape}" alt="{$issue->getLocalizedCoverImageAltText()|escape|default:$defaultAltText}" class="w-full h-full object-cover">
	            {else}
	            	<div class="flex flex-col items-center">
	                    <svg xmlns="http://www.w3.org/2000/svg" class="w-16 h-16 text-gray-400" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1">
	                        <circle cx="12" cy="12" r="10" stroke="currentColor" stroke-width="" fill="none"/>
	                        <path d="M8 12h8M12 8v8" stroke-linecap="round" stroke-linejoin="round"/>
	                    </svg>
                    	<span class="text-gray-500 text-sm mt-2">No Cover</span>
                	</div>
	            {/if}
	        </div>
	        <div class="flex-1">
	            {* Issue Title & Description *}
	            {if $issue->hasDescription()}
	                <p class="text-gray-700 text-sm">{$issue->getLocalizedDescription()|strip_unsafe_html}</p>
	            {/if}
	            {* Published Date *}
	            {if $issue->getDatePublished()}
	                <p class="text-gray-600 text-sm mt-2">
	                    <span class="font-semibold">{translate key="submissions.published"}:</span>
	                    {$issue->getDatePublished()|date_format:$dateFormatShort}
	                </p>
	            {/if}
	        </div>
	    </div>

	    {* Full-issue Galleys *}
	    {if $issueGalleys}
	        <div class="mt-6">
	            <h2 class="text-lg font-semibold text-gray-900">{translate key="issue.fullIssue"}</h2>
	            <ul class="mt-2 space-y-2">
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
	                        <h2 class="text-lg font-semibold text-gray-900">{$section.title|escape}</h2>
	                    {/if}
	                    <ul class="mt-2 divide-y divide-gray-200">
	                        {foreach from=$section.articles item=article}
	                            <li class="py-4">
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
