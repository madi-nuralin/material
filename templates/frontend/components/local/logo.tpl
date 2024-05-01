{if $displayPageHeaderLogo}
	<a href="{url page="index" router=$smarty.const.ROUTE_PAGE}">
		<img
			src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}"
			width="{$displayPageHeaderLogo.width|escape}"
			height="{$displayPageHeaderLogo.height|escape}"
			{if $displayPageHeaderLogo.altText != ''}
				alt="{$displayPageHeaderLogo.altText|escape}"
			{/if}
			class="img-fluid"
			style="max-width: 180px;"/>
	</a>
{else}
	<a aria-label="Home page" href="/">
		{include file="frontend/components/ui/material_icon_logo.tpl" small=$small}
	</a>
{/if}