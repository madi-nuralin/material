{**
 * plugins/blocks/languageToggle/block.tpl
 *
 * Copyright (c) 2021 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Common site sidebar menu -- language toggle.
 *}
{if $enableLanguageToggle}
	{material_menu_item}
		{material_menu_link}
			{translate key="common.language"}
		{/material_menu_link}

		{material_submenu}
			{foreach from=$languageToggleLocales item=localeName key=localeKey}
				{material_submenu_item class="locale_{$localeKey|escape}{if $localeKey == $currentLocale} current{/if}" lang="{$localeKey|replace:"_":"-"}"}
					{material_submenu_link url="{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="user" op="setLocale" path=$localeKey source=$smarty.server.REQUEST_URI}"}
						{$localeName}
					{/material_submenu_link}
				{/material_submenu_item}
			{/foreach}
		{/material_submenu}
	{/material_menu_item}
{/if}
