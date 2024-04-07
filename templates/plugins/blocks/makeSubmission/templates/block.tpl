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
		<a class="font-normal text-slate-500 hover:text-slate-700 dark:text-slate-400 dark:hover:text-slate-300">
			{translate key="article.submission"}
		</a>
	</h3>

	<ol role="list" class="dark:text-slate-400">
		<li>
			<a class="hover:text-slate-600 dark:hover:text-slate-300" href="{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="about" op="submissions"}">
				{translate key="plugins.block.makeSubmission.linkLabel"}
			</a>
		</li>
	</ol>
</li>
