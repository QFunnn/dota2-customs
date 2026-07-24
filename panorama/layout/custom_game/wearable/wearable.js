--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var uniqueIndex = 0;
function GetUniqueID() {
	uniqueIndex++;
	return "UID" + uniqueIndex.toString();
};


function SwitchWearable(slotName, itemDef, itemStyle) {
	if (!itemStyle) {
		itemStyle = 0;
	}
	return function () {
		//$.Msg('SwitchWearable ',slotName,' ', itemDef, ' ', itemStyle);

		if ($("#CosmeticsContainerMain") && $("#CosmeticsContainerMain").BHasClass("Blur")) {
			return;
		}

		if (slotName == "taunt") {
			GameEvents.SendCustomGameEventToAllClients("UpdateCosmeticTaunt", { playerId: Players.GetLocalPlayer(), itemDef: itemDef });
		}
		let hero = Players.GetPlayerHeroEntityIndex(Players.GetLocalPlayer())
		GameEvents.SendCustomGameEventToServer("SwitchWearable", { "unit": hero, "itemDef": itemDef, "itemStyle": itemStyle });
	}
};


function SortSlots(availableItems) {
	let slotArray = [];
	for (let slotName in availableItems) {
		let Slot = availableItems[slotName];
		Slot.SlotName = slotName;
		let slotIndex = Slot.SlotIndex;
		if (slotIndex === undefined) {
			continue;
		}
		let i = 0
		for (let i = 0; i < slotArray.length; i++) {
			if (slotIndex < slotArray[i].SlotIndex) {
				break;
			}
		}
		slotArray.splice(i, 0, Slot);

	}
	return slotArray;
}


function ToggleStyleMenu(styleMenu) {
	return function () {
		styleMenu.ToggleClass("Hidden");
	}
}
function GetPassData(){
	let data = CustomNetTables.GetTableValue("service", "player_vip")
	if(!data) return
	return data[Players.GetLocalPlayer()]
	// return CustomNetTables.GetTableValue("service", "player_vip")?.[Players.GetLocalPlayer()];
}

