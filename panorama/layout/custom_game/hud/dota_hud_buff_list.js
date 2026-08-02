--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


let BUFF_LIST_CHILDRENS_PER_ROW = 10;
let BUFF_LIST_MAX_ROWS = 3;
let BUFF_LIST_INITIAL_CHILDRENS = BUFF_LIST_MAX_ROWS * BUFF_LIST_CHILDRENS_PER_ROW;
let BUFF_LIST_TICKRATE = 0.03;

function GetLocalPlayerSelectedUnit() {
	let selectedUnit = Players.GetQueryUnit(Game.GetLocalPlayerID())
	if (selectedUnit < 0) {
		selectedUnit = Players.GetLocalPlayerPortraitUnit()
	}
	return selectedUnit;
}

function UpdateBuffs(panel, isBuffs) {
	// No idea why it may rarely fail and throw exception (hopefully its one time bug and try catch will fix that)
	try
	{
		let selectedUnit = GetLocalPlayerSelectedUnit();
		let buffSerialsToUse = [];

		for (let i = 0; i <= Entities.GetNumBuffs(selectedUnit); i++)
		{
			let buffSerial = Entities.GetBuff(selectedUnit, i);

			if (buffSerial < 0) {
				break;
			}

			let isSkip = Buffs.IsDebuff(selectedUnit, buffSerial) == isBuffs;

			if (isSkip) {
				continue;
			}

			let isHidden = Buffs.IsHidden(selectedUnit, buffSerial);

			if (isHidden) {
				continue;
			}

			let modifierName = Buffs.GetName(selectedUnit, buffSerial);
			let isBrokenModifier = modifierName == undefined || modifierName.length < 1;

			if (isBrokenModifier) {
				continue;
			}

			buffSerialsToUse.push(buffSerial);
		}

		for (let i = 0; i < BUFF_LIST_INITIAL_CHILDRENS; i++) {
			if (buffSerialsToUse[i] != null) {
				panel._childrens[i].SetHasClass("Hidden", false);
				UpdateBuffPanel(panel._childrens[i], selectedUnit, buffSerialsToUse[i]);
			} else {
				if (!panel._childrens[i].BHasClass("Hidden")) {
					panel._childrens[i].SetHasClass("Hidden", true);

					panel._childrens[i]._image.SetImage(undefined)
					panel._childrens[i]._image.texture = undefined
					panel._childrens[i]._image.imagePath = undefined
				}
			}
		}
	} catch (e) {
		$.Msg(e)
	}

	$.Schedule(BUFF_LIST_TICKRATE, function() {
		UpdateBuffs(panel, isBuffs);
	});
}

const texturesMap = new Map()

const panoramaImagesDirs = [
	"file://{images}/items/",
	"file://{images}/spellicons/",
	"file://{images}/account/"
]

const imagesDirs = [
	"raw://resource/flash3/images/items/",
	"raw://resource/flash3/images/spellicons/",
]

function tryNextImagesDir(texture, lastImageDirIndex) {
	const textureWithoutItemPrefix = texture.startsWith("item_") ? texture.substring(5) : undefined

	if (lastImageDirIndex === undefined) {
		lastImageDirIndex = -1

		texturesMap.set(texture, lastImageDirIndex)

		for (const paronamaImagesDir of panoramaImagesDirs) {
			const panoramaImagePath = paronamaImagesDir + texture + ".png"

			if ($.BImageFileExists(panoramaImagePath)) {
				return [true, panoramaImagePath]
			}

			if (textureWithoutItemPrefix) {
				const panoramaImagePath = paronamaImagesDir + textureWithoutItemPrefix + ".png"

				if ($.BImageFileExists(panoramaImagePath)) {
					return [true, panoramaImagePath]
				}
			}
		}
	}

	lastImageDirIndex++;

	texturesMap.set(texture, lastImageDirIndex)

	const resourceImageDir = imagesDirs[lastImageDirIndex / 2 | 0]

	if (!resourceImageDir) {
		texturesMap.set(texture, "")
		return
	}

	const withoutItemPrefix = lastImageDirIndex % 2 == 1

	const resourceImagePath = resourceImageDir + ((withoutItemPrefix && textureWithoutItemPrefix) ? textureWithoutItemPrefix : texture) + ".png"

	return [false, resourceImagePath]
}

