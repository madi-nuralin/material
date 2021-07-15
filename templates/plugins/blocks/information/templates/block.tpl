{**
 * plugins/blocks/information/block.tpl
 *
 * Copyright (c) 2021 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Common site sidebar menu -- information links.
 *
 *}

{*
{if !empty($forReaders) || !empty($forAuthors) || !empty($forLibrarians)}
	{if !empty($forReaders)}
		<li>
			<a href="{url router=$smarty.const.ROUTE_PAGE page="information" op="readers"}" class="dropdown-item">
				{translate key="navigation.infoForReaders"}
			</a>
		</li>
	{/if}
	{if !empty($forAuthors)}
		<li>
			<a href="{url router=$smarty.const.ROUTE_PAGE page="information" op="authors"}" class="dropdown-item">
				{translate key="navigation.infoForAuthors"}
			</a>
		</li>
	{/if}
	{if !empty($forLibrarians)}
		<li>
			<a href="{url router=$smarty.const.ROUTE_PAGE page="information" op="librarians"}" class="dropdown-item">
				{translate key="navigation.infoForLibrarians"}
			</a>
		</li>
	{/if}
	<li>
		<hr class="dropdown-divider" />
	</li>
{/if}
*}
