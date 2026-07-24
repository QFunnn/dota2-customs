--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const basePanel = $.GetContextPanel().GetParent().GetParent().GetParent();
let x = basePanel.FindChildTraverse('HUDElements');
x = x.FindChildTraverse('lower_hud');
x = x.FindChildTraverse('center_with_stats');
x = x.FindChildTraverse('center_block');
x = x.FindChildTraverse('AbilitiesAndStatBranch');
const abilities = x.FindChildTraverse('abilities');

//Set this higher if the "wiggle is too much"
var MAX_CONSECUTIV = 6;

var abilityState = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
var abilityData = [undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined];
var lastSelected = undefined;

//Check if selected units ability goes on cooldown
$.RegisterForUnhandledEvent("StyleClassesChanged", (panel) => { 
	if (panel === null) return;
	const abilityIndex = GetAbilityIndexFromPanel(panel);
	if (abilityIndex >= 0) {
		if (abilityState[abilityIndex] > 0) {
			return;
		}
		const abilityPanel = FindAbilityPanelByIndex(abilityIndex);
		if (abilityPanel) {
			$.Msg("Ability activated!");
			const abilityImage = abilityPanel.FindChildTraverse("AbilityImage")
			const abilityID = abilityImage.contextEntityIndex;
			const cooldownPanel = abilityPanel.FindChild("Cooldown");
			const cooldown = Abilities.GetCooldownTimeRemaining(abilityID);
			if (cooldown > 0) {
				abilityState[abilityIndex] = 1;
				abilityData[abilityIndex] = [abilityID, cooldownPanel, cooldown, Abilities.GetCooldownLength(abilityID), 0];
				OverwriteOverlay(abilityIndex);
			}
		}
	}
});

//Get the ability index (not ability id), if the panel is an ability panel and on cooldown
function GetAbilityIndexFromPanel(panel) {
	if (panel.paneltype === "DOTAAbilityPanel" && panel.BHasClass("in_cooldown")) {
		const parent = panel.GetParent();
		if (parent !== undefined && parent.id === "abilities") {
			return parseInt(panel.id.slice(-1), 10);
		}
	}
	return -1;
}

//Checks if selected unit has changed and checks for abilities on cooldown
function CheckAbilities() {
	const mainSelected = Players.GetLocalPlayerPortraitUnit();
	let reCheck = false;
	if (mainSelected !== lastSelected) {
		abilityState = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
		abilityData = [undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined];
		reCheck = true;
	}
	lastSelected = mainSelected;

	if (reCheck) {
		for (let i = 0; i < 10; i++) {
			const abilityPanel = FindAbilityPanelByIndex(i);
			if (abilityPanel) {
				const abilityImage = abilityPanel.FindChildTraverse("AbilityImage")
				const abilityID = abilityImage.contextEntityIndex;
				const cooldownPanel = abilityPanel.FindChildTraverse("Cooldown");
				const cooldown = Abilities.GetCooldownTimeRemaining(abilityID);
				if (cooldown && cooldown > 0) {
					abilityState[i] = 1;
					abilityData[i] = [abilityID, cooldownPanel, cooldown, Abilities.GetCooldownLength(abilityID), 0];
					OverwriteOverlay(i);
				}
			}
		}
	} else if (abilityState.includes(1)) {
		for (let i = 0; i < 10; i++) {
			if (abilityState[i] == 1) {
				OverwriteOverlay(i);
			}
		}
	}
	$.Schedule(1/60, CheckAbilities)
}

//Find the ability panel for this index
function FindAbilityPanelByIndex(index) {
	const abilityPanel = abilities.FindChild("Ability" + index);
	if (abilityPanel === null) {return false;}
	const abilityButtonAndLevel = abilityPanel.FindChild("ButtonAndLevel");
	const abilityLevelUpTab = abilityButtonAndLevel.FindChild("ButtonWithLevelUpTab");
	const abilityButtonWell = abilityLevelUpTab.FindChild("ButtonWell");
	const abilityButtonSize = abilityButtonWell.FindChild("ButtonSize");
	return abilityButtonSize.FindChild("AbilityButton");
}

