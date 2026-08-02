--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


function GetMvpCategoryName(mvp_value) {
	return Object.keys(MVP_CATEGORY).find((key) => MVP_CATEGORY[key] == mvp_value) || "none";
}

const SEQUENCE_RUNNER = new RunSequentialActions();
let MVP_STATES_CACHED = {};

function CreateMVPBadges(container, badges_info, limit) {
	container.RemoveAndDeleteChildren();

	Object.entries(badges_info).forEach(([badge_id, value], _idx) => {
		if (limit && _idx >= limit) return;
		const badge = $.CreatePanel("Panel", container, "");
		badge.BLoadLayoutSnippet("MVP_Badge");
		const badge_name = GetMvpCategoryName(badge_id).toLowerCase();
		badge.FindChildTraverse("BadgeImage").SetImage(`file://{images}/custom_game/end_game/badges/${badge_name}.png`);
		badge.SetDialogVariableLocString("badge_name", `badge_${badge_name}`);

		value = FormatBigNumber(Math.round(value));

		if (POSTFIXES_FOR_CATEGORIES[badge_id]) value += $.Localize(POSTFIXES_FOR_CATEGORIES[badge_id]);

		badge.SetDialogVariable("badge_counter", value);
		badge.AddClass(badge_name);
	});
}

function CreateKilledHeroesList(team_id, root, stats, delay) {
	const killed_list_animation = new RunSkippableStaggeredActions(delay);
	for (const _player_id of Game.GetPlayerIDsOnTeam(team_id)) {
		const enemy_player_info = Game.GetPlayerInfo(_player_id);
		if (!enemy_player_info) continue;

		const e_hero = enemy_player_info.player_selected_hero;
		if (e_hero != -1 && e_hero != "" && typeof e_hero == "string") {
			const killed_entity_animation = new RunSkippableStaggeredActions(delay);

			const killed_entity = $.CreatePanel("Panel", root, "");
			killed_entity.BLoadLayoutSnippet("EG_KillEntity");
			killed_entity.FindChild("EG_KillEntity_Icon").SetImage(GetPortraitIcon(_player_id, e_hero));
			killed_entity.SetDialogVariableInt("kill_count", 0);
			killed_entity_animation.add(new AddClassAction(killed_entity, "Show"));

			if (stats && stats.killed_heroes[team_id] && stats.killed_heroes[team_id][e_hero]) {
				killed_entity_animation.add(new AddClassAction(killed_entity, "BHasKills"));
				killed_entity.SetDialogVariableInt("kill_count", stats.killed_heroes[team_id][e_hero]);
			}

			killed_list_animation.add(killed_entity_animation);
		}
	}
	return killed_list_animation;
}

function FillPlayerStats(root, player_id, stats) {
	root.player_id = player_id;
	player_id = Math.abs(player_id);
	const set_number_value_stat = function (name, value) {
		root[name] = value;
		root.SetDialogVariable(name, FormatBigNumber(Math.ceil(value || 0)));
	};
	set_number_value_stat("kills", Math.max(0, Players.GetKills(player_id)));
	set_number_value_stat("deaths", Math.max(0, Players.GetDeaths(player_id)));
	set_number_value_stat("assists", Math.max(0, Players.GetAssists(player_id)));
	set_number_value_stat("creeps_killed", Math.max(0, Players.GetLastHits(player_id)));
	set_number_value_stat("creeps_denied", Math.max(0, Players.GetDenies(player_id)));

	if (!stats) return;

	set_number_value_stat("gpm", stats.gpm);
	set_number_value_stat("networth", stats.networth);
	set_number_value_stat("hero_damage", stats.hero_damage);
	set_number_value_stat("damage_taken", stats.damage_taken);
	set_number_value_stat("total_healing", stats.total_healing);
	set_number_value_stat("building_damage", stats.building_damage);
	set_number_value_stat("total_stuns", Math.max(0, stats.total_stuns));
	set_number_value_stat("xpm", stats.xpm);
	set_number_value_stat("observers", stats.wards.npc_dota_observer_wards);
	set_number_value_stat("sentries", stats.wards.npc_dota_sentry_wards);
	set_number_value_stat("current_rating", stats.current_rating);
	set_number_value_stat("mmr_change", Math.abs(stats.rating_change));

	root.SetDialogVariable("rating_operator", stats.rating_change > -1 ? "+" : "-");
	if (stats.rating_change != 0) root.AddClass(stats.rating_change > 0 ? "MmrInc" : "MmrDec");
}

function _SortByParam(a, b, param, b_reverse, default_param) {
	let result = (a[param] || 0) - (b[param] || 0);
	if (result == 0) result = a[default_param] - b[default_param];
	return b_reverse ? -result : result;
}

function SortTeams(param, b_sort_dec) {
	const sort = (root) => {
		for (const player of root.Children().sort((a, b) => _SortByParam(a, b, param, b_sort_dec, "place"))) {
			root.MoveChildBefore(player, root.GetChild(0));
		}
	};
	sort(HUD.EG_PHASE_4_BASIC_TEAMS_CONTAINER);
	sort(HUD.EG_PHASE_4_FULL_ROWS_CONTAINER);
}
function ClearSortHeaders(exception) {
	HUD.EG_PHASE_4_HEADERS_ROOT.Children().forEach((header) => {
		if (exception && exception == header) return;
		header.SwitchClass("sort_type", "NoneSort");
	});
}
function SortPlayers(param) {
	const column_header = $(`#Col_${param}`);
	let b_sort_dec = false;

	if (column_header) {
		ClearSortHeaders(column_header);
		if (column_header.BHasClass("SortInc")) {
			column_header.SwitchClass("sort_type", "SortDec");
		} else if (column_header.BHasClass("SortDec")) {
			param = "player_id";
			column_header.SwitchClass("sort_type", "NoneSort");
		} else {
			column_header.SwitchClass("sort_type", "SortInc");
		}

		b_sort_dec = column_header.BHasClass("SortDec");
	}
	if (param == "player_id") b_sort_dec = true;

	if (MAP_NAME == "ot3_necropolis_ffa" && param != "player_id") SortTeams(param, b_sort_dec);
	else {
		const sort = (root, players_container_name) => {
			root.Children().forEach((team_root) => {
				if (players_container_name) team_root = team_root.FindChildTraverse(players_container_name);
				for (const player of team_root
					.Children()
					.sort((a, b) => _SortByParam(a, b, param, b_sort_dec, "player_id"))) {
					team_root.MoveChildBefore(player, team_root.GetChild(0));
				}
			});
		};
		sort(HUD.EG_PHASE_4_BASIC_TEAMS_CONTAINER, "EG_BTI_PlayersContainer");
		sort(HUD.EG_PHASE_4_FULL_ROWS_CONTAINER);
	}
}

