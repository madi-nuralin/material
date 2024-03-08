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
      </div>
    </article>

    {*if $requestedPage !== 'login' && $requestedPage !== 'user'}
      <!-- ======= Footer ======= -->
      <footer class="footer pt-5 bottom-0" role="contentinfo">
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
    {/if*}

	</main><!-- _pkp_structure_main -->
  <div class="hidden xl:sticky xl:top-[4.75rem] xl:-mr-6 xl:block xl:h-[calc(100vh-4.75rem)] xl:flex-none xl:overflow-y-auto xl:py-16 xl:pr-6">
      <nav aria-labelledby="on-this-page-title" class="w-56">
        <!--h2 id="on-this-page-title" class="font-display text-sm font-medium text-slate-900 dark:text-white">On this page</h2-->

        {* Sidebars *}
        {if $requestedPage !== 'login' && $requestedPage !== 'user'}
          {if empty($isFullWidth)}
            {capture assign="sidebarCode"}{call_hook name="Templates::Common::Sidebar"}{/capture}
            {if $sidebarCode}
              <ol class="mt-4 space-y-3 text-sm" role="list" aria-label="{translate|escape key="common.navigation.sidebar"}">
                {$sidebarCode}
              </ol><!-- pkp_sidebar.left -->
            {/if}
          {/if}
        {/if}
      </nav>
    </div>
</div>

{load_script context="frontend"}

{call_hook name="Templates::Common::Footer::PageFooter"}

</body>
</html>
