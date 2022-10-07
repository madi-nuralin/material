{**
 * plugins/blocks/makeSubmission/templates/block.tpl
 *
 * Copyright (c) 2021 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Common site sidebar menu -- "Make a Submission" block.
 *}
 
{**}
<li>
	<a href="{url router=$smarty.const.ROUTE_PAGE page="about" op="submissions"}" class="font-monospace">
		{translate key="plugins.block.makeSubmission.linkLabel"}
	</a>
</li>
{**}