function _EndScreenPhase1() {
	const animation_phase_1 = new RunSkippableStaggeredActions(0);
	HUD.EG_PHASE_1.RemoveClass("EG_Phase1_ShowTeamScores");

	animation_phase_1.actions = [
		new PlaySoundEffectAction("end_game.game_over"),
		new SkippableWaitAction(1),
		new SwitchClassAction(HUD.CONTEXT, "eg_phase", "EG_StartPhase_1"),
		new SkippableWaitAction(0.5),
		new AddClassAction(HUD.EG_PHASE_1, "EG_Phase1_ShowTeamScores"),
	];

	const winner_team = Game.GetGameWinner();
	const winner_color = GameUI.GetTeamColor(winner_team);

	HUD.EG_PHASE_1.SetDialogVariable("winner_team_name", $.Localize(Game.GetTeamDetails(winner_team).team_name));
	HUD.EG_PHASE_1.SetDialogVariable("winner_team_color", winner_color);
	HUD.EG_PHASE_1.SetDialogVariableInt("team_score_radiant", Game.GetTeamScore(DOTATeam_t.DOTA_TEAM_GOODGUYS));
	HUD.EG_PHASE_1.SetDialogVariableInt("team_score_dire", Game.GetTeamScore(DOTATeam_t.DOTA_TEAM_BADGUYS));

	animation_phase_1.add(new StopSkippingAheadAction());

	HUD.CONTEXT.SwitchClass("team_winner", `WinnerTeam_${winner_team}`);
	SEQUENCE_RUNNER.add(animation_phase_1);
}

function UpdateHeroEffect(player_id, root) {
	const player_info = Game.GetPlayerInfo(player_id);
	if (!player_info) return;
	const hero_ent_idx = player_info.player_selected_hero_entity_index;

	/****** Aghanim's Scepter ******/
	if (
		GetModifierStackCount(hero_ent_idx, "modifier_item_ultimate_scepter") != undefined ||
		GetModifierStackCount(hero_ent_idx, "modifier_item_ultimate_scepter_consumed") != undefined ||
		GetModifierStackCount(hero_ent_idx, "modifier_item_ultimate_scepter_consumed_alchemist") != undefined
	) {
		const agh_scepter = root.FindChildTraverse("EG_Status_AghScepter");
		agh_scepter.SetPanelEvent("onmouseover", () => {
			$.DispatchEvent(
				"DOTAShowAbilityTooltipForHero",
				agh_scepter,
				"item_ultimate_scepter",
				player_info.player_selected_hero_id,
				true,
			);
		});

		agh_scepter.SetImage("s2r://panorama/images/hud/reborn/aghsstatus_scepter_on_psd.vtex");
	}

	/****** Aghanim's Shard ******/
	if (GetModifierStackCount(hero_ent_idx, "modifier_item_aghanims_shard") != undefined) {
		const agh_shard = root.FindChildTraverse("EG_Status_AghShard");
		agh_shard.SetPanelEvent("onmouseover", () => {
			$.DispatchEvent(
				"DOTAShowAbilityTooltipForHero",
				agh_shard,
				"item_aghanims_shard",
				player_info.player_selected_hero_id,
				true,
			);
		});
		agh_shard.SetImage("s2r://panorama/images/hud/reborn/aghsstatus_shard_on_psd.vtex");
	}

	/****** Moonshard ******/
	const moonshard_panel = root.FindChildTraverse("EG_Status_Moonshard");
	const b_hero_has_moonshard = GetModifierStackCount(hero_ent_idx, "modifier_item_moon_shard_consumed") != undefined;

	moonshard_panel.SetHasClass("BActive", b_hero_has_moonshard);
	moonshard_panel.SetPanelEvent("onmouseover", function () {
		if (b_hero_has_moonshard) $.DispatchEvent("DOTAShowAbilityTooltip", moonshard_panel, "item_moon_shard");
		else
			$.DispatchEvent(
				"DOTAShowTitleTextTooltip",
				moonshard_panel,
				`#EG_Moonshard_Title`,
				`#EG_Moonshard_Description`,
			);
	});

	moonshard_panel.SetPanelEvent("onmouseout", function () {
		if (b_hero_has_moonshard) $.DispatchEvent("DOTAHideAbilityTooltip", moonshard_panel);
		else $.DispatchEvent("DOTAHideTitleTextTooltip", moonshard_panel);
	});
}

