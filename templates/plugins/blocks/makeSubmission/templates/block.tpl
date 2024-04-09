{**
 * plugins/blocks/makeSubmission/templates/block.tpl
 *
 * Copyright (c) 2021 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Common site sidebar menu -- "Make a Submission" block.
 *}
<li>
	<h3>
		<a class="font-display font-medium text-slate-500 hover:text-slate-700 dark:text-slate-400 dark:hover:text-slate-300">
			{translate key="article.submission"}
		</a>
	</h3>

	<ol role="list" class="mt-2 space-y-2 border-l-2 border-slate-100 lg:mt-4 lg:space-y-4 lg:border-slate-200 dark:border-slate-800">
		<li>
			<a class="block w-full pl-3.5 before:pointer-events-none before:absolute before:-left-1 before:top-1/2 before:h-1.5 before:w-1.5 before:-translate-y-1/2 before:rounded-full font-semibold text-slate-500 hover:text-slate-700 dark:text-slate-400 dark:hover:text-slate-300 _text-sky-500 _before:bg-sky-500" href="{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="about" op="submissions"}">
				{translate key="plugins.block.makeSubmission.linkLabel"}
			</a>
		</li>
	</ol>
</li>
