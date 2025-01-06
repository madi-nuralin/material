{**
 * plugins/blocks/makeSubmission/templates/block.tpl
 *
 * Copyright (c) 2021 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Common site sidebar menu -- "Make a Submission" block.
 *}
{material_menu_item}
	{material_menu_link}
		{translate key="article.submission"}
	{/material_menu_link}

	{material_submenu}
		{material_submenu_item}
			{material_submenu_link url="{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="about" op="submissions"}"}
				{translate key="plugins.block.makeSubmission.linkLabel"}
			{/material_submenu_link}
		{/material_submenu_item}
	{/material_submenu}
{/material_menu_item}