function SetEconItemButtons(econItemID, itemDef, itemStyle) {
	let econItem = $("#" + econItemID);
	let econItemSlot = econItem.GetParent()
	let slotName = econItemSlot.id
	let position = econItemSlot.GetPositionWithinWindow();
	let x = position.x / econItemSlot.actualuiscale_x
	let y = (position.y + econItemSlot.actuallayoutheight) / econItemSlot.actualuiscale_y;

	if (itemStyle === undefined) {
		itemStyle = 0;
	}
	let multiStyle = econItem.FindChildTraverse("MultiStyle");
	$.Schedule(0, () => {
		if (multiStyle.visible || slotName == "shapeshift") {
			let unit = Players.GetLocalPlayerPortraitUnit();
			let imageSrc = null;
			let availableStylesList = null

			let availableItems = CustomNetTables.GetTableValue("hero_info", "available_items_" + Entities.GetUnitName(unit));
			availableStylesList = availableItems[slotName]["styles"][itemDef];

			if (availableStylesList
				&& availableStylesList[itemStyle.toString()]
				&& availableStylesList[itemStyle.toString()].icon_path) {
				imageSrc = "s2r://panorama/images/" + availableStylesList[itemStyle.toString()].icon_path + "_png.vtex";
			}

			let selectStyle = multiStyle.FindChildTraverse("MultiStyleSelectedStyle");
			let total = selectStyle.text.split('/')[1];
			if (slotName == "shapeshift") {
				total = 3;
				multiStyle.visible = true;
			}

			selectStyle.text = (itemStyle + 1).toString() + "/" + total;

			let styleMenu = $.CreatePanel("Panel", $.GetContextPanel(), econItemID + "StyleMenu");
			styleMenu.BLoadLayoutSnippet("EconItemStyleContextMenu");

			let econItemIcon = econItem.FindChildTraverse("EconItemIcon");

			if (imageSrc) {
				econItemIcon.SetImage(imageSrc);
			}

			styleMenu.SetPositionInPixels(x, y, 0);

			let stylesList = styleMenu.FindChildTraverse("StylesList");
			for (let iStyle = 0; iStyle < parseInt(total); iStyle++) {
				let styleEntry = $.CreatePanel("Panel", stylesList, "");
				styleEntry.BLoadLayoutSnippet("StyleEntry");
				if (iStyle == itemStyle) {
					styleEntry.AddClass("Selected");
				} else {
					styleEntry.AddClass("Available");
					styleEntry.SetPanelEvent("onactivate", SwitchWearable(slotName, itemDef, iStyle));
				}
				if (availableStylesList
					&& availableStylesList[iStyle.toString()]
					&& availableStylesList[iStyle.toString()].name) {
					let styleLabel = styleEntry.FindChildTraverse("StyleLabel");
					styleLabel.text = $.Localize(availableStylesList[iStyle.toString()].name)
				}
			}
			multiStyle.SetPanelEvent("onactivate", ToggleStyleMenu(styleMenu));
		}

		let teamSelectorContainer = econItemSlot.GetParent().FindChildTraverse("TeamSelectorContainer");
		if (teamSelectorContainer) {
			if (econItem.BHasClass("HasTeamSpecificViews")) {
				teamSelectorContainer.SetHasClass("Hidden", false);
			} else {
				teamSelectorContainer.SetHasClass("Hidden", true);
			}
		}
	})

	econItem.SetPanelEvent("oncontextmenu", function () {
		let contextMenu = $.CreatePanel("ContextMenuScript", $.GetContextPanel(), "");
		contextMenu.AddClass("ContextMenu_NoArrow");
		contextMenu.AddClass("ContextMenu_NoBorder");
		contextMenu.GetContentsPanel().itemDef = itemDef;
		contextMenu.GetContentsPanel().itemStyle = itemStyle;
		contextMenu.GetContentsPanel().BLoadLayout("file://{resources}/layout/custom_game/wearable/econ_item_context_menu.xml", false, false);
		contextMenu.GetContentsPanel().SetFocus();
	})
}






function SelectSlot(econItemSlot, slotStorePanel) {
	return function () {
		Game.EmitSound('ui.books.pageturns');
		let styleMenus = $.GetContextPanel().FindChildrenWithClassTraverse("EconItemStyleContents");
		let unit = Players.GetLocalPlayerPortraitUnit();
		let container = $("#UnitItemContainer_" + unit.toString());
		for (let child of styleMenus) {
			child.SetHasClass("Hidden", true);
		}

		if (econItemSlot != null) {
			let econItemSlotParent = econItemSlot.GetParent();
			for (let child of econItemSlotParent.Children()) {
				child.SetHasClass("Selected", false);
			}
			econItemSlot.SetHasClass("Selected", true);
			if (container) {
				container.FindChildTraverse("Bundle").SetHasClass("SourceButtonDisabled", true);
				container.FindChildTraverse("Single").SetHasClass("SourceButtonDisabled", false);
			}
		} else {
			// 点击面板，切换到捆绑包栏
			let children = $.GetContextPanel().FindChildrenWithClassTraverse("Selected");
			for (let child of children) {
				if (child.BHasClass("EconItemSlot")) {
					child.SetHasClass("Selected", false);
				}
			}
			if (container) {
				container.FindChildTraverse("Bundle").SetHasClass("SourceButtonDisabled", false);
				container.FindChildTraverse("Single").SetHasClass("SourceButtonDisabled", true);
			}
		}

		let slotStoreParent = slotStorePanel.GetParent();
		for (let child of slotStoreParent.Children()) {
			child.SetHasClass("Hidden", true);
		}
		slotStorePanel.SetHasClass("Hidden", false);
	}
};