function _EndScreenPhase2(data) {
	HUD.EG_PHASE_2.RemoveClass("EG_ShowLocalHero");
	HUD.EG_PHASE_2.RemoveClass("EG_ShowLocalStats");
	HUD.EG_PHASE_2.RemoveClass("EG_ShowLocalKills");
	HUD.CONTEXT.RemoveClass("ShowFooter");
	HUD.CONTEXT.RemoveClass("ShowFootExpRoot");
	HUD.CONTEXT.RemoveClass("BExpEarned");
	HUD.CONTEXT.RemoveClass("BExpLimitReached");
	HUD.CONTEXT.RemoveClass("ShowExpLevelUp");

	HUD.EG_PHASE_2_CHALLENGE.RemoveClass("ShowChallengeInit");
	HUD.EG_PHASE_2_CHALLENGE.RemoveClass("ShowChallengeStateBG");
	HUD.EG_PHASE_2_CHALLENGE.RemoveClass("ShowChallengeStateText");
	HUD.EG_PHASE_2_CHALLENGE.RemoveClass("ShowChallengeEnds");
	HUD.EG_PHASE_2_CHALLENGE_REWARDS.RemoveAndDeleteChildren();

	HUD.EG_PHASE_2_EXP_REWARDS_CONTAINER.RemoveAndDeleteChildren();

	const animation_phase_2 = new RunSkippableStaggeredActions(0);
	animation_phase_2.actions = [
		new SkippableWaitAction(2),

		new SwitchClassAction(HUD.CONTEXT, "eg_phase", "EG_StartPhase_2"),
		new SkippableWaitAction(0.7),

		new AddClassAction(HUD.EG_PHASE_2, "EG_ShowLocalHero"),
		new AddClassAction(HUD.EG_PHASE_2, "EG_ShowLocalStats"),
		new AddClassAction(HUD.EG_PHASE_2, "EG_ShowLocalKills"),

		new PlaySoundEffectAction("end_game.local_player"),

		new SkippableWaitAction(0.3),

		new AddClassAction(HUD.CONTEXT, "ShowFooter"),
	];

	const local_player_parallel_animations = new RunParallelActions();

	const local_player_info = Game.GetPlayerInfo(LOCAL_PLAYER_ID);

	if (data.players_stats[LOCAL_PLAYER_ID] && data.players_stats[LOCAL_PLAYER_ID].player_mvp_categories)
		CreateMVPBadges(HUD.EG_PHASE_2_LOCAL_BADGES, data.players_stats[LOCAL_PLAYER_ID].player_mvp_categories);

	/** Local MVP badges animation START**/

	const local_mvp_badges_animation = new RunSkippableStaggeredActions(0.3);
	for (const badge of HUD.EG_PHASE_2_LOCAL_BADGES.Children()) {
		const badge_animation = new RunParallelActions();
		badge_animation.actions = [new PlaySoundEffectAction("ui.trophy_new"), new AddClassAction(badge, "Show")];
		local_mvp_badges_animation.add(badge_animation);
	}
	local_player_parallel_animations.add(local_mvp_badges_animation);

	/** Local MVP badges animation END**/
	HUD.EG_PHASE_2_LOCAL_HERO_MODEL_CONTAINER.RemoveAndDeleteChildren();
	const hero_model = $.CreatePanel(`DOTAScenePanel`, HUD.EG_PHASE_2_LOCAL_HERO_MODEL_CONTAINER, ``, {
		unit: local_player_info.player_selected_hero,
		particleonly: `false`,
		hittest: `true`,
		yawmin: `-180`,
		yawmax: `180`,
		rotateonmousemove: `true`,
		rotateonhover: `true`,
	});

	if (local_player_info.player_selected_hero != "npc_dota_hero_warlock")
		hero_model.SetScenePanelToLocalHero(local_player_info.player_selected_hero_id);

	$.CreatePanel(`Panel`, hero_model, ``, {
		class: `Hero_3DModel_Overlay`,
	});

	HUD.EG_PHASE_2.SetDialogVariableInt("local_hero_level", local_player_info.player_level);
	HUD.EG_PHASE_2.SetDialogVariableLocString("local_hero_name", local_player_info.player_selected_hero);
	HUD.EG_PHASE_2_LOCAL_PLAYER_NAME.steamid = local_player_info.player_steamid;

	const end_game_local_stats = data.players_stats[LOCAL_PLAYER_ID];
	FillPlayerStats(HUD.EG_PHASE_2, LOCAL_PLAYER_ID, end_game_local_stats);
	UpdateHeroEffect(LOCAL_PLAYER_ID, HUD.EG_PHASE_2);

	/** Local stats animation START**/

	const local_stats_slide_animation = new RunSkippableStaggeredActions(0.07);
	for (const stat of HUD.EG_PHASE_2_STATS_CONTAINER.Children())
		if (stat.BHasClass("EG_LocalStats_Container"))
			local_stats_slide_animation.add(new AddClassAction(stat, "Show"));
	local_player_parallel_animations.add(local_stats_slide_animation);

	/** Local stats animation END**/

	const local_kills_animation = new RunParallelActions();

	HUD.EG_PHASE_2_LOCAL_TEAM_KILLS_CONTAINER.RemoveAndDeleteChildren();
	for (const team_id of Game.GetAllTeamIDs()) {
		if (team_id == Players.GetTeam(LOCAL_PLAYER_ID)) continue;

		const killed_team_root = $.CreatePanel("Panel", HUD.EG_PHASE_2_LOCAL_TEAM_KILLS_CONTAINER, "");
		killed_team_root.BLoadLayoutSnippet("EG_Local_KilledTeam");
		killed_team_root.AddClass(`Team_${team_id}`);

		const killed_heroes_root = killed_team_root.FindChildTraverse("EG_Local_KilledTeam_List");

		local_kills_animation.add(CreateKilledHeroesList(team_id, killed_heroes_root, end_game_local_stats, 0.06));
	}
	local_player_parallel_animations.add(local_kills_animation);

	/** Hero Challenges START**/

	const challenge_animation_pull = new RunSequentialActions();
	if (data.active_challenge && data.active_challenge.id && !Game.IsDemoMode()) {
		const challenge = data.active_challenge;
		const is_completed = challenge.completed;

		const challenge_value_animation = new SkippableLerpAction(1);
		const challenge_target_value = is_completed ? challenge.target : challenge.progress;
		const challenge_locilize_token = `hero_challenges_${GetChallengeTypeName(challenge.challenge_type)}`;

		const set_challenge_progress = (_value) => {
			HUD.EG_PHASE_2_CHALLENGE.SetDialogVariable(
				"value",
				`<span class='${is_completed ? "ChallengeValue" : "ChallengeProgress"}'>${_value}</span> / ${
					challenge.target
				}`,
			);
			HUD.EG_PHASE_2_CHALLENGE.SetDialogVariable(
				"challenge_desc",
				$.Localize(challenge_locilize_token, HUD.EG_PHASE_2_CHALLENGE),
			);
		};

		challenge_value_animation.apply_progress = (progress) => {
			set_challenge_progress(Math.floor(Lerp(progress, 0, challenge_target_value)));
		};
		set_challenge_progress(0);

		const challenge_rewards_animation_pull = new RunSkippableStaggeredActions(0.3);
		const add_reward_to_challenge = (name, count) => {
			const reward = CreateReward(HUD.EG_PHASE_2_CHALLENGE_REWARDS, name, count);
			challenge_rewards_animation_pull.add(new AddClassAction(reward, "Show"));
		};

		if (challenge.rewards && is_completed) {
			if (challenge.rewards.currency) add_reward_to_challenge("currency", challenge.rewards.currency);
			if (challenge.rewards.items)
				for (const [item_name, item_count] of Object.entries(challenge.rewards.items))
					add_reward_to_challenge(item_name, item_count);
		}
		const state_txt = is_completed ? "completed" : "failed";

		HUD.EG_PHASE_2_CHALLENGE.SetDialogVariableLocString(
			"active_challenge_state",
			`end_game_hero_challenge_${state_txt}`,
		);
		HUD.EG_PHASE_2_CHALLENGE.SetHasClass("BChallengeCompleted", is_completed);

		challenge_animation_pull.actions = [
			new AddClassAction(HUD.EG_PHASE_2_CHALLENGE, "ShowChallengeInit"),
			new SkippableWaitAction(0.5),
			challenge_value_animation,
			challenge_rewards_animation_pull,
			new SkippableWaitAction(0.5),
			new AddClassAction(HUD.EG_PHASE_2_CHALLENGE, "ShowChallengeStateBG"),
			new SkippableWaitAction(0.4),
			new PlaySoundEffectAction(`end_game.challenge_${state_txt}`),
			new WaitForClassAction(HUD.EG_PHASE_2_CHALLENGE_PFX_COMPLTED, "SceneLoaded"),
			new FireEntityInputAction(HUD.EG_PHASE_2_CHALLENGE_PFX_COMPLTED, "challenge_completed_pfx", "Stop", ""),
			new FireEntityInputAction(HUD.EG_PHASE_2_CHALLENGE_PFX_COMPLTED, "challenge_failed_pfx", "Stop", ""),
			new RunFunctionAction(() => {
				$.DispatchEvent(
					"DOTAGlobalSceneSetCameraEntity",
					"EG_C_Particle_Completed",
					`challenge_${state_txt}`,
					0,
				);
			}),
			new FireEntityInputAction(HUD.EG_PHASE_2_CHALLENGE_PFX_COMPLTED, `challenge_${state_txt}_pfx`, "Start", ""),
			new AddClassAction(HUD.EG_PHASE_2_CHALLENGE, "ShowChallengeStateText"),
			new SkippableWaitAction(0.3),
			new AddClassAction(HUD.EG_PHASE_2_CHALLENGE, "ShowChallengeEnds"),
		];
	}

	/** Hero Challenges END**/

	/** Battle Pass Experience START**/
	const battle_pass_animation = new RunSequentialActions();
	if (end_game_local_stats && end_game_local_stats.battle_pass && end_game_local_stats.battle_pass.bp_exp_changes) {
		battle_pass_animation.actions = [
			new AddClassAction(HUD.CONTEXT, "ShowFootExpRoot"),
			new SkippableWaitAction(1),
		];
		const bp_stats = end_game_local_stats.battle_pass;
		const current_exp = bp_stats.bp_exp_changes.old.min;

		const earned_exp = bp_stats.bp_exp_changes.earned;
		const current_limit = bp_stats.bp_exp_changes.limits.current;
		HUD.CONTEXT.SetDialogVariableInt("bp_level", bp_stats.bp_level_changes.old);
		HUD.CONTEXT.SetDialogVariableInt("current_limit", current_limit - earned_exp);
		HUD.CONTEXT.SetDialogVariableInt("max_limit", bp_stats.bp_exp_changes.limits.max);
		HUD.CONTEXT.SetDialogVariableInt("earned", 0);
		HUD.CONTEXT.SetDialogVariableInt("current_exp", current_exp);
		HUD.CONTEXT.SetDialogVariableInt("required_exp", bp_stats.bp_exp_changes.old.max);

		HUD.EG_PHASE_2_EXP_BAR.value = current_exp;

		const exp_animation = new RunSequentialActions();
		const parallel_exp_animation = new RunParallelActions();

		if (earned_exp > 0) {
			HUD.CONTEXT.AddClass("BExpEarned");
			AnimateExperienceBar(
				current_exp,
				bp_stats.bp_level_changes.old,
				earned_exp,
				exp_animation,
				bp_stats.rewards,
			);
			parallel_exp_animation.actions = [
				exp_animation,
				new SkippableAnimateDialogVariableIntAction(
					HUD.CONTEXT,
					"current_limit",
					current_limit - earned_exp,
					current_limit,
					1,
				),
			];

			const limit_animation = new RunSequentialActions();
			limit_animation.actions = [
				new SkippableAnimateDialogVariableIntAction(HUD.CONTEXT, "earned", 0, earned_exp, 1),
			];
			if (current_limit >= bp_stats.bp_exp_changes.limits.max)
				limit_animation.add(new AddClassAction(HUD.CONTEXT, "BExpLimitReached"));

			parallel_exp_animation.add(limit_animation);
		} else HUD.CONTEXT.AddClass("BExpLimitReached");

		battle_pass_animation.add(parallel_exp_animation);
	}
	/** Battle Pass Experience END**/

	animation_phase_2.add(local_player_parallel_animations);
	animation_phase_2.add(challenge_animation_pull);
	animation_phase_2.add(battle_pass_animation);
	animation_phase_2.add(new StopSkippingAheadAction());
	SEQUENCE_RUNNER.add(animation_phase_2);
}

