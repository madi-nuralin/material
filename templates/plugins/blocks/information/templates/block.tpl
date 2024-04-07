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
			<a class="font-display font-medium text-slate-500 hover:text-slate-700 dark:text-slate-400 dark:hover:text-slate-300">
				{translate key="plugins.block.information.link"}
			</a>
		</h3>
		<ol role="list" class="mt-2 space-y-2 border-l-2 border-slate-100 lg:mt-4 lg:space-y-4 lg:border-slate-200 dark:border-slate-800">
			{if !empty($forReaders)}
				<li>
					<a class="block w-full pl-3.5 before:pointer-events-none before:absolute before:-left-1 before:top-1/2 before:h-1.5 before:w-1.5 before:-translate-y-1/2 before:rounded-full font-semibold text-slate-500 hover:text-slate-700 dark:text-slate-400 dark:hover:text-slate-300 _text-sky-500 _before:bg-sky-500" href="{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="information" op="readers"}">
						{translate key="navigation.infoForReaders"}
					</a>
				</li>
			{/if}
			{if !empty($forAuthors)}
				<li>
					<a class="block w-full pl-3.5 before:pointer-events-none before:absolute before:-left-1 before:top-1/2 before:h-1.5 before:w-1.5 before:-translate-y-1/2 before:rounded-full font-semibold text-slate-500 hover:text-slate-700 dark:text-slate-400 dark:hover:text-slate-300 _text-sky-500 _before:bg-sky-500" href="{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="information" op="authors"}">
						{translate key="navigation.infoForAuthors"}
					</a>
				</li>
			{/if}
			{if !empty($forLibrarians)}
				<li>
					<a class="block w-full pl-3.5 before:pointer-events-none before:absolute before:-left-1 before:top-1/2 before:h-1.5 before:w-1.5 before:-translate-y-1/2 before:rounded-full font-semibold text-slate-500 hover:text-slate-700 dark:text-slate-400 dark:hover:text-slate-300 _text-sky-500 _before:bg-sky-500" href="{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="information" op="librarians"}">
						{translate key="navigation.infoForLibrarians"}
					</a>
				</li>
			{/if}
		</ol>
	</li>
{/if}