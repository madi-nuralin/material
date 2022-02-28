{**
 * plugins/blocks/languageToggle/block.tpl
 *
 * Copyright (c) 2021 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Common site sidebar menu -- language toggle.
 *}
{if $enableLanguageToggle}
	{foreach from=$languageToggleLocales item=localeName key=localeKey}
		<li class="locale_{$localeKey|escape}{if $localeKey == $currentLocale} current{/if}" lang="{$localeKey|replace:"_":"-"}">
			<a href="{url router=$smarty.const.ROUTE_PAGE page="user" op="setLocale" path=$localeKey source=$smarty.server.REQUEST_URI}" class="dropdown-item">
				{assign var="localeString" value=str_replace(" ", "-", strtolower( locale_get_display_region($localeKey, 'en') ) )}
				{assign var="localeClass" value="flag flag-`$localeString`"}
				<i class="{$localeClass}"></i> {$localeName}

			</a>
		</li>
	{/foreach}
{/if}
