{**
 * plugins/blocks/languageToggle/block.tpl
 *
 * Copyright (c) 2021 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Common site sidebar menu -- language toggle.
 *}
{if $enableLanguageToggle}
	<li>
		<h3>
			<a class="font-normal text-slate-500 hover:text-slate-700 dark:text-slate-400 dark:hover:text-slate-300">
				{translate key="common.language"}
			</a>
		</h3>

		<ol role="list" class="mt-2 space-y-3 pl-5 text-slate-500 dark:text-slate-400">
			{foreach from=$languageToggleLocales item=localeName key=localeKey}
				<li class="locale_{$localeKey|escape}{if $localeKey == $currentLocale} current{/if}" lang="{$localeKey|replace:"_":"-"}">
					<a class="hover:text-slate-600 dark:hover:text-slate-300" href="{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="user" op="setLocale" path=$localeKey source=$smarty.server.REQUEST_URI}">
						{$localeName}
					</a>
				</li>
			{/foreach}
		</ol>
	</li>
{/if}
