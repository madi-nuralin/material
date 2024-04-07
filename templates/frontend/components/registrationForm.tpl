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

<fieldset class="identity space-y-2">
	<legend>
		{translate key="user.profile"}
	</legend>
	<div class="fields space-y-2">
		<div class="given_name flex">
			<label class="block w-1/2">
				{translate key="user.givenName"}
				<span class="required" aria-hidden="true">*</span>
			</label>
			<input type="text"
				name="givenName"
				autocomplete="given-name"
				id="givenName"v
				alue="{$givenName|default:""|escape}"
				maxlength="255"
				required
				aria-required="true"
				class="block w-1/2">
		</div>
		<div class="family_name flex">
			<label class="block w-1/2">
				{translate key="user.familyName"}
			</label>
			<input type="text"
				name="familyName"
				autocomplete="family-name"
				id="familyName"
				value="{$familyName|default:""|escape}"
				maxlength="255"
				class="block w-1/2">
			</label>
		</div>
		<div class="affiliation flex">
			<label class="block w-1/2">
				{translate key="user.affiliation"}
				<span class="required" aria-hidden="true">*</span>
			</label>
			<input type="text"
				name="affiliation"
				autocomplete="organization"
				id="affiliation"
				value="{$affiliation|default:""|escape}"
				required
				aria-required="true"
				class="block w-1/2">
			</label>
		</div>
		<div class="country flex">
			<label class="block w-1/2">
				{translate key="common.country"}
				<span class="required" aria-hidden="true">*</span>
			</label>
			<select name="country"
				id="country"
				autocomplete="country-name"
				required
				aria-required="true"
				class="block w-1/2">
				<option></option>
				{html_options options=$countries selected=$country}
			</select>
		</div>
	</div>
</fieldset>

<fieldset class="login space-y-2">
	<legend>
		{translate key="user.login"}
	</legend>
	<div class="fields space-y-2">
		<div class="email flex">
			<label class="block w-1/2">
				{translate key="user.email"}
				<span class="required" aria-hidden="true">*</span>
			</label>
			<input type="email"
				name="email"
				id="email"
				value="{$email|default:""|escape}"
				maxlength="90"
				required
				aria-required="true"
				autocomplete="email"
				class="block w-1/2">
		</div>
		<div class="username flex">
			<label class="block w-1/2">
				{translate key="user.username"}
				<span class="required" aria-hidden="true">*</span>
			</label>
			<input type="text"
				name="username"
				id="username"
				value="{$username|default:""|escape}"
				maxlength="32"
				required
				aria-required="true"
				autocomplete="username"
				class="block w-1/2">
			</label>
		</div>
		<div class="password flex">
			<label class="block w-1/2">
				{translate key="user.password"}
				<span class="required" aria-hidden="true">*</span>
			</label>
			<input type="password"
				name="password"
				id="password"
				password="true"
				maxlength="32"
				required
				aria-required="true"
				autocomplete="new-password"
				class="block w-1/2">
		</div>
		<div class="password flex">
			<label class="block w-1/2">
				{translate key="user.repeatPassword"}
				<span class="required" aria-hidden="true">*</span>
				</span>
			</label>
			<input type="password"
				name="password2"
				id="password2"
				password="true"
				maxlength="32"
				required
				aria-required="true"
				autocomplete="new-password"
				class="block w-1/2">
		</div>
	</div>
</fieldset>