function CreateSelectCosmeticsForUnit(unit) {

	let container = $.CreatePanel("Panel", $("#CosmeticsContainerMain"), "UnitItemContainer_" + unit.toString());
	container.BLoadLayoutSnippet("EconItemContainer");
	let equipContainer = container.FindChildTraverse("EquipItemContainer");
	let availableItemsCarousel = container.FindChildTraverse("AvailableItemsCarousel");
	let availableItems = CustomNetTables.GetTableValue("hero_info", "available_items_" + Entities.GetUnitName(unit));
	// 创建捆绑包可更换装备栏
	if (availableItems && availableItems["bundles"]) {
		let bundles = availableItems["bundles"];
		let bundlePanel = $.CreatePanel("DelayLoadPanel", availableItemsCarousel, "bundle");
		bundlePanel.AddClass("CarouselPage");
		for (let k in bundles) {
			let storeItemDef = bundles[k];
			let storeItemID = "StoreItem" + storeItemDef;

			const storeItemPanel = $.CreatePanel("DOTAStoreItem", bundlePanel, storeItemID, { itemdef: storeItemDef });
			storeItemPanel.style.width = "180px";
			storeItemPanel.style.height = "200px";
			storeItemPanel.style.marginRight = "10px";
			storeItemPanel.style.marginBottom = "10px";
			storeItemPanel.SetPanelEvent("onactivate", SwitchWearable("bundles", storeItemDef));

			let storeItem = bundlePanel.FindChildTraverse(storeItemID);

			// 饰品图片会挡住父面板的点击事件，但又需要它的tooltip，不能关闭hittest
			let itemImage = storeItem.FindChildTraverse("ItemImage");
			itemImage.SetPanelEvent("onactivate", SwitchWearable("bundles", storeItemDef));

			let purchaseButton = storeItem.FindChildTraverse("PurchaseButton");
			purchaseButton.visible = false;
		}
		equipContainer.SetPanelEvent("onactivate", SelectSlot(null, bundlePanel));
		let bundleButton = container.FindChildTraverse("Bundle");
		bundleButton.SetPanelEvent("onactivate", SelectSlot(null, bundlePanel));
	}

	let slotArray = SortSlots(availableItems);
	for (let slotIndex = 0; slotIndex < slotArray.length; slotIndex++) {
		let slot = slotArray[slotIndex];

		if (slot.DisplayInLoadout == 0) {
			continue;
		}

		let slotName = slot.SlotName;

		let equipedItemDef = slot.DefaultItem;
		let equipedItemStyle = 0;

		// 创建单一槽位格
		let econItemSlot = $.CreatePanel("Panel", equipContainer, slotName);
		econItemSlot.BLoadLayoutSnippet("EconItemSlot");

		let slotLabel = econItemSlot.FindChildTraverse("SlotName");
		slotLabel.text = $.Localize(slot.SlotText);

		let uid = GetUniqueID();

		const econItem = $.CreatePanel("DOTAEconItem", econItemSlot, uid, { itemdef: equipedItemDef, itemstyle: equipedItemStyle });
		econItem.AddClass("DisableInspect");
		econItem.SetPanelEvent("onload", () => {
			SetEconItemButtons(uid, equipedItemDef, equipedItemStyle);
		});

		// 创建该槽位可更换装备栏
		let delayLoadPanel = $.CreatePanel("DelayLoadPanel", availableItemsCarousel, slotName);
		delayLoadPanel.AddClass("CarouselPage");
		for (let k in slot["ItemDefs"]) {
			let storeItemDef = slot["ItemDefs"][k];
			let storeItemID = "StoreItem" + storeItemDef;

			const storeItem = $.CreatePanel("DOTAStoreItem", delayLoadPanel, storeItemID, { itemdef: storeItemDef });
			storeItem.style.width = "180px";
			storeItem.style.height = "200px";
			storeItem.style.marginRight = "10px";
			storeItem.style.marginBottom = "10px";
			storeItem.SetPanelEvent("onactivate", SwitchWearable(slotName, storeItemDef));

			// // 饰品图片会挡住父面板的点击事件，但又需要鼠标停留时它的tooltip，不能关闭hittest
			let itemImage = storeItem.FindChildTraverse("ItemImage");
			itemImage.SetPanelEvent("onactivate", SwitchWearable(slotName, storeItemDef));

			let purchaseButton = storeItem.FindChildTraverse("PurchaseButton");
			purchaseButton.visible = false;
		}
		delayLoadPanel.SetHasClass("Hidden", true);

		econItemSlot.SetPanelEvent("onactivate", SelectSlot(econItemSlot, delayLoadPanel));
	}

	if (Entities.GetUnitName(unit) == "npc_dota_hero_tiny") {
		let tinyModelButtons = $.CreatePanel("Panel", equipContainer, "TinyModelButtons");
		tinyModelButtons.BLoadLayoutSnippet("TinyModelButtons");
		let model1 = tinyModelButtons.FindChildTraverse("Model1");
		model1.checked = true;
	}

}




