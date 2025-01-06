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
    {material_menu aria-label="{translate|escape key="common.navigation.sidebar"}"}
      {$sidebarCode}
    {/material_menu}<!-- pkp_sidebar.left -->
  {/if}
{/if}
