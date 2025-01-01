{**
 * templates/frontend/components/sidebar.tpl
 *
 * Copyright (c) 2025 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Sidebars.
 *}

{* Sidebars *}
{if empty($isFullWidth)}
  {capture assign="sidebarCode"}
  {call_hook name="Templates::Common::Sidebar"}{/capture}
  {if $sidebarCode}
    <ol class="space-y-9 text-base lg:text-sm" role="list" aria-label="{translate|escape key="common.navigation.sidebar"}">
      {$sidebarCode}
    </ol><!-- pkp_sidebar.left -->
  {/if}
{/if}
