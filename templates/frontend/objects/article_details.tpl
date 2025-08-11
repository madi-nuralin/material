{**
 * templates/frontend/objects/article_details.tpl
 *
 * Copyright (c) 2014-2021 Simon Fraser University
 * Copyright (c) 2003-2021 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief View of an Article which displays all details about the article.
 *  Expected to be primary object on the page.
 *
 * Many journals will want to add custom data to this object, either through
 * plugins which attach to hooks on the page or by editing the template
 * themselves. In order to facilitate this, a flexible layout markup pattern has
 * been implemented. If followed, plugins and other content can provide markup
 * in a way that will render consistently with other items on the page. This
 * pattern is used in the .main_entry column and the .entry_details column. It
 * consists of the following:
 *
 * <!-- Wrapper class which provides proper spacing between components -->
 * <div class="item">
 *     <!-- Title/value combination -->
 *     <div class="label">Abstract</div>
 *     <div class="value">Value</div>
 * </div>
 *
 * All styling should be applied by class name, so that titles may use heading
 * elements (eg, <h3>) or any element required.
 *
 * <!-- Example: component with multiple title/value combinations -->
 * <div class="item">
 *     <div class="sub_item">
 *         <div class="label">DOI</div>
 *         <div class="value">12345678</div>
 *     </div>
 *     <div class="sub_item">
 *         <div class="label">Published Date</div>
 *         <div class="value">2015-01-01</div>
 *     </div>
 * </div>
 *
 * <!-- Example: component with no title -->
 * <div class="item">
 *     <div class="value">Whatever you'd like</div>
 * </div>
 *
 * Core components are produced manually below, but can also be added via
 * plugins using the hooks provided:
 *
 * Templates::Article::Main
 * Templates::Article::Details
 *
 * @uses $article Submission This article
 * @uses $publication Publication The publication being displayed
 * @uses $firstPublication Publication The first published version of this article
 * @uses $currentPublication Publication The most recently published version of this article
 * @uses $issue Issue The issue this article is assigned to
 * @uses $section Section The journal section this article is assigned to
 * @uses $categories Category The category this article is assigned to
 * @uses $primaryGalleys array List of article galleys that are not supplementary or dependent
 * @uses $supplementaryGalleys array List of article galleys that are supplementary
 * @uses $keywords array List of keywords assigned to this article
 * @uses $pubIdPlugins Array of pubId plugins which this article may be assigned
 * @uses $licenseTerms string License terms.
 * @uses $licenseUrl string URL to license. Only assigned if license should be
 *   included with published submissions.
 * @uses $ccLicenseBadge string An image and text with details about the license
 *}
 {if !$heading}
	{assign var="heading" value="h3"}
 {/if}
