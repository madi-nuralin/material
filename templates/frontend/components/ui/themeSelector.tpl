{assign var="active" value='Light'}

{*foreach $themes as $theme}
  {if $active == $theme.name}
    <button class="flex h-8 w-8 items-center justify-center rounded-lg shadow-md shadow-black/5 ring-1 ring-black/5 dark:bg-slate-700 dark:ring-inset dark:ring-white/5" aria-label="Theme" id="headlessui-listbox-button-:r1:" type="button" aria-haspopup="listbox" aria-expanded="false" data-headlessui-state="" aria-labelledby="headlessui-listbox-label-:r0: headlessui-listbox-button-:r1:" onclick="document.documentElement.classList.add('dark')" x-data="{}">
      {include file=$theme.path}
    </button>
  {/if}
{/foreach*}

{literal}
  <div x-data="{ theme: $store.darkMode }">
    <button class="flex h-8 w-8 items-center justify-center rounded-lg shadow-md shadow-black/5 ring-1 ring-black/5 dark:bg-slate-700 dark:ring-inset dark:ring-white/5" aria-label="Theme" id="headlessui-listbox-button-:r1:" type="button" aria-haspopup="listbox" aria-expanded="false" data-headlessui-state="" aria-labelledby="headlessui-listbox-label-:r0: headlessui-listbox-button-:r1:" @click="(theme === 'Dark') ? (theme = 'Light',document.documentElement.classList.remove('dark')) : (theme = 'Dark',document.documentElement.classList.add('dark'))">
      <!--div x-show="theme=='System'">
        <svg aria-hidden="true" viewBox="0 0 16 16" class="h-4 w-4 fill-slate-400">
          <path
            fillRule="evenodd"
            clipRule="evenodd"
            d="M1 4a3 3 0 0 1 3-3h8a3 3 0 0 1 3 3v4a3 3 0 0 1-3 3h-1.5l.31 1.242c.084.333.36.573.63.808.091.08.182.158.264.24A1 1 0 0 1 11 15H5a1 1 0 0 1-.704-1.71c.082-.082.173-.16.264-.24.27-.235.546-.475.63-.808L5.5 11H4a3 3 0 0 1-3-3V4Zm3-1a1 1 0 0 0-1 1v4a1 1 0 0 0 1 1h8a1 1 0 0 0 1-1V4a1 1 0 0 0-1-1H4Z"
          />
        </svg>
      </div-->
      <div x-show="theme=='Light'">
        <svg aria-hidden="true" viewBox="0 0 16 16" class="h-4 w-4 fill-slate-400">
          <path
              fillRule="evenodd"
              clipRule="evenodd"
              d="M7 1a1 1 0 0 1 2 0v1a1 1 0 1 1-2 0V1Zm4 7a3 3 0 1 1-6 0 3 3 0 0 1 6 0Zm2.657-5.657a1 1 0 0 0-1.414 0l-.707.707a1 1 0 0 0 1.414 1.414l.707-.707a1 1 0 0 0 0-1.414Zm-1.415 11.313-.707-.707a1 1 0 0 1 1.415-1.415l.707.708a1 1 0 0 1-1.415 1.414ZM16 7.999a1 1 0 0 0-1-1h-1a1 1 0 1 0 0 2h1a1 1 0 0 0 1-1ZM7 14a1 1 0 1 1 2 0v1a1 1 0 1 1-2 0v-1Zm-2.536-2.464a1 1 0 0 0-1.414 0l-.707.707a1 1 0 0 0 1.414 1.414l.707-.707a1 1 0 0 0 0-1.414Zm0-8.486A1 1 0 0 1 3.05 4.464l-.707-.707a1 1 0 0 1 1.414-1.414l.707.707ZM3 8a1 1 0 0 0-1-1H1a1 1 0 0 0 0 2h1a1 1 0 0 0 1-1Z"
          />
      </svg>
      </div>
      <div x-show="theme=='Dark'">
        <svg aria-hidden="true" viewBox="0 0 16 16" class="h-4 w-4 fill-slate-400">
          <path
            fillRule="evenodd"
            clipRule="evenodd"
            d="M7.23 3.333C7.757 2.905 7.68 2 7 2a6 6 0 1 0 0 12c.68 0 .758-.905.23-1.332A5.989 5.989 0 0 1 5 8c0-1.885.87-3.568 2.23-4.668ZM12 5a1 1 0 0 1 1 1 1 1 0 0 0 1 1 1 1 0 1 1 0 2 1 1 0 0 0-1 1 1 1 0 1 1-2 0 1 1 0 0 0-1-1 1 1 0 1 1 0-2 1 1 0 0 0 1-1 1 1 0 0 1 1-1Z"
          />
        </svg>
      </div>
    </button>
    <script>
      document.addEventListener('alpine:init', () => {
          Alpine.store('darkMode', 'Light')
      })
  </script>
  </div>
{/literal}