function _GetRequiredExp(level) {
	return 10000;
}
function AnimateExperienceBar(current_exp, current_level, total_available, animation_pull, rewards = {}) {
	const required = _GetRequiredExp(current_exp);
	const needed_exp = required - current_exp;

	let new_exp_value = total_available < needed_exp ? current_exp + total_available : required;
	let bar_animation_duration = total_available < needed_exp ? 1.2 : 0.8;

	const parallel_runner = new RunParallelActions();
	parallel_runner.actions = [
		new SetDialogVariableIntAction(HUD.CONTEXT, "required_exp", required),
		new SkippableAnimateDialogVariableIntAction(
			HUD.CONTEXT,
			"current_exp",
			current_exp,
			new_exp_value,
			bar_animation_duration,
		),

		new SetProgressBarValueAction(HUD.EG_PHASE_2_EXP_BAR, current_exp),
		new SkippableAnimateProgressBarAction(
			HUD.EG_PHASE_2_EXP_BAR,
			current_exp,
			new_exp_value,
			bar_animation_duration,
		),
		new SkippablePlaySoundForDurationAction("XP.Count", bar_animation_duration),
	];

	if (total_available < needed_exp) {
		animation_pull.add(parallel_runner);
		return;
	}

	total_available -= needed_exp;
	current_level += 1;
	current_exp = 0;
	const levelup_sequence = new RunSequentialActions();

	levelup_sequence.add(
		parallel_runner,
		new SetDialogVariableIntAction(HUD.CONTEXT, "bp_level", current_level),
		new SetDialogVariableIntAction(HUD.CONTEXT, "required_exp", _GetRequiredExp(current_level)),

		new SetProgressBarValueAction(HUD.EG_PHASE_2_EXP_BAR, 0),
		new PlaySoundEffectAction("Loot_Drop_Stinger_Short"),
		new AddClassAction(HUD.CONTEXT, "ShowExpLevelUp"),
		new RunFunctionAction(() => {
			for (const [reward, count] of Object.entries(rewards))
				CreateReward(HUD.EG_PHASE_2_EXP_REWARDS_CONTAINER, reward, count, true);
		}),
	);

	animation_pull.add(levelup_sequence);
	AnimateExperienceBar(current_exp, current_level, total_available, animation_pull);
}