function CloseSelectCosmetics() {
	$('#SelectCosmeticsContainer').SetHasClass('CosmeticsContainerVisible', false);
}


function ToggleSelectCosmetics(keys) {
	// if (keys.playerId == Players.GetLocalPlayer()) {
		let hero = Players.GetPlayerHeroEntityIndex(Players.GetLocalPlayer())

		const passData = GetPassData();
		if(!passData || passData.level == 0) return

		$("#CosmeticsContainerMask").SetHasClass("Hidden", true);

		$("#CosmeticsContainerMain").RemoveClass("Blur");

		//先全部隐藏
		let children = $("#CosmeticsContainerMain").Children();
		for (let child of children) {
			child.SetHasClass("Hidden", true);
		}

		//只保留当前英雄
		let container = $("#UnitItemContainer_" + hero.toString());
		if (container == null) {
			CreateSelectCosmeticsForUnit(hero);
		} else {
			container.SetHasClass("Hidden", false);
		}

		//测试用代码重建面板
		/**
		else {
			container.RemoveAndDeleteChildren();
			container.DeleteAsync(0)
			CreateSelectCosmeticsForUnit(hero);
		}
		**/
		$('#SelectCosmeticsContainer').ToggleClass('CosmeticsContainerVisible');
	// }
}


function HideSelectCosmetics(keys) {
	//全部隐藏
	let children = $("#CosmeticsContainerMain").Children();
	for (let child of children) {
		child.SetHasClass("Hidden", true);
	}
	$('#SelectCosmeticsContainer').SetHasClass('CosmeticsContainerVisible', false);
}

function GetEconItem(EconItemSlot) {
	let EconItem;
	for (let child of EconItemSlot.Children()) {
		if (child.paneltype == "DOTAEconItem") {
			EconItem = child;
		}
	}
	return EconItem
}

function UpdateWearable(params) {

	Game.EmitSound('inventory.wear');
	let unit_id = params.unit;
	let itemDef = params.itemDef;
	let slotName = params.slotName;
	let itemStyle = params.itemStyle;

	let container = $("#UnitItemContainer_" + unit_id.toString());

	if (container) {
		let equipContainer = container.FindChildTraverse("EquipItemContainer");
		let econItemSlot = equipContainer.FindChildTraverse(slotName);

		if (econItemSlot) {
			let econItem = GetEconItem(econItemSlot);
			let styleMenu = $("#" + econItem.id + "StyleMenu");

			econItem.DeleteAsync(0);
			if (styleMenu) {
				styleMenu.DeleteAsync(0);
			}

			let uid = GetUniqueID();
			const EconItemPanel = $.CreatePanel("DOTAEconItem", econItemSlot, uid, { itemdef: itemDef, itemstyle: itemStyle });
			EconItemPanel.AddClass("DisableInspect");
			EconItemPanel.SetPanelEvent("onload", () => {
				SetEconItemButtons(uid, itemDef, itemStyle);
			});
		}
	}
}

