--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


const ITEMS_SCROLL = [
    "item_armor_aura",
    "item_base_damage_aura",
    "item_expiriance_aura",
    "item_move_aura",
    "item_attack_speed_aura",
    "item_hp_aura",
    "item_cd_aura",
    "item_lifesteal_aura",
    "item_spell_aura",
    "item_gold_aura",
];

function FindDotaHudElement(panel) {
    return $.GetContextPanel().GetParent().GetParent().GetParent().FindChildTraverse(panel);
}

const lower_hud = FindDotaHudElement("lower_hud");
const MyCustomStashPanel = $("#CustomStash_Panel");

function FindItemInShop(tab, itemname) {
    for (let categoryKey in tab) {
        if (typeof(tab[categoryKey]) == "string") continue;
        for (let itemKey in tab[categoryKey]) {
            if (typeof(tab[categoryKey][itemKey]) == "string") continue;
            if (tab[categoryKey][itemKey].itemname != undefined && tab[categoryKey][itemKey].itemname == itemname) {
                return tab[categoryKey][itemKey];
            }
        }
    }
    return false;
}

var number_items_first_line = 0;
var number_items_second_line = 0;

var can_click = true

function InitStash(t) {
    const panel = MyCustomStashPanel.FindChildTraverse("CustomInventorySecondLine");
    panel.RemoveAndDeleteChildren();
    for (let itemname of ITEMS_SCROLL) {
        const itemPanel = $.CreatePanel("Panel", panel, `${itemname}_Panel`);
        itemPanel.BLoadLayout("file://{resources}/layout/custom_game/scroll/itemStashLayout.xml", false, false);
        // itemPanel.BLoadLayoutSnippet("inventory_item")

        const itemImage = itemPanel.FindChildTraverse("ItemImage");
        itemImage.itemname = itemname;

        const ItemInfo = FindItemInShop(t, itemname);
        itemPanel.SetPanelEvent("onactivate", Use(itemname));

        const itemCount = itemPanel.FindChildTraverse("ItemCount");
        itemCount.text = ItemInfo ? ItemInfo.now : 0;
        number_items_second_line += 1;
    } 
    updateCooldowns()
}

// UpdateCooldowns();

function Use(itemname) {
    return () => {
		if (can_click){
			can_click = false
			Game.EmitSound("General.ButtonClick");
			if (update_item(itemname) == true){
				GameEvents.SendCustomGameEventToServer("Use_buff", {
					itemname: itemname,
				});
			}
		}
	}
}

function update_item(itemname){
	// const itemPanel = MyCustomStashPanel.FindChildTraverse(`${itemname}_Panel`);
	// const itemCountPanel = itemPanel.FindChildTraverse("ItemCount");
	// const ItemCD = itemPanel.FindChildTraverse("ItemCD");
	// const updatedCount = Number(itemCountPanel.text) - 1;
	// const ItemCD_text = Number(ItemCD.text) - 1
	// if (ItemCD_text > 0) return false;
	// if (updatedCount < 0) return false;
	// itemCountPanel.text = updatedCount;
	return true
}


function use_all(){
	Game.EmitSound("General.ButtonClick");
	item_use = []
	for (let itemname of ITEMS_SCROLL) {
		if (update_item(itemname) == true){
			item_use.push(itemname)
		}
	}
	GameEvents.SendCustomGameEventToServer("Use_buff_all", {item_use:item_use});
}

// function UpdateCooldowns() {
//     const PlayerID = Players.GetLocalPlayer();
//     const playerIndex = Players.GetPlayerHeroEntityIndex(PlayerID);

//     for (let itemname of ITEMS_SCROLL) {
//         const itemPanel = MyCustomStashPanel.FindChildTraverse(`${itemname}_Panel`);
//         if (itemPanel) {
//             const itemCDPanel = itemPanel.FindChildTraverse("ItemCD");
//             if (itemCDPanel) {
//                 itemCDPanel.visible = false;
//             }
//         }
//     }

//     for (let buffIndex = 0; buffIndex < Entities.GetNumBuffs(playerIndex); buffIndex++) {
//         const buff = Entities.GetBuff(playerIndex, buffIndex);
//         const buffName = Buffs.GetName(playerIndex, buff);