function bruteForceTextureImage(imagePanel, texture) {
	if (imagePanel.actuallayoutwidth < 5)
		return

	const cachedImagePath = texturesMap.get(texture)

	if (typeof cachedImagePath === "string") {
		imagePanel.SetImage(cachedImagePath)
		return
	}

	if (imagePanel.contentwidth != 2 && imagePanel.texture === texture) {
		texturesMap.set(imagePanel.texture, imagePanel.imagePath)
		return
	}

	const [success, imagePath] = tryNextImagesDir(texture, cachedImagePath)

	if (success) {
		texturesMap.set(texture, imagePath)
		imagePanel.SetImage(imagePath)
		return
	}

	imagePanel.imagePath = imagePath
	imagePanel.texture = texture
	imagePanel.SetImage(imagePath)

	return 
}

function UpdateBuffPanel(panel, selectedUnit, buffSerial) {
	let stacksCount = Buffs.GetStackCount(selectedUnit, buffSerial);
	let texture = Buffs.GetTexture(selectedUnit, buffSerial);

	panel._queryUnit = selectedUnit;
	panel._buffSerial = buffSerial;

	panel.SetHasClass("has_stacks", stacksCount > 0);

	panel._stacksLabel.text = stacksCount;

	bruteForceTextureImage(panel._image, texture)

	let buffDurationDeg
	if (
		Buffs.GetDuration(selectedUnit, buffSerial) == -1
		|| Buffs.GetDuration(selectedUnit, buffSerial) == .5
		|| Buffs.GetRemainingTime(selectedUnit, buffSerial) < 0
	) {
		buffDurationDeg = 360;
	} else {	
		buffDurationDeg = Math.max(0, 360 * (Buffs.GetRemainingTime(selectedUnit, buffSerial) / Buffs.GetDuration(selectedUnit, buffSerial)))
	}

	buffDurationDeg *= -1;
	panel._durationPanel.style.clip = "radial(50% 50%, 0deg, " + -buffDurationDeg + "deg)";
}

function SafeDeleteAsync(p){
    if(p && p.IsValid()){
        p.DeleteAsync(0)
    }
}

function InitializeChildrens(panel, isBuffs) {
	for (let i = 0; i < panel.GetChildCount(); i++) {
		if (panel[i]?.IsValid())
			panel[i].DeleteAsync(0)
	}

	panel._childrens = [];

	for (let i = 0; i < BUFF_LIST_INITIAL_CHILDRENS; i++) {
		let buffPanel = $.CreatePanel('Panel', panel, '');
		buffPanel.SetHasClass("DOTABuff", true);
		buffPanel.SetHasClass("is_debuff", !isBuffs);
		buffPanel.SetHasClass("Hidden", true);
		buffPanel.SetHasClass("is_undispellable", true); // looks better with it and no way to get this at panorama...
		buffPanel.BLoadLayout('file://{resources}/layout/custom_game/hud/dota_hud_buff.xml', false, false);
		buffPanel._image = buffPanel.FindChildTraverse("BuffImage");
		buffPanel._stacksLabel = buffPanel.FindChildTraverse("StackCount");
		buffPanel._durationPanel = buffPanel.FindChildTraverse("CircularDuration");
		buffPanel._queryUnit = -1;
		buffPanel._buffSerial = -1;
		buffPanel.SetPanelEvent("onmouseover", function() {
			$.DispatchEvent("DOTAShowBuffTooltip", buffPanel, buffPanel._queryUnit, buffPanel._buffSerial, Entities.IsEnemy(buffPanel._queryUnit));
		});
		buffPanel.SetPanelEvent("onmouseout", function() {
			$.DispatchEvent("DOTAHideBuffTooltip", buffPanel);
		})
		panel._childrens.push(buffPanel);
	}

	let buffWidth = 40;
	let buffHeightMargin = 4;
	let buffHeight = 40 + buffHeightMargin;
	let buffMargins = 4;
	let bandAidFix = 5;
	panel.style.maxWidth = ((BUFF_LIST_CHILDRENS_PER_ROW * (buffWidth + buffMargins)) + bandAidFix) + "px";
	panel.style.height = (BUFF_LIST_MAX_ROWS * buffHeight) + "px";

	$.Schedule(BUFF_LIST_TICKRATE, function() {
		UpdateBuffs(panel, isBuffs);
	});
}

(function() {
	let container = $.GetContextPanel();
	InitializeChildrens(container, container.BHasClass("customBuffs"));
})();