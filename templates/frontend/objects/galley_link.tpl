{**
 * templates/frontend/objects/galley_link.tpl
 *
 * Copyright (c) 2021 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief View of a galley object as a link to view or download the galley, to be used
 *  in a list of galleys.
 *
 * @uses $galley Galley
 * @uses $parent Issue|Article Object which these galleys are attached to
 * @uses $publication Publication Optionally the publication (version) to which this galley is attached
 * @uses $isSupplementary bool Is this a supplementary file?
 * @uses $hasAccess bool Can this user access galleys for this context?
 * @uses $restrictOnlyPdf bool Is access only restricted to PDF galleys?
 * @uses $purchaseArticleEnabled bool Can this article be purchased?
 * @uses $currentJournal Journal The current journal context
 * @uses $journalOverride Journal An optional argument to override the current
 *       journal with a specific context
 *}

{* Override the $currentJournal context if desired *}
{if $journalOverride}
	{assign var="currentJournal" value=$journalOverride}
{/if}

{* Determine galley type and URL op *}
{if $galley->isPdfGalley()}
	{assign var="type" value="pdf"}
{else}
	{assign var="type" value="file"}
{/if}

{* Get page and parentId for URL *}
{if $parent instanceOf Issue}
	{assign var="page" value="issue"}
	{assign var="parentId" value=$parent->getBestIssueId()}
	{assign var="path" value=$parentId|to_array:$galley->getBestGalleyId()}
{else}
	{assign var="page" value="article"}
	{assign var="parentId" value=$parent->getBestId()}
	{* Get a versioned link if we have an older publication *}
	{if $publication && $publication->getId() !== $parent->getCurrentPublication()->getId()}
		{assign var="path" value=$parentId|to_array:"version":$publication->getId():$galley->getBestGalleyId()}
	{else}
		{assign var="path" value=$parentId|to_array:$galley->getBestGalleyId()}
	{/if}
{/if}

{* Get user access flag *}
{if !$hasAccess}
	{if $restrictOnlyPdf && $type=="pdf"}
		{assign var=restricted value="1"}
	{elseif !$restrictOnlyPdf}
		{assign var=restricted value="1"}
	{/if}
{/if}

{* Don't be frightened. This is just a link *}
<a class="
	not-prose inline-flex items-center space-x-1 rounded-full py-2 px-4 text-sm font-semibold
	{if $restricted}
		restricted
		text-white
		bg-red-800
		hover:bg-red-700
		focus:outline-none
		focus-visible:outline-2
		focus-visible:outline-offset-2
		focus-visible:outline-white/50
		active:text-red-400
	{else if $isSupplementary}
		obj_galley_link_supplementary
		text-white
		bg-slate-800
		hover:bg-slate-700
		focus:outline-none
		focus-visible:outline-2
		focus-visible:outline-offset-2
		focus-visible:outline-white/50
		active:text-slate-400
	{else}
		obj_galley_link 
		text-slate-900
		bg-{$activeTheme->getOption('baseColour')}-300
		hover:bg-{$activeTheme->getOption('baseColour')}-200
		focus:outline-none
		focus-visible:outline-2
		focus-visible:outline-offset-2
		focus-visible:outline-{$activeTheme->getOption('baseColour')}-300/50
		active:bg-{$activeTheme->getOption('baseColour')}-500
	{/if}"
	href="{url page=$page op="view" path=$path}"
	{if $labelledBy}
		aria-labelledby={$labelledBy}
	{/if}>

	<div>
		{if $restricted}
			{include file="frontend/components/ui/material_icon_lock.tpl"}
		{else if $type == "pdf"}
			{include file="frontend/components/ui/material_icon_pdf.tpl"}
		{else}
			{include file="frontend/components/ui/material_icon_file_text.tpl"}
		{/if}
	</div>

	{* Add some screen reader text to indicate if a galley is restricted *}
	{*if $restricted}
		<span class="pkp_screen_reader">
			{if $purchaseArticleEnabled}
				{translate key="reader.subscriptionOrFeeAccess"}
			{else}
				{translate key="reader.subscriptionAccess"}
			{/if}
		</span>
	{/if*}

	<div>
		{$galley->getGalleyLabel()|escape}
	</div>

	{if $restricted && $purchaseFee && $purchaseCurrency}
		<span class="purchase_cost">
			{translate key="reader.purchasePrice" price=$purchaseFee currency=$purchaseCurrency}
		</span>
	{/if}
</a>