//         for (let itemname of ITEMS_SCROLL) {
//             const modifierCdName = `modifier_${itemname}_cd`
//             const itemPanel = MyCustomStashPanel.FindChildTraverse(`${itemname}_Panel`);
//             if (itemPanel && buffName === modifierCdName) {
//                 const itemCDPanel = itemPanel.FindChildTraverse("ItemCD");
//                 if (itemCDPanel) {
//                     const RemainingTime = Buffs.GetRemainingTime(playerIndex, buff);
//                     itemCDPanel.text = Math.floor(RemainingTime);
//                     itemCDPanel.visible = true;
//                 }
//             }
//         }
//     }
// 	can_click = true
//     $.Schedule(0.5, UpdateCooldowns);
// }



function updateCooldown(panel, timeRemaining, fullTime) {
    const cooldownOverlay = panel.FindChildTraverse("GlobalAbilityCooldownOverlay");
    const cooldownTimer = panel.FindChildTraverse("GlobalAbilityCooldownTimer");
    const timePassedPercent = 100 - timeRemaining / (fullTime / 100);
    if (timeRemaining <= 0) {
        resetCooldown(panel);
    } else {
        cooldownOverlay.style.backgroundColor = "#000000dc";
        cooldownOverlay.style.clip = `radial( 50.0% 50.0%, 0.0deg, -${360 - timePassedPercent / 100 * 360}deg);`;
        cooldownTimer.text = Math.ceil(timeRemaining);
    }
}

function resetCooldown(panel) {
    const cooldownOverlay = panel.FindChildTraverse("GlobalAbilityCooldownOverlay");
    const cooldownTimer = panel.FindChildTraverse("GlobalAbilityCooldownTimer");
    cooldownTimer.text = "";
    cooldownOverlay.style.clip = null;
    cooldownOverlay.style.backgroundColor = null;
}

function updateItem(item) {
    if (!item) return;
    const panel = ITEM_PANEL[item.product.item_name];
    panel.FindChildTraverse("item_counter").text = item.amount;
}

function updateCooldowns() {
    const playerID = Players.GetLocalPlayer();
    const playerIndex = Players.GetPlayerHeroEntityIndex(playerID);

    for (const itemName of Object.values(ITEMS_SCROLL)) {
        const itemPanel = MyCustomStashPanel.FindChildTraverse(`${itemName}_Panel`);
        if (!itemPanel) continue;
        resetCooldown(itemPanel);
    }

    for (let buffIndex = 0; buffIndex < Entities.GetNumBuffs(playerIndex); buffIndex++) {
        const buff = Entities.GetBuff(playerIndex, buffIndex);
        const buffName = Buffs.GetName(playerIndex, buff);
        for (const itemName of Object.values(ITEMS_SCROLL)) {
            if (buffName === `modifier_${itemName}_cd`) {
                const itemPanel = MyCustomStashPanel.FindChildTraverse(`${itemName}_Panel`);
                const remainingTime = Buffs.GetRemainingTime(playerIndex, buff);
                const duration = Buffs.GetDuration(playerIndex, buff);
                updateCooldown(itemPanel, remainingTime, duration);
            }
        }
    }
}

var isOpen = true;
function show() {
	const scaleX = Game.IsHUDFlipped() ? -1 : 1;
	if (isOpen) {
		isOpen = false;
		MyCustomStashPanel.SetHasClass("hide_panel", isOpen);
		MyCustomStashPanel.style.transform = `scaleX(${scaleX}) translate3d(0px, 250px, 0px)`;
	} else {
		isOpen = true;
		MyCustomStashPanel.SetHasClass("hide_panel", isOpen);
		MyCustomStashPanel.style.transform = `scaleX(${scaleX}) translate3d(0px, 0px, 0px)`;
	}
}

	

(function () {
    GameEvents.Subscribe("initShop", InitStash);
    GameEvents.Subscribe("initShop2", InitStash);
    GameEvents.Subscribe("UpdateStore", (tab) => {
        for (let i in tab) {
            const itemname = tab[i].itemname;
            if (!itemname || !ITEMS_SCROLL.includes(itemname)) continue;

            const itemPanel = MyCustomStashPanel.FindChildTraverse(`${itemname}_Panel`);
            itemPanel.FindChildTraverse("ItemCount").text = tab[i].count;
            itemPanel.visible = true;
        }
    });
    if (!lower_hud.FindChildTraverse("CustomStash_Panel")) {
        MyCustomStashPanel.SetParent(lower_hud);
    }
    const cooldownRefreshCycle = ()=>{
        updateCooldowns()
        $.Schedule(0.2, cooldownRefreshCycle);
    }
    cooldownRefreshCycle();
})();
