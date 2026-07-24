--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


let PLAYER_DATA = {};
let PLAYER_DATA_CHANGED_LISTENERS = [];

function _UpdatePlayerData(event) {
	// $.Msg("Player data updated");
	if (!event || !event.player_data) return;
	PLAYER_DATA = event.player_data;

	_Notify(PLAYER_DATA_CHANGED_LISTENERS, PLAYER_DATA);
}

GameUI.Player = {};

/**
 * Returns local player subscription tier.
 *
 * If local player data is not loaded (or missing), returns 0.
 * @returns {Number}
 */
GameUI.Player.GetSubscriptionTier = function () {
	return PLAYER_DATA.subscription ? PLAYER_DATA.subscription.tier : 0;
};

/**
 * Returns local player subscription data.
 *
 * Includes `tier`, `end_date` `type`, `metadata`
 * @returns {Object}
 */
GameUI.Player.GetSubscriptionData = function () {
	return PLAYER_DATA.subscription ? PLAYER_DATA.subscription : {};
};

GameUI.Player.GetSubscriptionType = function () {
	return GameUI.Player.GetSubscriptionData().type;
};

/**
 * Returns local player currency value.
 *
 * If local player data is not loaded (or missing), returns 0.
 * @returns {Number}
 */
GameUI.Player.GetCurrency = function () {
	return PLAYER_DATA.currency ? PLAYER_DATA.currency : 0;
};

/**
 * Returns table with local player settings, with setting name being the key.
 * @returns {Object}
 */
GameUI.Player.GetSettings = function () {
	return PLAYER_DATA.settings ? PLAYER_DATA.settings : {};
};

/**
 * Returns settings value under passed `setting_name`.
 * @param {String} setting_name
 * @returns
 */
GameUI.Player.GetSettingValue = function (setting_name) {
	return GameUI.Player.GetSettings()[setting_name];
};

/**
 * Sets setting value under `name` to `value`.
 *
 * WARNING: this setting eventually causes request to backend (throttled), changes made are permanent.
 * @param {String} name
 * @param {any} value
 */
GameUI.Player.SetSettingValue = function (name, value) {
	PLAYER_DATA.settings = PLAYER_DATA.settings || {};

	PLAYER_DATA.settings[name] = value;

	GameEvents.SendToServerEnsured("WebSettings:set_setting_value", {
		setting_name: name,
		setting_value: value,
	});
};

/**
 * Returns local player stats on current map.
 *
 * Stats contain `map_name`, `kills`, `deaths`, `assists`, `victories`, `defeats`, `streak_current`, `streak_max`,
 * `last_winner_heroes`, `rating`
 * @returns {Object}
 */
GameUI.Player.GetStats = function () {
	return PLAYER_DATA ? PLAYER_DATA.stats : {};
};

/**
 * Returns local player MMR on current map.
 * @returns {Number}
 */
GameUI.Player.GetRating = function () {
	const stats = GameUI.Player.GetStats();
	return stats.rating ? stats.rating : 1500;
};

/**
 * Returns local player Battle Pass data.
 *
 * Data contains `current_exp`, `level`, `redeemed_levels`.
 *
 * Redeemed levels is a dictionary, with key being battle pass rewards row, and value being array of levels redeemed.
 * @returns {Object}
 */
GameUI.Player.GetBattlePassData = function () {
	return PLAYER_DATA.battle_pass ? PLAYER_DATA.battle_pass : {};
};

/**
 * Returns local player punishment level, where 0 means player account is clean and anything above means some sort of punishment.
 * @returns {Number}
 */
GameUI.Player.GetPunishmentLevel = function () {
	return GameUI.Player.GetStats().punishment_level || 0;
};

/**
 * Register a `callback` to be called whenever local player data changes.
 * @param {CallableFunction} callback
 */
GameUI.Player.RegisterForPlayerDataChanges = function (callback) {
	PLAYER_DATA_CHANGED_LISTENERS.push(callback);
	if (Object.keys(PLAYER_DATA).length > 0) callback(PLAYER_DATA);
};

PLAYER_DATA_REQUESTED = false;

(() => {
	GameEvents.SubscribeProtected("WebPlayer:update", _UpdatePlayerData);

	GameEvents.Subscribe("game_rules_state_change", () => {
		// request once we reach hero selection (or later, if reconnected), but only once in client lifetime
		if (Game.GameStateIsBefore(DOTA_GameState.DOTA_GAMERULES_STATE_HERO_SELECTION)) return;
		if (PLAYER_DATA_REQUESTED) return;
		PLAYER_DATA_REQUESTED = true;
		GameEvents.SendToServerEnsured("WebPlayer:get_data", {});

		GameEvents.SendToServerEnsured("WebLocale:set_player_locale", {
			locale: $.Language(),
		});
	});
})();