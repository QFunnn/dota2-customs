--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


const HUD = {
	CONTEXT: $.GetContextPanel(),
	TALENTS: $("#CTT_TalentsBranch"),
};
function UpdateTalentsTooltip() {
	GameUI.UpdateCustomScoreboardTalents = (talents, hero_entity, localized_lines) => {
		for (const [talent_idx, talent_name] of Object.entries(talents)) {
			const talent_line = HUD.TALENTS.FindChildTraverse(`UpgradeName${parseInt(talent_idx) + 1}`);
			if (!talent_line) continue;

			talent_line.text = "";

			GameUI.SetupDOTATalentNameLabel(talent_line, talent_name);
			if (localized_lines[talent_idx]) talent_line.text = localized_lines[talent_idx];

			talent_line.GetParent().RemoveClass("BranchChosen");

			const ability = Entities.GetAbilityByName(hero_entity, talent_name);
			if (ability) talent_line.GetParent().SetHasClass("BranchChosen", Abilities.GetLevel(ability) > 0);
		}
	};
}