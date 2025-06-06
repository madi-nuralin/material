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
    <div class="w-20 h-20 flex-shrink-0 rounded-md border border-2 border-dashed border-slate-200 dark:border-slate-700">
        {if $publication->getLocalizedData('coverImage')}
            <a {if $journal}href="{url journal=$journal->getPath() page="article" op="view" path=$articlePath}"{else}href="{url page="article" op="view" path=$articlePath}"{/if}>
                {assign var="coverImage" value=$publication->getLocalizedData('coverImage')}
                <img class="w-full h-full object-contain" src="{$publication->getLocalizedCoverImageUrl($article->getData('contextId'))|escape}" alt="{$coverImage.altText|escape|default:''}" style="margin: 0 !important;">
            </a>
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
