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
        <a href="{url op="view" path=$issue->getBestIssueId()}">
            <img src="{$issueCover|escape}" alt="{$issue->getLocalizedCoverImageAltText()|escape|default:''}" class="aspect-square w-full rounded-md bg-slate-100 object-cover group-hover:opacity-75 lg:aspect-auto lg:h-80" style="margin: 0 !important;">
        </a>
    {else}
        <div class="aspect-square w-full rounded-md border border-slate-200 dark:border-slate-700 bg-slate-100 dark:bg-slate-800 lg:aspect-auto lg:h-80 flex flex-col justify-center items-center text-center">
            <div class="flex flex-col items-center">
                <svg xmlns="http://www.w3.org/2000/svg" class="sm:w-16 sm:h-16 w-24 h-24 text-gray-400" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1">
                    <circle cx="12" cy="12" r="10" stroke="currentColor" stroke-width="" fill="none"/>
                    <path d="M8 12h8M12 8v8" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
                <span class="text-gray-500 text-sm mt-2">No Cover</span>
            </div>
        </div>
    {/if}
    <div class="mt-4 flex justify-between">
        <div>
            <h3 class="text-sm text-gray-700">
                <a class="title" href="{url op="view" path=$issue->getBestIssueId()}" >
                    <span aria-hidden="true" class="absolute inset-0"></span>
                    {if $issueTitle}
                        {$issueTitle|escape}
                    {else}
                        {$issueSeries|escape}
                    {/if}
                </a>
            </h3>
            {if $issueTitle && $issueSeries}
                <p class="mt-1 text-sm text-gray-500">
                    {$issueSeries|escape}
                </p>
            {/if}
            <p class="mt-1 text-sm text-gray-500">
                {$issue->getLocalizedDescription()|strip_unsafe_html}
            </p>
        </div>    
    </div>
</div><!-- .obj_issue_summary -->
