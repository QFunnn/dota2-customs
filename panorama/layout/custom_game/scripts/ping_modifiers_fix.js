--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function GetBuffBySerialNumber(entity_id, check_debuffs, n_serial) {
	let buffs_count = Entities.GetNumBuffs(entity_id);
	let counter = 0;

	for (let i = 0; i < buffs_count; i++) {
		let mod_id = Entities.GetBuff(entity_id, i);

		if (mod_id == -1 || Buffs.IsHidden(entity_id, mod_id)) continue;

		if (Buffs.IsDebuff(entity_id, mod_id)) {
			if (!check_debuffs) continue;
		} else if (check_debuffs) continue;

		if (counter == n_serial) return mod_id;
		counter++;
	}
}

const modifiers_info = {
	buffs: {
		container: FindDotaHudElement("buffs"),
		counter: 0,
	},
	debuffs: {
		container: FindDotaHudElement("debuffs"),
		counter: 0,
	},
};

let last_ping_time = 0;
let spam_time_counter = 0;
let is_cooldown = false;

const ANTI_SPAM_DELAY = 0.5; //sec
const SPAM_COUNT_LIMIT = 1; //max count is variable + 1
const SPAM_COOLDOWN = 2;

function RegisterModifiersPanels() {
	const register_children = (type, is_debuff) => {
		const container = modifiers_info[type].container;
		const max_length = container.Children().length;

		for (let x = modifiers_info[type].counter; x < max_length; x++) {
			const mod_panel = container.GetChild(x);
			mod_panel.GetChild(0).SetPanelEvent("onactivate", () => {
				if (!GameUI.IsAltDown()) return;

				if (is_cooldown) return;

				if (spam_time_counter >= SPAM_COUNT_LIMIT) {
					is_cooldown = true;
					$.Schedule(SPAM_COOLDOWN, () => {
						is_cooldown = false;
						spam_time_counter = 0;
					});
					return;
				}

				let diff = Game.GetGameTime() - last_ping_time;
				if (diff > ANTI_SPAM_DELAY) {
					spam_time_counter = 0;
				} else spam_time_counter++;

				last_ping_time = Game.GetGameTime();

				const portrait_unit = Players.GetLocalPlayerPortraitUnit(LOCAL_PLAYER_ID);
				if (portrait_unit == undefined) return;

				const modifier_idx = GetBuffBySerialNumber(portrait_unit, is_debuff, x);
				if (modifier_idx == undefined) return;

				const modifier_name = Buffs.GetName(portrait_unit, modifier_idx);

				const loc_token = `DOTA_Tooltip_${modifier_name}`;
				const loc_result = $.Localize(loc_token);
				if (loc_token == loc_result) return;

				GameEvents.SendToServerEnsured("PingModifeirs:ping", {
					target_entity: portrait_unit,
					modifier_name: modifier_name,
				});
			});
			modifiers_info[type].counter++;
		}
	};

	register_children("buffs", false);
	register_children("debuffs", true);

	$.Schedule(1, RegisterModifiersPanels);
}

(function () {
	RegisterModifiersPanels();
})();