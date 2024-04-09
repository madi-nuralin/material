{**
 * templates/block.tpl
 *
 * Copyright (c) 2021 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file LICENSE.
 *
 * @brief Common site sidebar menu for browsing the catalog.
 *
 * @uses $browseNewReleases bool Whether or not to show a new releases link
 * @uses $browseCategoryFactory object Category factory providing access to
 *  browseable categories.
 * @uses $browseSeriesFactory object Series factory providing access to
 *  browseable series.
 *}
<li>
	<h3>
		<a class="font-display font-medium text-slate-500 hover:text-slate-700 dark:text-slate-400 dark:hover:text-slate-300">
		{translate key="plugins.block.browse"}
	</h3>

	<ol role="list" class="mt-2 space-y-2 border-l-2 border-slate-100 lg:mt-4 lg:space-y-4 lg:border-slate-200 dark:border-slate-800" aria-label="{translate|escape key="plugins.block.browse"}">
		{if $browseCategories}
			<li class="has_submenu">
				<a class="block w-full pl-3.5 before:pointer-events-none before:absolute before:-left-1 before:top-1/2 before:h-1.5 before:w-1.5 before:-translate-y-1/2 before:rounded-full font-semibold text-slate-500 hover:text-slate-700 dark:text-slate-400 dark:hover:text-slate-300 _text-sky-500 _before:bg-sky-500">
					{translate key="plugins.block.browse.category"}
				</a>
				<ul>
					{foreach from=$browseCategories item=browseCategory}
						{if !$browseSeriesItem->getIsInactive()}
							<li class="category_{$browseCategory->getId()}{if $browseCategory->getParentId()} is_sub{/if}{if $browseBlockSelectedCategory == $browseCategory->getPath()} current{/if}">
								<a href="{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="catalog" op="category" path=$browseCategory->getPath()|escape}">
									{$browseCategory->getLocalizedTitle()|escape}
								</a>
							</li>
						{/if}
					{/foreach}
				</ul>
			</li>
		{/if}
	</ol>
</li><!-- .block_browse -->
