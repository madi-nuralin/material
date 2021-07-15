<?php

/**
 * @defgroup plugins_themes_material Material theme plugin
 */
 
/**
 * @file plugins/themes/default/index.php
 *
 * Copyright (c) 2021 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @ingroup plugins_themes_material
 * @brief Wrapper for default theme plugin.
 *
 */

require_once('MaterialThemePlugin.inc.php');

return new MaterialThemePlugin();