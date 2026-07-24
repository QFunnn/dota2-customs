--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const HUD = {
	CONTEXT: $.GetContextPanel(),
	TEMP_CONTAINER: $("#TempChallengesContainer"),
	CC_CONTAINER: $("#CC_L_Container"),
};
let dota_pre_game_hud;
let challenges_definition;

function CreateChallenges(data) {
	HUD.TEMP_CONTAINER.RemoveAndDeleteChildren();
	HUD.CC_CONTAINER.RemoveAndDeleteChildren();

	if (Game.IsDemoMode()) return;

	let temp_challenges = {};
	for (const challenge of Object.values(data.challenges))
		temp_challenges[challenge.hero_name.replace("npc_dota_hero_", "")] = challenge;
	data.challenges = temp_challenges;

	challenges_definition = data.challenges;

	dota_pre_game_hud = FindDotaHudElement("PreGame");
	if (!dota_pre_game_hud)
		return void $.Schedule(0.5, () => {
			CreateChallenges(data);
		});

	const categories = dota_pre_game_hud.FindChildTraverse("GridCategories");
	if (!categories)
		return void $.Schedule(0.5, () => {
			CreateChallenges(data);
		});

	const hero_simple_desc = FindDotaHudElement("HeroSimpleDescription");
	hero_simple_desc.GetChild(0).visible = false;
	hero_simple_desc.GetChild(1).visible = false;

	for (const stat_root of categories.Children()) {
		const heroes = stat_root.FindChildTraverse("HeroList");
		for (const hero of heroes.Children()) {
			const hero_image = hero.FindChildTraverse("HeroImage");
			const hero_name = hero_image.heroname;
			hero_image.style.paddingTop = "4px";

			const ex_challenge = hero.FindChildTraverse(`CustomChallege_${hero_name}`);
			if (ex_challenge) ex_challenge.DeleteAsync(0);

			if (!data.challenges[hero_name] || data.challenges[hero_name].completed) continue;

			const challenge_overlay = $.CreatePanel("Panel", HUD.TEMP_CONTAINER, `CustomChallege_${hero_name}`);
			challenge_overlay.BLoadLayoutSnippet("Challenge_Border");
			challenge_overlay.SetParent(hero);
		}
	}

	const challenges_list = Object.entries(data.challenges);

	if (challenges_list[0]) {
		challenges_list[2] = challenges_list[2] || ["", { locked: 1 }];
		challenges_list[3] = challenges_list[3] || ["", { locked: 2 }];

		for (const [hero_name, challenge_def] of challenges_list) {
			const challenge = $.CreatePanel("Panel", HUD.CC_CONTAINER, "");
			challenge.BLoadLayoutSnippet("CC_List_Entity");
			if (challenge_def.locked) {
				challenge.AddClass("BLocked");
				challenge.SetDialogVariableLocString(
					"challenge_desc",
					`hero_challenge_locked_supp_${challenge_def.locked}`,
				);
			} else {
				challenge
					.FindChildTraverse("CC_L_E_HeroIcon")
					.SetImage(GetPortraitIcon(LOCAL_PLAYER_ID, challenge_def.hero_name));

				const rewards_container = challenge.FindChildTraverse("CC_L_E_RewardsContainer");
				const add_reward = (reward_name, reward_amount) => {
					const reward = $.CreatePanel("Panel", rewards_container, "");
					reward.BLoadLayoutSnippet("CC_Reward");

					reward.SetDialogVariableInt("reward_amount", reward_amount);
					if (reward_name == "currency") reward.AddClass("Reward_currency");
					else {
						reward
							.FindChildTraverse("CC_Reward_Icon")
							.SetImage(GameUI.Inventory.GetItemImagePath(reward_name));
					}
					reward.SwitchClass("rarity", GameUI.Inventory.GetItemRarityName(reward_name) || "COMMON");
					reward.SwitchClass("slot", GameUI.Inventory.GetItemSlotName(reward_name) || "NONE");

					reward.SetPanelEvent("onmouseover", () => {
						$.DispatchEvent("DOTAShowTextTooltip", reward, $.Localize(reward_name));
					});
					reward.SetPanelEvent("onmouseout", () => {
						$.DispatchEvent("DOTAHideTextTooltip");
					});
				};

				if (challenge_def.rewards.currency) add_reward("currency", challenge_def.rewards.currency);
				if (challenge_def.rewards.items)
					for (const [item_name, item_count] of Object.entries(challenge_def.rewards.items))
						add_reward(item_name, item_count);

				FillChallengeInfo(hero_name, challenge);
			}
		}
	}
	HeroDetailsCheck(data);
}

