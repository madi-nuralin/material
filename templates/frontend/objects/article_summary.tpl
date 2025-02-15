{**
 * templates/frontend/objects/article_summary.tpl
 *
 * Copyright (c) 2021 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief View of an Article summary which is shown within a list of articles.
 *
 * @uses $article Article The article
 * @uses $authorUserGroups Traversible The set of author user groups
 * @uses $hasAccess bool Can this user access galleys for this context? The
 *       context may be an issue or an article
 * @uses $showDatePublished bool Show the date this article was published?
 * @uses $hideGalleys bool Hide the article galleys for this article?
 * @uses $primaryGenreIds array List of file genre ids for primary file types
 * @uses $heading string HTML heading element, default: h2
 *}
{assign var=publication value=$article->getCurrentPublication()}

{assign var=articlePath value=$publication->getData('urlPath')|default:$article->getId()}
{if !$heading}
	{assign var="heading" value="h2"}
{/if}

{if (!$section.hideAuthor && $publication->getData('hideAuthor') == \APP\submission\Submission::AUTHOR_TOC_DEFAULT) || $publication->getData('hideAuthor') == \APP\submission\Submission::AUTHOR_TOC_SHOW}
	{assign var="showAuthor" value=true}
{/if}

<div class="flex space-x-4">
    <div class="w-20 h-20 flex-shrink-0">
        {if $publication->getLocalizedData('coverImage')}
            <a {if $journal}href="{url journal=$journal->getPath() page="article" op="view" path=$articlePath}"{else}href="{url page="article" op="view" path=$articlePath}"{/if}>
                {assign var="coverImage" value=$publication->getLocalizedData('coverImage')}
                <img class="w-full h-full object-cover rounded-lg shadow" src="{$publication->getLocalizedCoverImageUrl($article->getData('contextId'))|escape}" alt="{$coverImage.altText|escape|default:''}" style="margin: 0 !important;">
            </a>
        {else}
            <div class="w-full h-full flex items-center justify-center rounded-md border border-slate-200 dark:border-slate-700 bg-slate-100 dark:bg-slate-800">
                <svg class="w-10 h-10 text-gray-500" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                    <path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zM5 19V5h14v14H5zm4-4l2.5-3 1.5 2 2.5-3 3 4H7zm2-6c.83 0 1.5-.67 1.5-1.5S11.83 6 11 6s-1.5.67-1.5 1.5S10.17 9 11 9z"></path>
                </svg>
            </div>
        {/if}
    </div>

    <div class="flex-1">
        <{$heading} class="text-sm font-semibold text-gray-900" style="margin-top: 0;">
            <a id="article-{$article->getId()}" {if $journal}href="{url journal=$journal->getPath() page="article" op="view" path=$articlePath}"{else}href="{url page="article" op="view" path=$articlePath}"{/if} class="hover:underline">
                {$publication->getLocalizedTitle(null, 'html')|strip_unsafe_html}
                {assign var=localizedSubtitle value=$publication->getLocalizedSubtitle(null, 'html')|strip_unsafe_html}
                {if $localizedSubtitle}
                    <span class="block text-xs text-gray-600">{$localizedSubtitle}</span>
                {/if}
            </a>
        </{$heading}>

        {assign var=submissionPages value=$publication->getData('pages')}
        {assign var=submissionDatePublished value=$publication->getData('datePublished')}
        {if $showAuthor || $submissionPages || ($submissionDatePublished && $showDatePublished)}
            <div class="text-xs text-gray-700 mt-1">
                {if $showAuthor}
                    <div class="font-medium text-gray-800 dark:text-gray-400">{$publication->getAuthorString($authorUserGroups)|escape}</div>
                {/if}
                {if $submissionPages}
                    <div>{$submissionPages|escape}</div>
                {/if}
                {if $showDatePublished && $submissionDatePublished}
                    <div class="text-gray-500">{$submissionDatePublished|date_format:$dateFormatShort}</div>
                {/if}
            </div>
        {/if}

        {if !$hideGalleys}
            <ul class="flex flex-wrap space-x-2 mt-2 text-xs text-blue-600">
                {foreach from=$article->getGalleys() item=galley}
                    {if $primaryGenreIds}
                        {assign var="file" value=$galley->getFile()}
                        {if !$galley->getRemoteUrl() && !($file && in_array($file->getGenreId(), $primaryGenreIds))}
                            {continue}
                        {/if}
                    {/if}
                    <li>
                        {assign var="hasArticleAccess" value=$hasAccess}
                        {if $currentContext->getSetting('publishingMode') == \APP\journal\Journal::PUBLISHING_MODE_OPEN || $publication->getData('accessStatus') == \APP\submission\Submission::ARTICLE_ACCESS_OPEN}
                            {assign var="hasArticleAccess" value=1}
                        {/if}
                        {assign var="id" value="article-{$article->getId()}-galley-{$galley->getId()}"}
                        {include file="frontend/objects/galley_link.tpl" parent=$article publication=$publication id=$id labelledBy="{$id} article-{$article->getId()}" hasAccess=$hasArticleAccess purchaseFee=$currentJournal->getData('purchaseArticleFee') purchaseCurrency=$currentJournal->getData('currency')}
                    </li>
                {/foreach}
            </ul>
        {/if}
    </div>

    {call_hook name="Templates::Issue::Issue::Article"}
</div>