function CreateReward(rewards_container, reward_name, reward_amount, b_animation = false) {
	const reward = $.CreatePanel("Panel", rewards_container, "");
	reward.BLoadLayoutSnippet("MVP_Reward");
	reward.SetHasClass("BAnimation", b_animation);

	reward.SetDialogVariableInt("reward_amount", reward_amount);
	if (reward_name == "currency") reward.AddClass("Reward_currency");
	else {
		reward.FindChildTraverse("MVP_Reward_Icon").SetImage(GameUI.Inventory.GetItemImagePath(reward_name));
	}
	// reward.SwitchClass("rarity", GameUI.Inventory.GetItemRarityName(reward_name) || "COMMON");
	// reward.SwitchClass("slot", GameUI.Inventory.GetItemSlotName(reward_name) || "NONE");
	reward.SetDialogVariableLocString("reward_name", reward_name);

	reward.SetPanelEvent("onmouseover", () => {
		$.DispatchEvent("DOTAShowTextTooltip", reward, $.Localize(reward_name));
	});
	reward.SetPanelEvent("onmouseout", () => {
		$.DispatchEvent("DOTAHideTextTooltip");
	});
	return reward;
}

function _EndScreenPhase3(data) {
	const animation_phase_3 = new RunSkippableStaggeredActions(0);
	animation_phase_3.actions = [
		new SkippableWaitAction(1),
		new SwitchClassAction(HUD.CONTEXT, "eg_phase", "EG_StartPhase_3"),
	];

	HUD.EG_PHASE_3_MVP_HEROES.RemoveAndDeleteChildren();
	for (const [mvp_idx, mvp_data] of Object.entries(data.mvp)) {
		const player_info = Game.GetPlayerInfo(mvp_data.player_id);

		if (!player_info) continue;

		const mvp = $.CreatePanel("Panel", HUD.EG_PHASE_3_MVP_HEROES, "");
		mvp.BLoadLayoutSnippet("MVP_Hero");

		mvp.AddClass(`Place_${mvp_idx}`);
		mvp.AddClass(`MVP_Team_${Players.GetTeam(mvp_data.player_id)}`);
		MVP_STATES_CACHED[mvp_data.player_id] = mvp_idx;

		const hero_container = mvp.FindChildTraverse("MVP_Hero_Container");

		const ray_particle_name =
			mvp_idx == 1
				? "particles/world_environmental_fx/artifact_table_godray.vpcf"
				: "particles/vr/player_light_godray.vpcf";
		$.CreatePanel("DOTAParticleScenePanel", hero_container, "rays", {
			particleName: ray_particle_name,
			particleonly: "true",
			class: "MVP_Rays",
		});
		$.CreatePanel("DOTAScenePanel", hero_container, "", {
			unit: player_info.player_selected_hero,
			class: "MVP_Hero_Model",
			particleonly: `false`,
			drawbackground: "false",
			["activity-modifier"]:
				player_info.player_selected_hero == "npc_dota_hero_warlock" ? "none" : "PostGameIdle",
		});

		CreateMVPBadges(mvp.FindChildTraverse("MVP_Hero_Badges"), mvp_data.categories, 3);
		mvp.SetDialogVariableLocString("mvp_place", `mvp_place_${mvp_idx}`);
		mvp.FindChildTraverse("MVP_PlayerName").steamid = player_info.player_steamid;

		mvp.SetDialogVariableInt("kills", Players.GetKills(mvp_data.player_id));
		mvp.SetDialogVariableInt("deaths", Players.GetDeaths(mvp_data.player_id));
		mvp.SetDialogVariableInt("assists", Players.GetAssists(mvp_data.player_id));

		if (mvp_data.rewards) {
			const rewards_container = mvp.FindChildTraverse("MVP_Rewards");
			if (mvp_data.rewards.currency) CreateReward(rewards_container, "currency", mvp_data.rewards.currency);
			if (mvp_data.rewards.items)
				for (const [item_name, item_count] of Object.entries(mvp_data.rewards.items))
					CreateReward(rewards_container, item_name, item_count);
		}

		const mvp_entity_animation = new RunSkippableStaggeredActions(0.4);

		const rewards_animation = new RunParallelActions();
		rewards_animation.actions = [
			new PlaySoundEffectAction("end_game.mvp_rewards"),
			new AddClassAction(mvp, "ShowRewards"),
		];
		const root_animation = new RunParallelActions();
		root_animation.actions = [new PlaySoundEffectAction("end_game.mvp"), new AddClassAction(mvp, "ShowRoot")];

		mvp_entity_animation.add(root_animation);
		mvp_entity_animation.add(new AddClassAction(mvp, "ShowModel"));
		mvp_entity_animation.add(rewards_animation);
		mvp_entity_animation.add(new AddClassAction(mvp, "ShowBadges"));

		animation_phase_3.add(mvp_entity_animation);
	}

	animation_phase_3.add(new SkippableWaitAction(1));
	animation_phase_3.add(new StopSkippingAheadAction());
	SEQUENCE_RUNNER.add(animation_phase_3);
}