function SetWearButtonEvent(wearButton) {
	//给自己客户端发消息，打开面板
	wearButton.SetPanelEvent("onactivate", function () {
		GameEvents.SendEventClientSide("client_side_event", { event_name: "ToggleSelectCosmetics", event_data:{}} )
		// GameEvents.SendCustomGameEventToAllClients("ToggleSelectCosmetics", { playerId: Players.GetLocalPlayer() });
	});
}

//入口按钮初始化 在inventory.js中 UpdatePassInfo方法
//此处监听按钮方法
(function () {
	GameEvents.Subscribe("client_side_event", (eventData)=>{
		if (eventData.event_name == "ToggleSelectCosmetics") {
			ToggleSelectCosmetics()
		}else if(eventData.event_name == "HideSelectCosmetics"){
			HideSelectCosmetics()
		}
	});
	// GameEvents.Subscribe("HideSelectCosmetics", HideSelectCosmetics);
	GameEvents.Subscribe("UpdateWearable", UpdateWearable);

	//初始化换装按钮
	var stats_container = FindDotaHudElement("stats_container");
	wearButton = stats_container.FindChildTraverse("WearButton");

	if (wearButton == undefined) {
		wearButton = $.CreatePanel("Button", stats_container, "WearButton");
	}

	wearButton.style.width = "26px";
	wearButton.style.height = "26px";
	wearButton.style.marginBottom = "26px";
	wearButton.style.marginLeft = "10px";
	wearButton.style.verticalAlign = "bottom";
	wearButton.style.backgroundImage = 'url("s2r://panorama/images/dota_plus/dotaplus_logo_small_png.vtex");';
	wearButton.style.backgroundSize = "19.5px 22.5px";
	wearButton.style.backgroundRepeat = "no-repeat";
	wearButton.style.backgroundPosition = "0% 50%";
	wearButton.style.saturation = 0;
	wearButton.style.zIndex = 999
	wearButton.hittest = true;
	SetWearButtonEvent(wearButton)

	//避免属性值挡住按键
	// var stragiint = FindDotaHudElement("stragiint");
	// if (stragiint != undefined) {
	// 	stragiint.hittest = false;
	// }
	// var stats_tooltip_region = FindDotaHudElement("stats_tooltip_region");
	// if (stats_tooltip_region != undefined) {
	// 	stats_tooltip_region.hittest = true;
	// }
	// var LowerOverlay = FindDotaHudElement("LowerOverlay");
	// if (LowerOverlay != undefined) {
	// 	LowerOverlay.hittest = false;
	// }
	// var ReportUserButton = FindDotaHudElement("ReportUserButton");
	// if (ReportUserButton != undefined) {
	// 	ReportUserButton.hittest = false;
	// }

	// CustomNetTables.GetTableValue("service", "player_vip")[Players.GetLocalPlayer()];
	const passData = GetPassData()

	if(passData && passData.level > 0){
		if (wearButton != null && wearButton != undefined) {
			wearButton.style.saturation = "1";
		}
		let selectCosmeticsContainer = FindDotaHudElement("SelectCosmeticsContainer");
		if (selectCosmeticsContainer != undefined) {
			let cosmeticsContainerMain = selectCosmeticsContainer.FindChildTraverse("CosmeticsContainerMain");
			if (cosmeticsContainerMain != undefined) {
				cosmeticsContainerMain.RemoveClass("Blur");
			}

			let cosmeticsContainerMask = selectCosmeticsContainer.FindChildTraverse("CosmeticsContainerMask");
			if (cosmeticsContainerMask != undefined) {
				cosmeticsContainerMask.SetHasClass("Hidden", true);
			}
		}
	}
})();