<article class="obj_article_details">

	{* Indicate if this is only a preview *}
	{if $publication->getData('status') !== \PKP\submission\PKPSubmission::STATUS_PUBLISHED}
	<div class="cmp_notification notice">
		{capture assign="submissionUrl"}{url page="workflow" op="access" path=$article->getId()}{/capture}
		{translate key="submission.viewingPreview" url=$submissionUrl}
	</div>
	{* Notification that this is an old version *}
	{elseif $currentPublication->getId() !== $publication->getId()}
		<div class="cmp_notification notice">
			{capture assign="latestVersionUrl"}{url page="article" op="view" path=$article->getBestId()}{/capture}
			{translate key="submission.outdatedVersion"
				datePublished=$publication->getData('datePublished')|date_format:$dateFormatShort
				urlRecentVersion=$latestVersionUrl|escape
			}
		</div>
	{/if}

	<h1 class="page_title">
		{$publication->getLocalizedTitle(null, 'html')|strip_unsafe_html}
	</h1>

	{if $publication->getLocalizedData('subtitle')}
		<h2 class="subtitle">
			{$publication->getLocalizedSubTitle(null, 'html')|strip_unsafe_html}
		</h2>
	{/if}

	<div class="row not-prose">
		<div>
			<!--div class="px-4 sm:px-0">
				<h3 class="text-base/7 font-semibold text-white">Applicant Information</h3>
				<p class="mt-1 max-w-2xl text-sm/6 text-slate-400">Personal details and application.</p>
			</div-->
			<div class="mt-6 border-t border-slate-200 dark:border-slate-800">
				<dl class="divide-y divide-slate-200 dark:divide-slate-800 my-0">
					{if $publication->getData('authors')}
						<div class="px-4 py-6 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-0">
							<dt class="_text-sm/6 font-medium _text-slate-800">
								{translate key="article.authors"}
							</dt>
							<dd class="mt-1 _text-sm/6 text-slate-400 sm:col-span-2 sm:mt-0">
								<ul role="list" class="divide-y divide-slate-200 dark:divide-slate-800">
									{foreach from=$publication->getData('authors') item=author}
										<li class="flex justify-between gap-x-6 py-5">
											<div class="flex min-w-0 gap-x-4">
												<svg viewBox="0 0 24 24" fill="currentColor" data-slot="icon" aria-hidden="true" class="size-12 text-slate-500 sm:block hidden">
													<path d="M18.685 19.097A9.723 9.723 0 0 0 21.75 12c0-5.385-4.365-9.75-9.75-9.75S2.25 6.615 2.25 12a9.723 9.723 0 0 0 3.065 7.097A9.716 9.716 0 0 0 12 21.75a9.716 9.716 0 0 0 6.685-2.653Zm-12.54-1.285A7.486 7.486 0 0 1 12 15a7.486 7.486 0 0 1 5.855 2.812A8.224 8.224 0 0 1 12 20.25a8.224 8.224 0 0 1-5.855-2.438ZM15.75 9a3.75 3.75 0 1 1-7.5 0 3.75 3.75 0 0 1 7.5 0Z" clip-rule="evenodd" fill-rule="evenodd"></path>
												</svg>
												<div class="flex flex-col justify-center">
													<p class="text-sm/6 font-semibold text-slate-900 dark:text-slate-300">
														{$author->getFullName()|escape}
													</p>

													{if count($author->getAffiliations()) > 0}
														<div class="text-sm/6 text-slate-900 dark:text-slate-400 flex space-x-1 items-center">
															<svg xmlns="http://www.w3.org/2000/svg"
																viewBox="0 0 24 24" class="w-4 h-4" 
																fill="none" 
																stroke="currentColor" stroke-width="1" stroke-linecap="round" stroke-linejoin="round">
																<path d="M20 9v11a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V9"/>
																<path d="M9 22V12h6v10M2 10.6L12 2l10 8.6"/>
															</svg>
															<div>
																<span class="affiliation">
																	{foreach name="affiliations" from=$author->getAffiliations() item="affiliation"}
																		<span>{$affiliation->getLocalizedName()|escape}</span>
																		{if $affiliation->getRor()}<a href="{$affiliation->getRor()|escape}">{$rorIdIcon}</a>{/if}
																		{if !$smarty.foreach.affiliations.last}{translate key="common.commaListSeparator"}{/if}
																	{/foreach}
																</span>
															</div>
														</div>
													{/if}
													
													{assign var=authorUserGroup value=$userGroupsById[$author->getData('userGroupId')]}
													{if $authorUserGroup->showTitle}
														<div class="text-sm/6 text-slate-900 dark:text-slate-400 flex space-x-1 items-center">
															<svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4"
																viewBox="0 0 24 24"
																fill="none"
																stroke="currentColor" stroke-width="1"
																stroke-linecap="round" stroke-linejoin="round">
																<path d="M5.52 19c.64-2.2 1.84-3 3.22-3h6.52c1.38 0 2.58.8 3.22 3"/>
																<circle cx="12" cy="10" r="3"/>
																<circle cx="12" cy="12" r="10"/>
															</svg>
															<div class="userGroup">
																{$authorUserGroup->getLocalizedData('name')|escape}
															</div>
														</div>
													{/if}
													
													{if $author->getData('orcid')}
														<div class="text-sm/6 text-slate-900 dark:text-slate-400 flex space-x-1 items-center">
															{if $author->hasVerifiedOrcid()}
																{$orcidIcon}
															{else}
																{include file="frontend/components/ui/material_icon_orcid.tpl"}
															{/if}
															<a href="{$author->getData('orcid')|escape}" target="_blank" class="break-words text-{$activeTheme->getOption('baseColour')}-400 ">
																{$author->getOrcidDisplayValue()|escape}
															</a>
														</div>
													{/if}
												</div>
											</div>
										</li>
									{/foreach}
								</ul>
							</dd>
						</div>
					{/if}

					{* DOI *}
					{assign var=doiObject value=$article->getCurrentPublication()->getData('doiObject')}
					{if $doiObject}
						{assign var="doiUrl" value=$doiObject->getData('resolvingUrl')|escape}
						<div class="px-4 py-6 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-0">
							<dt class="_text-sm/6 font-medium _text-slate-800">
								{capture assign=translatedDOI}{translate key="doi.readerDisplayName"}{/capture}
								{translate key="semicolon" label=$translatedDOI}
							</dt>
							<dd class="mt-1 _text-sm/6 text-slate-400 sm:col-span-2 sm:mt-0">
								<a href="{$doiUrl}" class="text-{$activeTheme->getOption('baseColour')}-400 break-words">
									{$doiUrl}
								</a>
							</dd>
						</div>
					{/if}

					{* Keywords *}
					{if !empty($publication->getLocalizedData('keywords'))}
						<div class="px-4 py-6 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-0">
							<dt class="_text-sm/6 font-medium _text-slate-800">
								{capture assign=translatedKeywords}{translate key="article.subject"}{/capture}
								{translate key="semicolon" label=$translatedKeywords}
							</dt>
							<dd class="mt-1 _text-sm/6 text-slate-400 sm:col-span-2 sm:mt-0">
								{foreach name="keywords" from=$publication->getLocalizedData('keywords') item="keyword"}
									{$keyword|escape}{if !$smarty.foreach.keywords.last}{translate key="common.commaListSeparator"}{/if}
								{/foreach}
							</dd>
						</div>
					{/if}

					{* Abstract *}
					{if $publication->getLocalizedData('abstract')}
						<div class="px-4 py-6 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-0">
							<dt class="_text-sm/6 font-medium _text-slate-800">
								{translate key="article.abstract"}
							</dt>
							<dd class="mt-1 _text-sm/6 text-slate-400 sm:col-span-2 sm:mt-0">
								{$publication->getLocalizedData('abstract')|strip_unsafe_html}
							</dd>
						</div>
					{/if}

					{call_hook name="Templates::Article::Main"}

					{* Usage statistics chart*}
					{if $activeTheme->getOption('displayStats') != 'none'}
						{$activeTheme->displayUsageStatsGraph($article->getId())}
						<div class="px-4 py-6 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-0">
							<dt class="_text-sm/6 font-medium _text-slate-800">
								{translate key="plugins.themes.default.displayStats.downloads"}
							</dt>
							<dd class="mt-1 _text-sm/6 text-slate-400 sm:col-span-2 sm:mt-0">
								<canvas class="usageStatsGraph" data-object-type="Submission" data-object-id="{$article->getId()|escape}"></canvas>
								<div class="usageStatsUnavailable" data-object-type="Submission" data-object-id="{$article->getId()|escape}">
									{translate key="plugins.themes.default.displayStats.noStats"}
								</div>
							</dd>
						</div>
					{/if}

					{* Author biographies *}
					{assign var="hasBiographies" value=0}
					{foreach from=$publication->getData('authors') item=author}
						{if $author->getLocalizedData('biography')}
							{assign var="hasBiographies" value=$hasBiographies+1}
						{/if}
					{/foreach}
					{if $hasBiographies}
						<div class="px-4 py-6 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-0">
							<dt class="_text-sm/6 font-medium _text-slate-800">
								{if $hasBiographies > 1}
									{translate key="submission.authorBiographies"}
								{else}
									{translate key="submission.authorBiography"}
								{/if}
							</dt>
							<dd class="mt-1 _text-sm/6 text-slate-400 sm:col-span-2 sm:mt-0">
								<ol class="authors">
									{foreach from=$publication->getData('authors') item=author}
										{if $author->getLocalizedData('biography')}
											<li class="sub_item">
												<div class="label text-sm/6 font-semibold text-slate-900 dark:text-slate-300">
													{if $author->getLocalizedAffiliationNamesAsString()}
														{capture assign="authorName"}{$author->getFullName()|escape}{/capture}
														{capture assign="authorAffiliations"} {$author->getLocalizedAffiliationNamesAsString(null, ', ')|escape} {/capture}
														{translate key="submission.authorWithAffiliation" name=$authorName affiliation=$authorAffiliations}
													{else}
														{$author->getFullName()|escape}
													{/if}
												</div>
												<div class="value">
													{$author->getLocalizedData('biography')|strip_unsafe_html}
												</div>
											</li>
										{/if}
									{/foreach}
								</ol>
							</dd>
						</div>
					{/if}


					{* References *}
					{if $parsedCitations || $publication->getData('citationsRaw')}
						<div class="px-4 py-6 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-0">
							<dt class="_text-sm/6 font-medium _text-slate-800">
								{translate key="submission.citations"}
							</dt>
							<dd class="mt-1 _text-sm/6 text-slate-400 sm:col-span-2 sm:mt-0">
								{if $parsedCitations}
									{foreach from=$parsedCitations item="parsedCitation"}
										<p>{$parsedCitation->getCitationWithLinks()|strip_unsafe_html} {call_hook name="Templates::Article::Details::Reference" citation=$parsedCitation}</p>
									{/foreach}
								{else}
									{$publication->getData('citationsRaw')|escape|nl2br}
								{/if}
							</dd>
						</div>
					{/if}

					{* Article/Issue cover image *}
					{if $publication->getLocalizedData('coverImage') || ($issue && $issue->getLocalizedCoverImage())}
						<div class="px-4 py-6 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-0">
							<dt class="_text-sm/6 font-medium _text-slate-800">
								Cover Image
							</dt>
							<dd class="mt-1 _text-sm/6 text-slate-400 sm:col-span-2 sm:mt-0">
								{if $publication->getLocalizedData('coverImage')}
									{assign var="coverImage" value=$publication->getLocalizedData('coverImage')}
									<img
										src="{$publication->getLocalizedCoverImageUrl($article->getData('contextId'))|escape}"
										alt="{$coverImage.altText|escape|default:''}"
										class="border border-slate-200 dark:border-slate-800 rounded-md object-contain"
										style="margin-top: 0;margin-bottom: 0;"
									>
								{else}
									<a href="{url page="issue" op="view" path=$issue->getBestIssueId()}">
										<img 
											src="{$issue->getLocalizedCoverImageUrl()|escape}" 
											alt="{$issue->getLocalizedCoverImageAltText()|escape|default:''}"
											class="border border-slate-200 dark:border-slate-800 rounded-md object-contain"
											style="margin-top: 0;margin-bottom: 0;"
										>
									</a>
								{/if}
							</dd>
						</div>
					{/if}

					{* Article Galleys *}
					{if $primaryGalleys}
						<div class="px-4 py-6 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-0">
							<dt class="_text-sm/6 font-medium _text-slate-800">
								{translate key="submission.downloads"}
							</dt>
							<dd class="mt-1 _text-sm/6 text-slate-400 sm:col-span-2 sm:mt-0">
								<ul role="list" class="flex space-x-2">
									{foreach from=$primaryGalleys item=galley}
										<li>
											{include file="frontend/objects/galley_link.tpl" parent=$article publication=$publication galley=$galley purchaseFee=$currentJournal->getData('purchaseArticleFee') purchaseCurrency=$currentJournal->getData('currency')}
										</li>
									{/foreach}
								</ul>
							</dd>
						</div>
					{/if}

					{if $supplementaryGalleys}
						<div class="px-4 py-6 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-0">
							<dt class="_text-sm/6 font-medium _text-slate-800">
								{translate key="submission.additionalFiles"}
							</dt>
							<dd class="mt-1 _text-sm/6 text-slate-400 sm:col-span-2 sm:mt-0">
								<ul role="list" class="flex space-x-2">
									{foreach from=$supplementaryGalleys item=galley}
										<li>
											{include file="frontend/objects/galley_link.tpl" parent=$article publication=$publication galley=$galley isSupplementary="1"}		
										</li>
									{/foreach}
								</ul>
							</dd>
						</div>
					{/if}

					{if $publication->getData('datePublished')}
						<div class="px-4 py-6 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-0">
							<dt class="_text-sm/6 font-medium _text-slate-800">
								{translate key="submissions.published"}
							</dt>
							<dd class="mt-1 _text-sm/6 text-slate-400 sm:col-span-2 sm:mt-0">
								{* If this is the original version *}
								{if $firstPublication->getId() === $publication->getId()}
									<span>{$firstPublication->getData('datePublished')|date_format:$dateFormatShort}</span>
								{* If this is an updated version *}
								{else}
									<span>{translate key="submission.updatedOn" datePublished=$firstPublication->getData('datePublished')|date_format:$dateFormatShort dateUpdated=$publication->getData('datePublished')|date_format:$dateFormatShort}</span>
								{/if}
							</dd>
						</div>

						{if count($article->getPublishedPublications()) > 1}
							<div class="px-4 py-6 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-0">
								<dt class="_text-sm/6 font-medium _text-slate-800">
									{translate key="submission.versions"}
								</dt>
								<dd class="mt-1 _text-sm/6 text-slate-400 sm:col-span-2 sm:mt-0">
									<ul class="value">
										{foreach from=array_reverse($article->getPublishedPublications()) item=iPublication}
											{capture assign="name"}{translate key="submission.versionIdentity" datePublished=$iPublication->getData('datePublished')|date_format:$dateFormatShort version=$iPublication->getData('version')}{/capture}
											<li>
												{if $iPublication->getId() === $publication->getId()}
													{$name}
												{elseif $iPublication->getId() === $currentPublication->getId()}
													<a class="text-{$activeTheme->getOption('baseColour')}-400" href="{url page="article" op="view" path=$article->getBestId()}">{$name}</a>
												{else}
													<a class="text-{$activeTheme->getOption('baseColour')}-400" href="{url page="article" op="view" path=$article->getBestId()|to_array:"version":$iPublication->getId()}">{$name}</a>
												{/if}
											</li>
										{/foreach}
									</ul>
								</dd>
							</div>
						{/if}
					{/if}

					{* Data Availability Statement *}
					{if $publication->getLocalizedData('dataAvailability')}
						<div class="px-4 py-6 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-0">
							<dt class="_text-sm/6 font-medium _text-slate-800">
								{translate key="submission.dataAvailability"}
							</dt>
							<dd class="mt-1 _text-sm/6 text-slate-400 sm:col-span-2 sm:mt-0">
								{$publication->getLocalizedData('dataAvailability')|strip_unsafe_html}
							</dd>
						</div>
					{/if}

					{* Issue article appears in *}
					{if $issue || $section || $categories}
						{if $issue}
							<div class="px-4 py-6 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-0">
								<dt class="_text-sm/6 font-medium _text-slate-800">
									{translate key="issue.issue"}
								</dt>
								<dd class="mt-1 _text-sm/6 text-slate-400 sm:col-span-2 sm:mt-0">
									<a class="title text-{$activeTheme->getOption('baseColour')}-400" href="{url page="issue" op="view" path=$issue->getBestIssueId()}">
										{$issue->getIssueIdentification()}
									</a>
								</dd>
							</div>
						{/if}

						{if $section}
							<div class="px-4 py-6 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-0">
								<dt class="_text-sm/6 font-medium _text-slate-800">
									{translate key="section.section"}
								</dt>
								<dd class="mt-1 _text-sm/6 text-slate-400 sm:col-span-2 sm:mt-0">
									{$section->getLocalizedTitle()|escape}
								</dd>
							</div>
						{/if}

						{if $categories}
							<div class="px-4 py-6 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-0">
								<dt class="_text-sm/6 font-medium _text-slate-800">
									{translate key="category.category"}
								</dt>
								<dd class="mt-1 _text-sm/6 text-slate-400 sm:col-span-2 sm:mt-0">
									<ul class="categories">
										{foreach from=$categories item=category}
											<li><a class="text-{$activeTheme->getOption('baseColour')}-400" href="{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="catalog" op="category" path=$category->getPath()|escape}">{$category->getLocalizedTitle()|escape}</a></li>
										{/foreach}
									</ul>
								</dd>
							</div>
						{/if}
					{/if}

					{* PubIds (requires plugins) *}
					{foreach from=$pubIdPlugins item=pubIdPlugin}
						{if $pubIdPlugin->getPubIdType() == 'doi'}
							{continue}
						{/if}
						{assign var=pubId value=$article->getStoredPubId($pubIdPlugin->getPubIdType())}
						{if $pubId}
							<div class="px-4 py-6 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-0">
								<dt class="_text-sm/6 font-medium _text-slate-800">
									{$pubIdPlugin->getPubIdDisplayType()|escape}
								</dt>
								<dd class="mt-1 _text-sm/6 text-slate-400 sm:col-span-2 sm:mt-0">
									{if $pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}
										<a id="pub-id::{$pubIdPlugin->getPubIdType()|escape}" href="{$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}" class="text-{$activeTheme->getOption('baseColour')}-400">
											{$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}
										</a>
									{else}
										{$pubId|escape}
									{/if}
								</dd>
							</div>
						{/if}
					{/foreach}

					{* Licensing info *}
					{if $currentContext->getLocalizedData('licenseTerms') || $publication->getData('licenseUrl')}
						<div class="px-4 py-6 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-0">
							<dt class="_text-sm/6 font-medium _text-slate-800">
								{translate key="submission.license"}
							</dt>
							<dd class="mt-1 _text-sm/6 text-slate-400 sm:col-span-2 sm:mt-0">
								{if $publication->getData('licenseUrl')}
									{if $ccLicenseBadge}
										{if $publication->getLocalizedData('copyrightHolder')}
											<p>{translate key="submission.copyrightStatement" copyrightHolder=$publication->getLocalizedData('copyrightHolder') copyrightYear=$publication->getData('copyrightYear')}</p>
										{/if}
										{$ccLicenseBadge}
									{else}
										<a href="{$publication->getData('licenseUrl')|escape}" class="copyright text-{$activeTheme->getOption('baseColour')}-400">
											{if $publication->getLocalizedData('copyrightHolder')}
												{translate key="submission.copyrightStatement" copyrightHolder=$publication->getLocalizedData('copyrightHolder') copyrightYear=$publication->getData('copyrightYear')}
											{else}
												{translate key="submission.license"}
											{/if}
										</a>
									{/if}
								{/if}
								{$currentContext->getLocalizedData('licenseTerms')}
							</dd>
						</div>
					{/if}
				</dl>		
			</div>

			{call_hook name="Templates::Article::Details"}

		</div>

	</div><!-- .row -->

</article>
