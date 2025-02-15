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
	</main><!-- _pkp_structure_main -->

  {if $requestedPage !== 'login' && $requestedPage !== 'user'}
    <div class="hidden xl:sticky xl:top-[4.75rem] xl:-mr-6 xl:block xl:h-[calc(100vh-4.75rem)] xl:flex-none overflow-y-auto overflow-x-hidden xl:py-16 xl:pr-6 scrollbar-thin scrollbar-thumb-gray-400 scrollbar-track-gray-200 dark:scrollbar-thumb-gray-600 dark:scrollbar-track-gray-800">
      <nav aria-labelledby="on-this-page-title" class="w-56">
        <!--h2 id="on-this-page-title" class="font-display text-sm font-medium text-slate-900 dark:text-white">On this page</h2-->

        {include file="frontend/components/sidebar.tpl"}
      </nav>
    </div>
  {/if}
</div>

{if $requestedPage !== 'login' && $requestedPage !== 'user'}
  <!-- ======= Footer ======= -->
  <footer class="footer bg-slate-50 py-5 bottom-0 text-slate-400 dark:bg-transparent" role="contentinfo">
    <div class="w-full justify-center items-center text-center px-4">
      {if $pageFooter}
        <div class="py-5 text-slate-500 dark:text-slate-400">
            {$pageFooter}
        </div>
      {/if}
      <div class="text-sm">
        <p class="copyright">&copy; Platform & Workflow by: <a href="{url page="about" op="aboutThisPublishingSystem"}" class="hover:text-slate-500">Open Journal Systems</a></p>
        <div class="credits">
          Designed by <a href="https://github.com/madi-nuralin/material" class="hover:text-slate-500">Material Theme</a>
        </div>
      </div>
    </div>
  </footer>
{/if}

{load_script context="frontend"}

{call_hook name="Templates::Common::Footer::PageFooter"}

</body>
</html>