function _EndScreenPhase4(data) {
	const animation_phase_4 = new RunSkippableStaggeredActions(0);
	animation_phase_4.actions = [
		new PlaySoundEffectAction("Loot_Drop_Sfx_Minor"),

		new SwitchClassAction(HUD.CONTEXT, "eg_phase", "EG_StartPhase_4"),
		new SkippableWaitAction(0.1),
		new AddClassAction(HUD.EG_PHASE_4, "ShowMainTeamInfo"),
	];

	HUD.EG_PHASE_4_BASIC_TEAMS_CONTAINER.RemoveAndDeleteChildren();
	HUD.EG_PHASE_4_FULL_ROWS_CONTAINER.RemoveAndDeleteChildren();
	HUD.EG_PHASE_4_ERRORS_CONTAINER.RemoveAndDeleteChildren();

	GetTeamPlace = (team_id) => {
		return Object.keys(data.sorted_teams).find((key) => data.sorted_teams[key].team == team_id);
	};

	for (const team_id of Game.GetAllTeamIDs()) {
		const team_info = Game.GetTeamDetails(team_id);
		if (!team_info) continue;

		const players_in_team_ids = Game.GetPlayerIDsOnTeam(team_id);
		if (players_in_team_ids.length <= 0) continue;

		const team_root = $.CreatePanel("Panel", HUD.EG_PHASE_4_BASIC_TEAMS_CONTAINER, `BasicTeamRoot_${team_id}`);
		team_root.BLoadLayoutSnippet("EG_BasicTeamInfo");

		team_root.SetDialogVariableInt("team_score", data.teams_scores[team_id] || 0);

		const team_full_rows_container = $.CreatePanel(
			"Panel",
			HUD.EG_PHASE_4_FULL_ROWS_CONTAINER,
			`FullTeamStat_${team_id}`,
		);
		team_full_rows_container.BLoadLayoutSnippet("EG_TeamFullRowsContainer");

		const basic_players_container = team_root.FindChildTraverse("EG_BTI_PlayersContainer");

		team_root.place = GetTeamPlace(team_id);
		team_root.AddClass(`TeamPlace_${team_root.place}`);
		team_root.AddClass(`Team_${team_id}`);

		team_full_rows_container.place = GetTeamPlace(team_id);
		team_full_rows_container.AddClass(`TeamPlace_${team_root.place}`);

		for (const player_id of players_in_team_ids) {
			const player_info = Game.GetPlayerInfo(player_id);
			if (!player_info) continue;
			const hero_ent_idx = player_info.player_selected_hero_entity_index;

			/****** BASIC INFO ******/
			const basic_player = $.CreatePanel("Panel", basic_players_container, `BasicPlayerRoot_${player_id}`);
			basic_player.BLoadLayoutSnippet("EG_PlayerStats_Basic");

			const player_name = basic_player.FindChildTraverse("EG_PSB_Name").GetChild(0);
			HighlightByParty(player_id, player_name);

			basic_player
				.FindChildTraverse("EG_HeroIcon")
				.SetImage(GetPortraitImage(player_id, player_info.player_selected_hero));
			basic_player.FindChildTraverse("EG_PSB_Name").steamid = player_info.player_steamid;

			basic_player.SetDialogVariableInt("hero_level", player_info.player_level);
			basic_player.SetDialogVariableLocString("hero_name", player_info.player_selected_hero);

			const mvp_state = MVP_STATES_CACHED[player_id];
			if (mvp_state != undefined) {
				basic_player.AddClass(`MVP_State_${mvp_state}`);

				const mvp_icon = basic_player.FindChildTraverse("EG_PSB_MVP_Icon");
				mvp_icon.SetPanelEvent("onmouseover", () => {
					$.DispatchEvent(
						"DOTAShowTextTooltip",
						mvp_icon,
						$.Localize(`end_game_mvp_hint_${mvp_state == 1 ? "MVP" : "RunnerUp"}`),
					);
				});
			}

			/****** FULL ROW INFO ******/
			const row = $.CreatePanel("Panel", team_full_rows_container, `PlayerRow_${player_id}`);
			row.BLoadLayoutSnippet("EG_PlayerStats_FullRow");
			const player_stats = data.players_stats[player_id];

			if (player_stats) {
				/****** Basic numbers values (using for sort) ******/

				let _player_id_sort = player_id;
				if (team_id == DOTATeam_t.DOTA_TEAM_BADGUYS) _player_id_sort *= -1;

				FillPlayerStats(basic_player, _player_id_sort, player_stats);
				FillPlayerStats(row, _player_id_sort, player_stats);
				if (MAP_NAME == "ot3_necropolis_ffa") {
					FillPlayerStats(team_root, _player_id_sort, player_stats);
					FillPlayerStats(team_full_rows_container, _player_id_sort, player_stats);
				}

				/****** Fill perk ******/

				const perk_info = player_stats.perk_info;
				const override_desc = ["str_for_kill", "agi_for_kill", "int_for_kill", "delayed_damage"];

				if (perk_info.perk_name != "") {
					const perk_image = row.FindChildTraverse("EG_Perk");
					perk_image.SetImage(`file://{images}/custom_game/perks/icons/${perk_info.base_perk}_t0.png`);
					const is_family_perk = perk_info.perk_name == "family";

					perk_image.SetHasClass("GrantedByFamily", is_family_perk);

					perk_image.SetDialogVariableLocString("perk_name", GetPerkLocName(perk_info.base_perk, 2));
					perk_image.SetDialogVariableLocString(
						"perk_desc",
						override_desc.includes(perk_info.base_perk)
							? `${perk_info.base_perk}_override_Description`
							: `DOTA_Tooltip_${perk_info.base_perk}_Description`,
					);
					perk_image.SetDialogVariable(
						"granted_by_family",
						is_family_perk ? $.Localize("perk_granted_by_family") : "",
					);

					perk_image.SetPanelEvent("onmouseover", function () {
						$.DispatchEvent(
							"DOTAShowTitleTextTooltip",
							perk_image,
							`{s:perk_name}`,
							`{s:perk_desc}{s:granted_by_family}`,
						);
					});
				}

				/****** Created enemies hero list and fill killed enties ******/
				const row_killed_heroes = row.FindChildTraverse("EG_KilledHeroes");

				for (const target_for_kills_team_id of Game.GetAllTeamIDs()) {
					if (team_id == target_for_kills_team_id) continue;
					animation_phase_4.add(
						CreateKilledHeroesList(target_for_kills_team_id, row_killed_heroes, player_stats),
					);
				}
			}

			/****** Fill items ******/
			const items_container = row.FindChildTraverse("EG_Items");
			const backpack_items_container = row.FindChildTraverse("EG_BackpackItems");
			const items = Game.GetPlayerItems(player_id);

			if (items && items.inventory) {
				for (let idx = 0; idx <= 5; idx++) {
					if (!items.inventory[idx]) continue;
					if (!items_container.GetChild(idx)) continue;
					items_container.GetChild(idx).itemname = items.inventory[idx].item_name;
				}
				for (let idx = 6; idx <= 8; idx++) {
					const panel_id = idx - 6;
					if (!items.inventory[idx]) continue;
					if (!backpack_items_container.GetChild(panel_id)) continue;
					backpack_items_container.GetChild(panel_id).itemname = items.inventory[idx].item_name;
					backpack_items_container.GetChild(panel_id).AddClass("BHasItemOwned");
				}

				const neutralItemPanel = items_container.GetChild(6);
				if (neutralItemPanel) {
					const n_item = Entities.GetItemInSlot(hero_ent_idx, 16);
					if (n_item) items_container.GetChild(7).itemname = Abilities.GetAbilityName(n_item);
				}
			}

			/****** Update hero modifiers states based ******/
			UpdateHeroEffect(player_id, row);

			/****** FINISH CREATING ROW STATS ******/

			if (player_id == LOCAL_PLAYER_ID) {
				basic_player.AddClass("BLocalPlayer");
				row.AddClass("BLocalPlayer");
			}
		}
	}
	SortPlayers("player_id");
	SortTeams("place", true);

	animation_phase_4.add(new SkippableWaitAction(0.5));

	if (data.errors) {
		const errors = Object.values(data.errors);
		const b_has_errors = errors.length > 0;
		for (const error of errors) {
			$.CreatePanel("Label", HUD.EG_PHASE_4_ERRORS_CONTAINER, "", {
				text: `• ${$.Localize(error)}`,
				html: true,
			});
		}
		if (b_has_errors) {
			animation_phase_4.add(new AddClassAction(HUD.CONTEXT, "BShowServerErrors_Indicator"));
			animation_phase_4.add(new AddClassAction(HUD.CONTEXT, "BShowServerErrors"));
		}
	}

	// animation_phase_4.add(new AddClassAction(HUD.CONTEXT, "BShowFeedbackForm"));
	animation_phase_4.add(new AddClassAction(HUD.CONTEXT, "ShowTopButtons"));
	animation_phase_4.add(new StopSkippingAheadAction());

	SEQUENCE_RUNNER.add(animation_phase_4);
}

