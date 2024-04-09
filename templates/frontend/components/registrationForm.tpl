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
{assign var="baseColour2" value=$activeTheme->getOption('baseColour2')}

<fieldset class="identity space-y-2">
	<legend>
		{translate key="user.profile"}
	</legend>
	<div class="fields space-y-2">
		<div class="given_name">
			<label class="block font-medium text-sm text-gray-700 dark:text-gray-400 w-full">
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
				class="border-gray-300 focus:border-{$baseColour2}-300 focus:ring focus:ring-{$baseColour2}-200 focus:ring-opacity-50 rounded-md shadow-sm dark:bg-gray-800 dark:border-gray-500 dark:text-white mt-1 block w-full">
		</div>
		<div class="family_name">
			<label class="block font-medium text-sm text-gray-700 dark:text-gray-400 w-full">
				{translate key="user.familyName"}
			</label>
			<input type="text"
				name="familyName"
				autocomplete="family-name"
				id="familyName"
				value="{$familyName|default:""|escape}"
				maxlength="255"
				class="border-gray-300 focus:border-{$baseColour2}-300 focus:ring focus:ring-{$baseColour2}-200 focus:ring-opacity-50 rounded-md shadow-sm dark:bg-gray-800 dark:border-gray-500 dark:text-white mt-1 block w-full">
			</label>
		</div>
		<div class="affiliation">
			<label class="block font-medium text-sm text-gray-700 dark:text-gray-400 w-full">
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
				class="border-gray-300 focus:border-{$baseColour2}-300 focus:ring focus:ring-{$baseColour2}-200 focus:ring-opacity-50 rounded-md shadow-sm dark:bg-gray-800 dark:border-gray-500 dark:text-white mt-1 block w-full">
			</label>
		</div>
		<div class="country">
			<label class="block font-medium text-sm text-gray-700 dark:text-gray-400 w-full">
				{translate key="common.country"}
				<span class="required" aria-hidden="true">*</span>
			</label>
			<select name="country"
				id="country"
				autocomplete="country-name"
				required
				aria-required="true"
				class="border-gray-300 focus:border-{$baseColour2}-300 focus:ring focus:ring-{$baseColour2}-200 focus:ring-opacity-50 rounded-md shadow-sm dark:bg-gray-800 dark:border-gray-500 dark:text-white mt-1 block w-full">
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
		<div class="email">
			<label class="block font-medium text-sm text-gray-700 dark:text-gray-400 w-full">
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
				class="border-gray-300 focus:border-{$baseColour2}-300 focus:ring focus:ring-{$baseColour2}-200 focus:ring-opacity-50 rounded-md shadow-sm dark:bg-gray-800 dark:border-gray-500 dark:text-white mt-1 block w-full">
		</div>
		<div class="username">
			<label class="block font-medium text-sm text-gray-700 dark:text-gray-400 w-full">
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
				class="border-gray-300 focus:border-{$baseColour2}-300 focus:ring focus:ring-{$baseColour2}-200 focus:ring-opacity-50 rounded-md shadow-sm dark:bg-gray-800 dark:border-gray-500 dark:text-white mt-1 block w-full">
			</label>
		</div>
		<div class="password">
			<label class="block font-medium text-sm text-gray-700 dark:text-gray-400 w-full">
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
				class="border-gray-300 focus:border-{$baseColour2}-300 focus:ring focus:ring-{$baseColour2}-200 focus:ring-opacity-50 rounded-md shadow-sm dark:bg-gray-800 dark:border-gray-500 dark:text-white mt-1 block w-full">
		</div>
		<div class="password">
			<label class="block font-medium text-sm text-gray-700 dark:text-gray-400 w-full">
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
				class="border-gray-300 focus:border-{$baseColour2}-300 focus:ring focus:ring-{$baseColour2}-200 focus:ring-opacity-50 rounded-md shadow-sm dark:bg-gray-800 dark:border-gray-500 dark:text-white mt-1 block w-full">
		</div>
	</div>
</fieldset>