//Called multiple times a second; updates the cooldown visualizer
function OverwriteOverlay(index) {
	const data = abilityData[index];
	let cooldowns = GetCooldowns(index);
	if (cooldowns) {
		const percentage = cooldowns[0];
		const currentCD = cooldowns[1];
		const overlay = ReplaceOverlay(data[1]);
		const timer = ReplaceTimer(data[1]);
		if (percentage > 1) {
			percentage = 1;
		}
		const degrees = -360 * percentage;
		overlay.style.clip = "radial( 50.0% 50.0%, 0.0deg, " + degrees + "deg)";
		timer.text = Math.ceil(currentCD);
	} else {
		if (abilityState[index] == 1) {
			abilityState[index] = 0;
			abilityData[index] = undefined;
		}
	}
}

//Calculated the current fill percentage
function GetCooldowns(index) {
	const mainSelected = Players.GetLocalPlayerPortraitUnit();
	let data = abilityData[index];
	if (data[0] !== undefined) {
		let maxCD = Abilities.GetCooldown(data[0]) * GetCooldownReduction(mainSelected);
		if (maxCD === 0) {
			return false;
		}
		let curCD = Abilities.GetCooldownTimeRemaining(data[0]);
		if (curCD > maxCD) {
			maxCD = data[3];
		}
		let consecutiv = data[4];
		if (curCD > data[2]) {
			abilityData[index][4] = consecutiv + 1;
			if (consecutiv <= MAX_CONSECUTIV - 1) {
				let ratio = data[2] / maxCD;
				return [ratio, data[2]];
			}
		} else if (consecutiv < MAX_CONSECUTIV) {
			abilityData[index][4] = 0;
		}
		abilityData[index][2] = curCD
		if (curCD === 0) {
			return [0, 0];
		}
		let ratio = curCD / maxCD;
		return [ratio, curCD];
	}
	return false;
}

//Adds the custom cooldown overlay and hides the default one
function ReplaceOverlay(cdPanel) {
	let overlay = cdPanel.FindChildTraverse("CooldownOverlay");
	if (overlay) {
		overlay.style.opacity = "0";
	}
	let newOverlay = cdPanel.FindChildTraverse("NewCooldownOverlay");
	if (newOverlay === undefined || !newOverlay) {
		newOverlay = $.CreatePanel("Panel", $.GetContextPanel(), "NewCooldownOverlay");
		newOverlay.SetParent(cdPanel);
		newOverlay.style.width = "100%";
		newOverlay.style.height = "100%";
		newOverlay.style.backgroundColor = "#000000dc";
		newOverlay.hittest = false;

		let child1 = cdPanel.GetChild(1);
		let child2 = cdPanel.GetChild(2);
		cdPanel.MoveChildAfter(child1, child2);
	} else {
		newOverlay.style.opacity = "1";
	}
	return newOverlay;
}

//Adds the custom cooldown timer and hides the default one
function ReplaceTimer(cdPanel) {
	let timer = cdPanel.FindChildTraverse("CooldownTimer");
	if (timer) {
		timer.style.opacity = "0";
	}
	let newTimer = cdPanel.FindChildTraverse("NewCooldownTimer");
	if (newTimer === undefined || !newTimer) {
		newTimer = $.CreatePanel("Label", $.GetContextPanel(), "NewCooldownTimer");
		newTimer.SetParent(cdPanel);
		newTimer.AddClass("MonoNumbersFont")
		newTimer.style.width = "100%";
		newTimer.style.color = "white";
		newTimer.style.fontSize = "28px";
		newTimer.style.textShadow = "0px 0px 6px 6 #000000";
		newTimer.style.textAlign = "center";
		newTimer.style.verticalAlign = "center";
		newTimer.style.textOverflow = "shrink";
		newTimer.hittest = false;

		newTimer.text = timer.text;

	} else {
		newTimer.style.opacity = "1";
	}
	return newTimer;
}

//Receives the cdr from custom nettable entries
function GetCooldownReduction(unitID) {
	let table = CustomNetTables.GetTableValue("better_cooldowns_cdr", unitID.toString())
	if (table) {
		return parseFloat(table["cdr"]);
	}
	return 1;
}

//Start the checker
CheckAbilities();