function _EndScreenPhasePromo(data) {
	const animation_phase_promo = new RunSkippableStaggeredActions(0);

	animation_phase_promo.actions = [
		new SwitchClassAction(HUD.CONTEXT, "eg_phase", "EG_StartPhase_Promo"),
		new SkippableWaitAction(1),
		new AddClassAction(HUD.CONTEXT, "BFirstPromoView"),
		new SkippableWaitAction(10),
		new StopSkippingAheadAction(),
		new RemoveClassAction(HUD.CONTEXT, "BFirstPromoView"),
	];

	SEQUENCE_RUNNER.add(animation_phase_promo);
}
function UpdateMatchInfo() {
	const match_id = CustomNetTables.GetTableValue("game_state", "match_id")?.match_id;

	HUD.CONTEXT.SetDialogVariable("match_id", match_id || -1);

	const match_duration = Game.GetDOTATime(false, false);
	HUD.CONTEXT.SetDialogVariable("match_duration", FormatSeconds(match_duration, match_duration >= 3600));
}
function StartEndScreen() {
	HUD.CONTEXT.SetFocus();
	UpdateMatchInfo();
	let data = {
		sorted_teams: {},
		players_stats: {},
		errors: {},
		mvp: {},
	};
	const sort_team = (team, place) => {
		data.sorted_teams[place] = {
			team: team,
			score: Game.GetTeamScore(team),
		};
	};

	let mask = [0, 1];
	const radiant_score = Game.GetTeamScore(DOTATeam_t.DOTA_TEAM_GOODGUYS);
	const dire_score = Game.GetTeamScore(DOTATeam_t.DOTA_TEAM_BADGUYS);

	if (dire_score > radiant_score) mask = [1, 0];
	sort_team(DOTATeam_t.DOTA_TEAM_GOODGUYS, mask[0]);
	sort_team(DOTATeam_t.DOTA_TEAM_BADGUYS, mask[1]);

	for (const team_id of Game.GetAllTeamIDs())
		for (const _player_id of Game.GetPlayerIDsOnTeam(team_id))
			data.players_stats[_player_id] = CustomNetTables.GetTableValue("custom_stats", _player_id.toString());

	const mvp_nettable = CustomNetTables.GetTableValue("custom_stats", "mvp");
	if (mvp_nettable) data.mvp = mvp_nettable;

	const errors_nettable = CustomNetTables.GetTableValue("custom_stats", "errors");
	if (errors_nettable) data.errors = errors_nettable;

	SetUIForEndGameVisible(false);
	SEQUENCE_RUNNER.finish();
	SEQUENCE_RUNNER.actions = [];
	HUD.CONTEXT.hittest = true;
	HUD.CONTEXT.SwitchClass("map_name", MAP_NAME);
	ClearSortHeaders();

	$.RegisterForUnhandledEvent("Cancelled", StartSkippingAhead);

	if (data.sorted_teams) {
		data.teams_scores = {};
		for (const team_data of Object.values(data.sorted_teams)) data.teams_scores[team_data.team] = team_data.score;
	}

	_EndScreenPhase1();
	_EndScreenPhase2(data);
	_EndScreenPhase3(data);
	if (IS_PROMO_ENABLED) _EndScreenPhasePromo(data);
	_EndScreenPhase4(data);

	RunSingleAction(SEQUENCE_RUNNER);
}
function ShowPhase(phase_number) {
	$.DispatchEvent("PlaySoundEffect", "Loot_Drop_Sfx_Minor");
	HUD.CONTEXT.SwitchClass("eg_phase", `EG_StartPhase_${phase_number}`);
}

