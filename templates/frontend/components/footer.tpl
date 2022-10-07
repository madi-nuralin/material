{**
 * templates/frontend/components/footer.tpl
 *
 * Copyright (c) 2021 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Common site frontend footer.
 *
 * @uses $isFullWidth bool Should this page be displayed without sidebars? This
 *       represents a page-level override, and doesn't indicate whether or not
 *       sidebars have been configured for thesite.
 *}
		<div class="html-preloader bg-light">
			<div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
				<span class="visually-hidden">Loading...</span>
			</div>
		</div>

	</main><!-- _pkp_structure_main -->

{* Sidebars *}
{if empty($isFullWidth)}
	{capture assign="sidebarCode"}{call_hook name="Templates::Common::Sidebar"}{/capture}
	{if $sidebarCode}
		<ul class="list-group list-group-light container" role="complementary" aria-label="{translate|escape key="common.navigation.sidebar"}">
			{$sidebarCode}
		</ul><!-- pkp_sidebar.left -->
	{/if}
{/if}

{if $requestedPage !== 'login' && $requestedPage !== 'user'}
	<!-- ======= Footer ======= -->
  <footer class="footer" role="contentinfo">
    <div class="container">
      {if $pageFooter}
      	{$pageFooter}
      {/if}

      <div class="row justify-content-center text-center">
        <div class="col-md-7">
          <p class="copyright">&copy; Platform & Workflow by: <a href="{url page="about" op="aboutThisPublishingSystem"}"> Open Journal Systems</a></p>

          <div class="credits">
            Designed by <a href="https://github.com/madi-nuralin/material">Material Theme</a>
          </div>
        </div>
      </div>

    </div>
  </footer>
{/if}

{load_script context="frontend"}

{call_hook name="Templates::Common::Footer::PageFooter"}

</body>
</html>
