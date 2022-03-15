{**
 * templates/frontend/pages/message.tpl
 *
 * Copyright (c) 2021 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Generic message page.
 * Displays a simple message and (optionally) a return link.
 *}
{include file="frontend/components/header.tpl"}

<div class="row d-flex justify-content-center">
	<div class="col-lg-5 col-md-12 bg-white">
		<div class="page page_message p-4">
			{include file="frontend/components/breadcrumbs.tpl" currentTitleKey=$pageTitle}
			
			<div class="description">
				{if $messageTranslated}
					{$messageTranslated}
				{else}
					{translate key=$message}
				{/if}
			</div>
			{if $backLink}
				<div class="cmp_back_link">
					<a href="{$backLink}">{translate key=$backLinkLabel}</a>
				</div>
			{/if}
		</div>
	</div>
</div>

{include file="frontend/components/footer.tpl"}
