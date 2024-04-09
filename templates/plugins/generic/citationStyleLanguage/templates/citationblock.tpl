{* How to cite *}
{if $citation}
	<div class="item citation">
		<section class="sub_item citation_display">
			<h3 class="label">
				{translate key="submission.howToCite"}
			</h3>
			<div class="value">
				<div id="citationOutput" role="region" aria-live="polite">
					{$citation}
				</div>
				<div class="citation_formats">
					<button class="citation_formats_button label" aria-controls="cslCitationFormats" aria-expanded="false" data-csl-dropdown="true">
						{translate key="submission.howToCite.citationFormats"}
					</button>
					<div id="cslCitationFormats" class="citation_formats_list" aria-hidden="true">
						<ul class="citation_formats_styles">
							{foreach from=$citationStyles item="citationStyle"}
								<li>
									<a
											aria-controls="citationOutput"
											href="{url page="citationstylelanguage" op="get" path=$citationStyle.id params=$citationArgs}"
											data-load-citation
											data-json-href="{url page="citationstylelanguage" op="get" path=$citationStyle.id params=$citationArgsJson}"
									>
										{$citationStyle.title|escape}
									</a>
								</li>
							{/foreach}
						</ul>
						{if count($citationDownloads)}
							<div class="label">
								{translate key="submission.howToCite.downloadCitation"}
							</div>
							<ul class="citation_formats_styles">
								{foreach from=$citationDownloads item="citationDownload"}
									<li>
										<a href="{url page="citationstylelanguage" op="download" path=$citationDownload.id params=$citationArgs}">
											<span class="fa fa-download"></span>
											{$citationDownload.title|escape}
										</a>
									</li>
								{/foreach}
							</ul>
						{/if}
					</div>
				</div>
			</div>
		</section>
	</div>
{/if}
