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

{assign var="horizontalRule" value="<hr/>"}

<div class="obj_issue_toc">

	{* Indicate if this is only a preview *}
	{if !$issue->getPublished()}
		{include file="frontend/components/notification.tpl" type="warning" messageKey="editor.issues.preview"}
	{/if}

	{* Issue introduction area above articles *}
	<div class="heading">

		{* Issue cover image *}
		{assign var=issueCover value=$issue->getLocalizedCoverImageUrl()}
		{if $issueCover}
			<a class="cover" href="{url op="view" page="issue" path=$issue->getBestIssueId()}">
				{capture assign="defaultAltText"}
					{translate key="issue.viewIssueIdentification" identification=$issue->getIssueIdentification()|escape}
				{/capture}
				<img class="img-fluid"
					src="{$issueCover|escape}"
					alt="{$issue->getLocalizedCoverImageAltText()|escape|default:$defaultAltText}">
			</a>
		{/if}

		{* Description *}
		{if $issue->hasDescription()}
			<div class="description text-muted">
				{$issue->getLocalizedDescription()|strip_unsafe_html}
			</div>
		{/if}

		{* PUb IDs (eg - DOI) *}
		{foreach from=$pubIdPlugins item=pubIdPlugin}
			{assign var=pubId value=$issue->getStoredPubId($pubIdPlugin->getPubIdType())}
			{if $pubId}
				{assign var="doiUrl" value=$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}
				<div class="pub_id {$pubIdPlugin->getPubIdType()|escape}">
					<span class="type text-muted">
						{$pubIdPlugin->getPubIdDisplayType()|escape}:
					</span>
					<span class="id">
						{if $doiUrl}
							<a href="{$doiUrl|escape}">
								{$doiUrl}
							</a>
						{else}
							{$pubId}
						{/if}
					</span>
				</div>
			{/if}
		{/foreach}

		{* Published date *}
		{if $issue->getDatePublished()}
			<div class="published">
				<span class="label text-muted">
					{translate key="submissions.published"}:
				</span>
				<span class="value base">
					{$issue->getDatePublished()|date_format:$dateFormatShort}
				</span>
			</div>
		{/if}
	</div>

	{* Full-issue galleys *}
	{if $issueGalleys}
		<div class="galleys">
			<ul class="galleys_links">
				{foreach from=$issueGalleys item=galley}
					<li>
						{include file="frontend/objects/galley_link.tpl" parent=$issue labelledBy="issueTocGalleyLabel" purchaseFee=$currentJournal->getData('purchaseIssueFee') purchaseCurrency=$currentJournal->getData('currency')}
					</li>
				{/foreach}
			</ul>
		</div>
	{/if}

	{* Articles *}
	<div class="sections accordion accordion-flush mt-2" id="section_accordion">
	{assign var=sectionCounter value=0}
	{foreach name=sections from=$publishedSubmissions item=section}
		<div class="section accordion-item">
		{assign var=sectionCounter value=$sectionCounter+1}
		{if $section.articles}
			{if $section.title}
				<h2 class="accordion-header" id="accordion-header-{$sectionCounter}">
					<button class="accordion-button collapsed px-0 text-start" type="button" data-mdb-toggle="collapse" data-mdb-target="#accordion-collapse-{$sectionCounter}" aria-expanded="false" aria-controls="accordion-collapse-{$sectionCounter}">
						{$section.title|escape}
					</button>
				</h2>
			{/if}
			<div id="accordion-collapse-{$sectionCounter}" class="accordion-collapse collapse show" aria-labelledby="accordion-header-{$sectionCounter}">
				<ul class="cmp_article_list articles accordion-body px-0">
					{foreach from=$section.articles item=article}
						<li>
							{include file="frontend/objects/article_summary.tpl" heading=$articleHeading}
						</li>
					{/foreach}
				</ul>
			</div>
		{/if}
		</div>
	{/foreach}
	</div><!-- .sections -->
</div>
