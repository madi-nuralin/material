{**
 * templates/frontend/components/registrationForm.tpl
 *
 * Copyright (c) 2014-2021 Simon Fraser University
 * Copyright (c) 2003-2021 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display the basic registration form fields
 *
 * @uses $locale string Locale key to use in the affiliate field
 * @uses $givenName string First name input entry if available
 * @uses $familyName string Last name input entry if available
 * @uses $countries array List of country options
 * @uses $country string The selected country if available
 * @uses $email string Email input entry if available
 * @uses $username string Username input entry if available
 *}

<fieldset class="mt-1">
	{*<legend class="btn btn-light btn-lg mb-4 text-end" type="button" data-mdb-toggle="collapse" data-mdb-target="#user_profile_collapse" aria-expanded="true" aria-controls="user_profile_collapse">
		{translate key="user.profile"}
	</legend>*}
	<div class="fields collapse show" id="user_profile_collapse">
		<div class="given_name mb-4 align-items-center">
			<label for="givenName" class="form-check-label label text-sm-end text-start">
				{translate key="user.givenName"}
				<span class="required" aria-hidden="true">
					<!--i class="fas fa-link fa-sm"></i-->
				</span>
				<span class="pkp_screen_reader">
					{translate key="common.required"}
				</span>
			</label>
			<div class="">
				<input type="text" name="givenName" autocomplete="given-name" id="givenName" value="{$givenName|escape}" maxlength="255" required aria-required="true" class="form-control">
			</div>
		</div>
		<div class="family_name mb-4 align-items-center">
			<label for="familyName" class="form-check-label label">
				{translate key="user.familyName"}
			</label>
			<div class="">
				<input type="text" name="familyName" autocomplete="family-name" id="familyName" value="{$familyName|escape}" maxlength="255" class="form-control">
			</div>
		</div>
		<div class="affiliation mb-4 align-items-center">
			<label for="affiliation" class="form-check-label label">
				{translate key="user.affiliation"}
				<span class="required" aria-hidden="true">
					<!--i class="fas fa-link fa-sm"></i-->
				</span>
				<span class="pkp_screen_reader">
					{translate key="common.required"}
				</span>
			</label>
			<div class="">
				<input type="text" name="affiliation" id="affiliation" value="{$affiliation|escape}" required aria-required="true" class="form-control">
			</div>
		</div>
		<div class="country mb-4 align-items-center">
			<label for="country" class="form-check-label label">
				{translate key="common.country"}
				<span class="required" aria-hidden="true">
					<!--i class="fas fa-link fa-sm"></i-->
				</span>
				<span class="pkp_screen_reader">
					{translate key="common.required"}
				</span>
			</label>
			<div class="">
				<select name="country" id="country" required aria-required="true" class="form-control">
					<option></option>
					{html_options options=$countries selected=$country}
				</select>
			</div>
		</div>
	</div>
</fieldset>

<fieldset class="">
	{*<legend class="btn btn-light btn-lg mb-4 text-end" type="button" data-mdb-toggle="collapse" data-mdb-target="#user_login_collapse" aria-expanded="true" aria-controls="user_login_collapse">
		{translate key="user.login"}
	</legend>*}
	<div class="fields collapse show" id="user_login_collapse">
		<div class="email mb-4 align-items-center">
			<label for="email" class="form-check-label label text-sm-end text-start">
				{translate key="user.email"}
				<span class="required" aria-hidden="true">
					<!--i class="fas fa-link fa-sm"></i-->
				</span>
				<span class="pkp_screen_reader">
					{translate key="common.required"}
				</span>
			</label>
			<div class="">
				<input type="email" name="email" id="email" value="{$email|escape}" maxlength="90" required aria-required="true" autocomplete="email" class="form-control">
				<small class="form-helper"></small>
			</div>
		</div>
		<div class="username mb-4 align-items-center">
			<label for="username" class="form-check-label label text-sm-end text-start">
				{translate key="user.username"}
				<span class="required" aria-hidden="true">
					<!--i class="fas fa-link fa-sm"></i-->
				</span>
				<span class="pkp_screen_reader">
					{translate key="common.required"}
				</span>
			</label>
			<div class="">
				<input type="text" name="username" id="username" value="{$username|escape}" maxlength="32" required aria-required="true" autocomplete="username" class="form-control">
				<small class="form-helper">
					<i class="fas fa-info-circle"></i>
					{translate key="user.register.usernameRestriction"}
				</small>
			</div>
		</div>
		<div class="password mb-4 align-items-center">
			<label for="password" class="form-check-label label text-sm-end text-start">
				{translate key="user.password"}
				<span class="required" aria-hidden="true">
					<!--i class="fas fa-link fa-sm"></i-->
				</span>
				<span class="pkp_screen_reader">
					{translate key="common.required"}
				</span>
			</label>
			<div class="">
				<input type="password" name="password" id="password" password="true" maxlength="32" required aria-required="true" class="form-control">
				<small class="form-helper">
					<i class="fas fa-info-circle"></i>
					{str_replace('{$length}', $minPasswordLength, {translate key="user.register.form.passwordLengthRestriction"})}
				</small>
			</div>
		</div>
		<div class="password mb-4 align-items-center">
			<label for="password2" class="form-check-label label text-sm-end text-start">
				{translate key="user.repeatPassword"}
				<span class="required" aria-hidden="true">
					<!--i class="fas fa-link fa-sm"></i-->
				</span>
				<span class="pkp_screen_reader">
					{translate key="common.required"}
				</span>
			</label>
			<div class="">
				<input type="password" name="password2" id="password2" password="true" maxlength="32" required aria-required="true" class="form-control">
			</div>
		</div>
	</div>
</fieldset>
