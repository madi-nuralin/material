{* Sidebars *}
{if empty($isFullWidth)}
  {capture assign="sidebarCode"}
  {call_hook name="Templates::Common::Sidebar"}{/capture}
  {if $sidebarCode}
    <ol class="mt-4 space-y-3 text-sm" role="list" aria-label="{translate|escape key="common.navigation.sidebar"}">
      {$sidebarCode}
    </ol><!-- pkp_sidebar.left -->
  {/if}
{/if}