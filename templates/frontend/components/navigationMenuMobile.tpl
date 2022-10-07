{**
 * templates/frontend/components/navigationMenu.tpl
 *
 * Copyright (c) 2021-2022 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 *}
<button
    type="button"
    class="navbar-toggler text-white d-lg-none"
    data-mdb-toggle="modal"
    data-mdb-target="#exampleModal">
	<i class="fas fa-bars"></i>
</button>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel"></h5>
				<button type="button" class="btn-close" data-mdb-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
	      		<div>
		      		{capture assign="primaryMenu"}
						{load_menu name="primary" id="_navigationPrimary" ulClass="_pkp_navigation_primary d-block" liClass="text-dark"}
					{/capture}

					{* Primary navigation menu for current application *}
					{$primaryMenu}
				</div>

				<hr/>

				<div>
					{include file="frontend/components/navigationMenu2.tpl" ulClass="d-block" liClass="mx-0" showIcons=true}
					{* User navigation *}
					{load_menu name="user" id="_navigationUser" ulClass="_pkp_navigation_user d-block" liClass="profile text-dark"}
				</div>
			</div>
			<div class="modal-footer">
				
			</div>
		</div>
	</div>
</div>