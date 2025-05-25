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
            <img src="{$issueCover|escape}" alt="{$issue->getLocalizedCoverImageAltText()|escape|default:''}" class="aspect-square lg:aspect-auto w-full border border-slate-100 dark:border-slate-800" style="margin: 0 !important;">
        </a>
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