const block_ban = [
	// "muerta",
	// "kez",
	// "largo",
];
function HeroDetailsCheck(data) {
	const hero_inspect = FindDotaHudElement("HeroInspect");
	if (!hero_inspect)
		return void $.Schedule(0.5, () => {
			HeroDetailsCheck(data);
		});

	const challenge_panel = CreateChallenge(hero_inspect);

	const hero_movie = FindDotaHudElement("HeroMovie");
	const create_challenge = () => {
		if (!hero_movie) return;

		const hero_name = hero_movie.heroname;
		const ban_button = hero_inspect.GetParent().GetParent().FindChildTraverse("BanButton");
		if (dota_pre_game_hud.BHasClass("IsInBanPhase") && ban_button) {
			ban_button.visible = block_ban.indexOf(hero_name) < 0;
			return;
		}
		ban_button.visible = false;

		const challenge = data.challenges[hero_name];

		if (!challenge_panel.IsValid()) return;

		challenge_panel.SetHasClass("Show", !!challenge && !challenge.completed);
		FillChallengeInfo(hero_name, challenge_panel);
	};

	$.RegisterEventHandler("PanelStyleChanged", FindDotaHudElement("HeroInspect"), create_challenge);
}

function RestyleSkipStrategyButton() {
	const skin_button = FindDotaHudElement("SkipIntoGame");
	if (!skin_button) return void $.Schedule(0.2, RestyleSkipStrategyButton);
	skin_button.GetChild(1).visible = false;
	skin_button.style.margin = "0 0 257px 74px";

	skin_button.GetChild(0).style.height = "78px";
	skin_button.GetChild(0).style.width = "74px";
}

function CreateChallenge(root) {
	const ex_challenge = root.FindChildTraverse("CustomChallengeDesc");
	if (ex_challenge) ex_challenge.DeleteAsync(0);

	const challenge = $.CreatePanel("Panel", HUD.TEMP_CONTAINER, "CustomChallengeDesc");
	challenge.BLoadLayoutSnippet("CustomChallengeDesc");
	challenge.SetParent(root);

	return challenge;
}

function FillChallengeInfo(hero_name, root) {
	const challenge = challenges_definition[hero_name];
	if (!challenge) return;

	root.SetDialogVariable("value", FormatBigNumber(challenge.target));
	root.SetDialogVariable(
		"challenge_desc",
		$.Localize(`hero_challenges_${GetChallengeTypeName(challenge.challenge_type)}`, root),
	);
	root.SwitchClass("custom_hero_challenge", `CustomChallengeDiff_${challenge.difficulty}`);
	root.SetHasClass("BChallengeCompleted", challenge.completed);
}

function AddChallengeToStrategyScreen() {
	if (!challenges_definition) return void $.Schedule(0.2, AddChallengeToStrategyScreen);

	const strategy_screen = FindDotaHudElement("StrategyScreen");
	if (!strategy_screen) return void $.Schedule(0.2, AddChallengeToStrategyScreen);

	let selected_hero = Players.GetPlayerSelectedHero(LOCAL_PLAYER_ID);
	if (!selected_hero) return void $.Schedule(0.2, AddChallengeToStrategyScreen);

	const friends_and_foes = strategy_screen.FindChildTraverse("StrategyFriendsAndFoes");
	if (!friends_and_foes) return void $.Schedule(0.2, AddChallengeToStrategyScreen);

	selected_hero = selected_hero.replace("npc_dota_hero_", "");

	const challenge = challenges_definition[selected_hero];
	if (!challenge) return;

	friends_and_foes.visible = false;

	const challenge_panel = CreateChallenge(friends_and_foes.GetParent());
	FillChallengeInfo(selected_hero, challenge_panel);

	$.Schedule(0, () => {
		challenge_panel.style.width = "fill-parent-flow(1);";
	});
}

(function () {
	HUD.CONTEXT.SwitchClass("map_name", MAP_NAME);
	RestyleSkipStrategyButton();
	AddChallengeToStrategyScreen();
	HUD.CONTEXT.RemoveClass("BLocalHeroSelected");

	const frame = GameEvents.NewProtectedFrame(HUD.CONTEXT);
	frame.SubscribeProtected("HeroChallenges:set_challenges", CreateChallenges);

	GameEvents.SendToServerEnsured("HeroChallenges:get_challenges", {});
})();