function SetUIForEndGameVisible(bool) {
	HUD.CONTEXT.SetHasClass("Show", !bool);

	const set_dota_ui_visible_state = (name) => {
		const panel = FindDotaHudElement(name);
		if (panel) panel.visible = bool;
	};
	set_dota_ui_visible_state("stackable_side_panels");
	set_dota_ui_visible_state("combat_events");
	set_dota_ui_visible_state("SpectatorToastManager");
	set_dota_ui_visible_state("KillStreak");

	GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_SHOP, bool);
	GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_ACTION_PANEL, bool);
	GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_ACTION_MINIMAP, bool);
	GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_TOP_MENU_BUTTONS, bool);
}
function Custom_HideServerErros() {
	HUD.CONTEXT.RemoveClass("BShowServerErrors");
}
function Custom_HideFeedbackForm() {
	HUD.CONTEXT.RemoveClass("BShowFeedbackForm");
}
const chat_style = {
	main_block: {
		align: "left top",
		position: "0px 0px 0px",
		width: "100%",
		height: "fit-children",
	},
	by_class: {
		// ChatLeftPanel: { width: "0px" },
	},
	freeze_by_class: {
		ChatLine: { opacity: "1" },
	},
	by_id: {
		ChatHeaderPanel: { visibility: "collapse" },
		ChatHelpPanel: { visibility: "collapse" },
		ChatTabHelpButton: { visibility: "collapse" },
		ChatControls: { opacity: "1", borderRadius: "0px" },
		ChatLinesContainer: { height: "120px" },
	},
};

let chat_in_custom_root = false;
function MoveChat(b_to_custom_root) {
	chat_in_custom_root = b_to_custom_root;
	const chat = FindDotaHudElement("HudChat") || HUD.CUSTOM_CHAT_CONTAINER.FindChildTraverse("HudChat");
	if (chat == undefined) return;

	const new_parent = b_to_custom_root ? HUD.CUSTOM_CHAT_CONTAINER : FindDotaHudElement("HUDElements");
	chat.SetParent(new_parent);

	if (!b_to_custom_root) new_parent.MoveChildAfter(chat, new_parent.FindChildTraverse("CursorCooldown"));

	const set_style_data = (panel, style_data) => {
		for (const [prop, value] of Object.entries(style_data)) {
			if (chat_in_custom_root) panel.style[prop] = value;
			else panel.ClearPropertyFromCode(prop);
		}
	};
	set_style_data(chat, chat_style.main_block);

	for (const [class_name, style_data] of Object.entries(chat_style.by_class)) {
		const panel = chat.FindChildrenWithClassTraverse(class_name)[0];
		if (panel) set_style_data(panel, style_data);
	}
	for (const [id, style_data] of Object.entries(chat_style.by_id)) {
		const panel = chat.FindChildTraverse(id);
		if (panel) set_style_data(panel, style_data);
	}
	chat.FindChildTraverse("ChatInput").hittest = b_to_custom_root;

	const show_chat_lines = () => {
		for (const [class_name, style_data] of Object.entries(chat_style.freeze_by_class)) {
			const panels = chat.FindChildrenWithClassTraverse(class_name);
			if (panels) for (const panel of panels) set_style_data(panel, style_data);
		}

		if (!chat_in_custom_root) return;
		$.Schedule(0, show_chat_lines);
	};
	show_chat_lines();
}
(function () {
	$.DispatchEvent("DropInputFocus");
	HUD.CONTEXT.SetAcceptsFocus(true);
	HUD.CONTEXT.SetFocus();

	GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_ENDGAME, false);
	HUD.CONTEXT.SwitchClass("eg_phase", "none");
	HUD.CONTEXT.RemoveClass("ShowTopButtons");
	HUD.CONTEXT.RemoveClass("BShowServerErrors_Indicator");
	HUD.CONTEXT.SetHasClass("BPromoEnabled", IS_PROMO_ENABLED);
	Custom_HideServerErros();
	Custom_HideFeedbackForm();

	StartEndScreen();
	MoveChat(true);
})();