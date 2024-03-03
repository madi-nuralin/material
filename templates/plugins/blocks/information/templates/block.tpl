{**
 * plugins/blocks/information/block.tpl
 *
 * Copyright (c) 2021 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Common site sidebar menu -- information links.
 *
 *}

{if !empty($forReaders) || !empty($forAuthors) || !empty($forLibrarians)}
	<li>
		<h3>
			<a class="font-normal text-slate-500 hover:text-slate-700 dark:text-slate-400 dark:hover:text-slate-300">
				{translate key="plugins.block.information.link"}
			</a>
		</h3>
		<ol role="list" class="mt-2 space-y-3 pl-5 text-slate-500 dark:text-slate-400">
			{if !empty($forReaders)}
				<li>
					<a class="hover:text-slate-600 dark:hover:text-slate-300" href="{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="information" op="readers"}">
						{translate key="navigation.infoForReaders"}
					</a>
				</li>
			{/if}
			{if !empty($forAuthors)}
				<li>
					<a class="hover:text-slate-600 dark:hover:text-slate-300" href="{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="information" op="authors"}">
						{translate key="navigation.infoForAuthors"}
					</a>
				</li>
			{/if}
			{if !empty($forLibrarians)}
				<li>
					<a class="hover:text-slate-600 dark:hover:text-slate-300" href="{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="information" op="librarians"}">
						{translate key="navigation.infoForLibrarians"}
					</a>
				</li>
			{/if}
		</ol>
	</li>
{/if}