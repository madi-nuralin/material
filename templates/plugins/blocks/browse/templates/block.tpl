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

{**}
<li>
	<div class="dropdown">
		<a href="#" class="dropdown-toggle justify-content-center font-monospace" type="button" id="dropdown{translate|escape key="plugins.block.browse"}" data-mdb-toggle="dropdown" aria-expanded="false">
			{translate key="plugins.block.browse"}
		</a>
		<ul class="dropdown-menu" aria-labelledby="dropdown{translate|escape key="plugins.block.browse"}">
			{if $browseCategories}
				<li>
					{translate key="plugins.block.browse.category"}
					<ul>
						{foreach from=$browseCategories item=browseCategory}
							<li class="category_{$browseCategory->getId()}{if $browseCategory->getParentId()} is_sub{/if}{if $browseBlockSelectedCategory == $browseCategory->getPath()} current{/if}">
								<a href="{url router=$smarty.const.ROUTE_PAGE page="catalog" op="category" path=$browseCategory->getPath()|escape}" class="font-monospace">
									{$browseCategory->getLocalizedTitle()|escape}
								</a>
							</li>
						{/foreach}
					</ul>
				</li>
			{/if}
		</ul>
	</div>
</li>
{**}
