{**
 * templates/common/helpLink.tpl
 *
 * Copyright (c) 2021 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief A link which can request the help panel open to a specific chapter
 *  and section
 *
 * @uses $helpFile string Markdown filename, eg - chapter_6_submissions.md
 * @uses $helpSection string Section reference, eg - second
 * @uses $helpText string Text for the link
 * @uses $helpTextKey string Locale key for the link text
 * @uses $helpClass string Class to add to the help link
 *}

<div class="d-flex justify-content-end">
    <a class="requestHelpPanel _pkp_help_link {$_helpClass|escape} btn bg-white btn-link" data-topic="{$helpFile|escape}"{if $helpSection} data-section="{$helpSection|escape}"{/if}>
    	<i class="fa fa-info-circle text-success"></i>
    	{if $helpText}
    		{$text|escape}
    	{else}
    		{translate key=$helpTextKey}
    	{/if}
    </a>
</div>

