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

<fieldset class="identity space-y-2 mt-4">
	<legend>
		{translate key="user.profile"}
	</legend>
	<div class="fields space-y-2">
		<div class="given_name">
			{material_label for="givenName"}
				{translate key="user.givenName"}
				<span class="required" aria-hidden="true">*</span>
			{/material_label}
			{material_input type="text"
				name="givenName"
				autocomplete="given-name"
				id="givenName"
				alue="{$givenName|default:''|escape}"
				maxlength="255"
				required="true"
				aria-required="true"
				class="mt-1 block w-full"}
		</div>
		<div class="family_name">
			{material_label for="familyName"}
				{translate key="user.familyName"}
			{/material_label}
			{material_input type="text"
				name="familyName"
				autocomplete="family-name"
				id="familyName"
				value="{$familyName|default:''|escape}"
				maxlength="255"
				class="mt-1 block w-full"}
		</div>
		<div class="affiliation">
			{material_label for="affiliation"}
				{translate key="user.affiliation"}
				<span class="required" aria-hidden="true">*</span>
			{/material_label}
			{material_input type="text"
				name="affiliation"
				autocomplete="organization"
				id="affiliation"
				value="{$affiliation|default:''|escape}"
				required="true"
				aria-required="true"
				class="mt-1 block w-full"}
		</div>
		<div class="country">
			{material_label for="country"}
				{translate key="common.country"}
				<span class="required" aria-hidden="true">*</span>
			{/material_label}
			{material_select name="country"
				id="country"
				autocomplete="country-name"
				required="true"
				aria-required="true"
				class="mt-1 block w-full"}
				<option></option>
				{html_options options=$countries selected=$country}
			{/material_select}
		</div>
	</div>
</fieldset>

<fieldset class="login space-y-2 mt-4">
	<legend>
		{translate key="user.login"}
	</legend>
	<div class="fields space-y-2">
		<div class="email">
			{material_label for="email"}
				{translate key="user.email"}
				<span class="required" aria-hidden="true">*</span>
			{/material_label}
			{material_input type="email"
				name="email"
				id="email"
				value="{$email|default:""|escape}"
				maxlength="90"
				required="true"
				aria-required="true"
				autocomplete="email"
				class="mt-1 block w-full"}
		</div>
		<div class="username">
			{material_label for="username"}
				{translate key="user.username"}
				<span class="required" aria-hidden="true">*</span>
			{/material_label}
			{material_input type="text"
				name="username"
				id="username"
				value="{$username|default:''|escape}"
				maxlength="32"
				required="true"
				aria-required="true"
				autocomplete="username"
				class="mt-1 block w-full"}
		</div>
		<div class="password">
			{material_label for="password"}
				{translate key="user.password"}
				<span class="required" aria-hidden="true">*</span>
			{/material_label}
			{material_input type="password"
				name="password"
				id="password"
				password="true"
				maxlength="32"
				required="true"
				aria-required="true"
				autocomplete="new-password"
				class="mt-1 block w-full"}
		</div>
		<div class="password">
			{material_label for="password2"}
				{translate key="user.repeatPassword"}
				<span class="required" aria-hidden="true">*</span>
			{/material_label}
			{material_input type="password"
				name="password2"
				id="password2"
				password="true"
				maxlength="32"
				required="true"
				aria-required="true"
				autocomplete="new-password"
				class="mt-1 block w-full"}
		</div>
	</div>
</fieldset>
