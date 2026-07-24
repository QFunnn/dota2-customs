--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


let base;
let tooltipManager;
let ability_tooltip;
let details;
let details_raw;

let RegisteredAbilities = {}
let RegisteredToGetInfo = {}

// Список способностей усиливаемых Torture Pipe — приходит с сервера
// (см. modifier_spell_amplify_controller.lua, NetTable globals:dot_abilities)
let TORTURE_PIPE_AMPLIFIED = {}
SubscribeAndFireNetTableByKey("globals", "dot_abilities", function(v){
	TORTURE_PIPE_AMPLIFIED = v || {}
})

// Список способностей/предметов, не повторяемых Multicast (Ogre Magi)
// (см. constants/ability_exclusions.lua → globals:multicast_exempt)
let MULTICAST_EXEMPT = {}
SubscribeAndFireNetTableByKey("globals", "multicast_exempt", function(v){
	MULTICAST_EXEMPT = v || {}
	let cnt = 0; for(let _ in MULTICAST_EXEMPT){cnt++}
	$.Msg("[ABILITY_EXCLUSIONS-JS] MULTICAST_EXEMPT updated, entries=", cnt)
})

// Список способностей/предметов, не перезаряжаемых Rearm (Tinker)
// (см. constants/ability_exclusions.lua → globals:rearm_exempt)
let REARM_EXEMPT = {}
SubscribeAndFireNetTableByKey("globals", "rearm_exempt", function(v){
	REARM_EXEMPT = v || {}
	let cnt = 0; for(let _ in REARM_EXEMPT){cnt++}
	$.Msg("[ABILITY_EXCLUSIONS-JS] REARM_EXEMPT updated, entries=", cnt)
})

// Способности с частичной перезарядкой Rearm — value = процент от полного CD,
// который снимает Rearm (integer: 40 / 50 ...). REARM_EXEMPT приоритетнее:
// если ability одновременно в обоих — Rearm её игнорирует.
// (см. constants/ability_exclusions.lua → globals:rearm_discount)
let REARM_DISCOUNT = {}
SubscribeAndFireNetTableByKey("globals", "rearm_discount", function(v){
	REARM_DISCOUNT = v || {}
	let cnt = 0; for(let _ in REARM_DISCOUNT){cnt++}
	$.Msg("[ABILITY_EXCLUSIONS-JS] REARM_DISCOUNT updated, entries=", cnt)
})

// Список способностей с моментальным убийством крипов
// (см. constants/ability_exclusions.lua → globals:insta_kill_abilities)
let INSTA_KILL_ABILITIES = {}
SubscribeAndFireNetTableByKey("globals", "insta_kill_abilities", function(v){
	INSTA_KILL_ABILITIES = v || {}
	let cnt = 0; for(let _ in INSTA_KILL_ABILITIES){cnt++}
	$.Msg("[ABILITY_EXCLUSIONS-JS] INSTA_KILL_ABILITIES updated, entries=", cnt)
})

// Айтемы, поддерживающие ALT-fast-use при покупке (см. globals:fast_use_abilities).
let FAST_USE_ABILITIES = {}
SubscribeAndFireNetTableByKey("globals", "fast_use_abilities", function(v){
	FAST_USE_ABILITIES = v || {}
	let cnt = 0; for(let _ in FAST_USE_ABILITIES){cnt++}
	$.Msg("[ABILITY_EXCLUSIONS-JS] FAST_USE_ABILITIES updated, entries=", cnt)
})

// Формы с полётом, тратящие 3% макс.маны/сек — плашка Flying Form
// (см. constants/ability_exclusions.lua → globals:flying_form_abilities)
let FLYING_FORM_ABILITIES = {}
SubscribeAndFireNetTableByKey("globals", "flying_form_abilities", function(v){
	FLYING_FORM_ABILITIES = v || {}
})

// Айтемы, у которых нужно ПРЯТАТЬ ванильную авто-стат-строку в DOTAAbilityTooltip
// (рендерится Dota автоматически из ключей _<varname> вверху тултипа под "ТИП:").
// Причина: slot-тултип эту авто-строку не показывает, поэтому стат вынесен в наш
// _Description — в craft получался дубль, теперь дубль скрываем.
// При добавлении нового айтема — просто допиши ключ.
const SUPPRESS_VANILLA_AUTO_STAT = {
	"item_unwavering_condition": true,
	"item_ballista": true,
}


// SSS Relearn Book info — для динамической подстановки в _ability_note.
// Source of truth — Lua: GIVE_SSS_RELEARN_BOOK_ROUNDS / SSS_RELEARN_BOOK_COUNT
// (см. constants/ability_exclusions.lua → PublishExclusionTables).
let SSS_RELEARN_BOOK_INFO = {}
SubscribeAndFireNetTableByKey("globals", "sss_relearn_book_info", function(v){
	SSS_RELEARN_BOOK_INFO = v || {}
	$.Msg("[SSS_RELEARN_BOOK] info updated: rounds=", SSS_RELEARN_BOOK_INFO.rounds, " count=", SSS_RELEARN_BOOK_INFO.count)
})

// Возвращает текст note с подставленными {rounds}/{count} плейсхолдерами.
// null если для ability нет специальной подстановки. Сейчас не используется
// для item_relearn_book_sss (вынесли обратно в _Description), но оставлен
// на случай если нужно будет дин. подставлять в плашку другим способностям.
function GetDynamicAbilityNoteText(ability_name, localized_note){
	return null
}

// Русское склонение по числу: 1 / 2-4 / 5+. Учитывает 11-14 как many.
// Для EN формы few и many совпадают — функция работает и для них (передаём
// одинаковые few/many в локализации).
function PluralizeByCount(n, one, few, many){
	let mod100 = n % 100
	if(mod100 >= 11 && mod100 <= 14) return many
	let mod10 = n % 10
	if(mod10 === 1) return one
	if(mod10 >= 2 && mod10 <= 4) return few
	return many
}

// Подставляет плейсхолдеры {count}/{rounds}/{sss_word} прямо в Label
// AbilityDescription тултипа — обходит ванильный рендер _Description
// (который не умеет {placeholder}-подстановки, только %varname%).
function UpdateRelearnBookDescription(ability_name){
	if(ability_name !== "item_relearn_book_sss") return
	if(!ability_tooltip) return
	let info = SSS_RELEARN_BOOK_INFO
	if(!info || info.count === undefined || info.rounds === undefined){
		$.Msg("[SSS_RELEARN_DESC] NetTable sss_relearn_book_info ещё не пришёл (info=", JSON.stringify(info), "). Подстановка пропущена.")
		return
	}

	let count = parseInt(info.count, 10)
	if(isNaN(count) || count < 1){
		$.Msg("[SSS_RELEARN_DESC] count невалидный: ", info.count)
		return
	}
	$.Msg("[SSS_RELEARN_DESC] подставляю count=", count, " rounds=", info.rounds)

	// Picks the right word form for "ability/способность".
	let formOne = $.Localize("#SSS_ABILITY_FORM_ONE")
	let formFew = $.Localize("#SSS_ABILITY_FORM_FEW")
	let formMany = $.Localize("#SSS_ABILITY_FORM_MANY")
	let word = PluralizeByCount(count, formOne, formFew, formMany)

	// Подставляем плейсхолдеры В ТЕКУЩИЙ текст лейбла (а не в полный
	// `_Description`). Движок Dota разбивает `_Description` на части
	// (header / body / note после `\n`) и рендерит их в отдельных Label'ах.
	// Если положить туда полную локализацию — note-часть отрендерится дважды
	// (один раз нами в body, второй — движком как отдельный note Label).
	// Беря panel.text как уже разрезанное движком — заменяем только body.
	let found = false
	function walk(panel){
		if(found || !panel || !panel.GetChildCount) return
		let txt = panel.text
		if(txt && typeof txt == "string" && (txt.indexOf("{count}") >= 0 || txt.indexOf("{sss_word}") >= 0 || txt.indexOf("{rounds}") >= 0)){
			panel.text = txt
				.replace(/\{count\}/g, count)
				.replace(/\{sss_word\}/g, word)
				.replace(/\{rounds\}/g, info.rounds)
			found = true
			return
		}
		let cnt = panel.GetChildCount()
		for(let i = 0; i < cnt; i++){
			walk(panel.GetChild(i))
			if(found) return
		}
	}
	walk(ability_tooltip)

	if(!found){
		$.Msg("[SSS_RELEARN_DESC] placeholder Label not found in DOTAAbilityTooltip — dumping structure:")
		DumpPanelTree(ability_tooltip, 0, 8)
	}
}

// Невидимый маркер: HTML с прозрачным цветом — рендерится в Label
// невидимо, но Label.text содержит эту строку, и мы можем найти Label
// по подстроке "__TPM__". НЕ модифицируем Label.text, чтобы не разрывать
// биндинг с dialog variable (иначе SetDialogVariable перестаёт обновлять
// Label на последующих hover'ах).
const TORTURE_PIPE_MARKER_KEY = "__TPM__"
const TORTURE_PIPE_MARKER = `<font color='#00000000'>${TORTURE_PIPE_MARKER_KEY}</font>`

// Возвращает невидимый маркер для встраивания в ability_draft_note.
// Видимая pipe-информация показывается в отдельной полоске.
function GetTorturePipeNoteHtml(){
	return TORTURE_PIPE_MARKER
}

// Находит anchor для полоски: сначала пробует AD-note Label (по маркеру —
// для способностей с custom note), потом fallback на Description Label.
function FindTorturePipeAnchor(){
	if(!ability_tooltip){return null}

	// Попытка #1: AD-note Label через маркер
	let labelByMarker = null
	function walkForMarker(panel){
		if(labelByMarker || !panel || !panel.GetChildCount){return}
		let count = panel.GetChildCount()
		for(let i = 0; i < count; i++){
			let child = panel.GetChild(i)
			if(!child){continue}
			let text = child.text
			if(text && typeof text == "string" && text.indexOf(TORTURE_PIPE_MARKER_KEY) >= 0){
				labelByMarker = child
				return
			}
			walkForMarker(child)
		}
	}
	walkForMarker(ability_tooltip)
	if(labelByMarker){return labelByMarker}

	// Попытка #2: Description Label через класс. Для innate-способностей
	// AbilityDetails может отсутствовать — тогда ищем прямо в ability_tooltip.
	let searchRoot = ability_tooltip.FindChildTraverse("AbilityDetails") || ability_tooltip

	let descCandidates = ["AbilityDescription", "AbilityDraftDescription", "AbilityDescriptionLabel", "AbilityHeaderDescription"]
	for(let name of descCandidates){
		let byId = searchRoot.FindChildTraverse(name)
		if(byId){return byId}
		let byClass = searchRoot.FindChildrenWithClassTraverse(name)
		if(byClass && byClass[0]){return byClass[0]}
	}

	// Fallback: самый длинный Label в дереве (вероятно описание)
	let longest = null
	let longestLen = 0
	function walkForLongest(panel){
		if(!panel || !panel.GetChildCount){return}
		let count = panel.GetChildCount()
		for(let i = 0; i < count; i++){
			let child = panel.GetChild(i)
			if(!child){continue}
			let text = child.text
			if(text && typeof text == "string" && text.length > longestLen){
				longest = child
				longestLen = text.length
			}
			walkForLongest(child)
		}
	}
	walkForLongest(searchRoot)
	return longest
}

function _AANoteIsHidden(panel){
	let n = panel
	while(n){
		if(n.visible === false){return true}
		if(n.BHasClass && n.BHasClass("Hidden")){return true}
		n = n.GetParent()
	}
	return false
}

// Ищет видимый AA-note контейнер. По логам он называется
// "AbilityDraftDescriptionContainer" — у современного Dota там лежит
// весь блок «Примечание Ancient Arena» (header + body).
function FindAANoteContainer(){
	if(!ability_tooltip){return null}
	let found = null
	function walk(panel){
		if(found || !panel || !panel.GetChildCount){return}
		if(panel.id === "AbilityDraftDescriptionContainer" && !_AANoteIsHidden(panel)){
			found = panel
			return
		}
		let count = panel.GetChildCount()
		for(let i = 0; i < count; i++){
			let child = panel.GetChild(i)
			if(!child){continue}
			walk(child)
			if(found){return}
		}
	}
	walk(ability_tooltip)
	return found
}

// Pipe-страйп теперь тоже через InsertNoteStrip — единый дизайн и логика
// (см. TORTURE_PIPE_STRIP_CONFIG ниже).
function InsertTorturePipeStrip(){
	InsertNoteStrip(TORTURE_PIPE_STRIP_CONFIG)
}

// === Универсальная вставка note-полоски ===
// Strip — под-блок внутри блока AA-note (parent маркер-label'а). Без фона,
// просто строка с иконкой и цветным названием + описанием — выглядит как
// дополнение к примечанию.
function InsertNoteStrip(config){
	if(!ability_tooltip){return}

	let label = FindTorturePipeAnchor()
	if(!label){return}
	let labelParent = label.GetParent()
	if(!labelParent){return}

	let existing = ability_tooltip.FindChildTraverse(config.stripId)
	if(existing){
		if(existing.GetParent() === labelParent){
			// Динамический body (e.g. REARM_PARTIAL с разным %) — обновляем
			// текст на существующей плашке без пересоздания, чтобы не
			// мигало и не сбрасывало layout.
			if(config.bodyText !== undefined){
				let bodyLbl = existing.FindChildTraverse(config.stripId + "Body")
				if(bodyLbl){ bodyLbl.text = config.bodyText }
			}
			return
		}
		if(existing.DeleteAsync){existing.DeleteAsync(0)}
	}

	let strip = $.CreatePanel("Panel", labelParent, config.stripId)
	strip.style.flowChildren = "down"
	strip.style.width = "100%"
	strip.style.height = "fit-children"
	strip.style.marginTop = "8px"
	strip.style.paddingTop = "5px"
	strip.style.borderTop = "1px solid " + config.titleColor

	// Title row — иконка + цветное название
	let titleRow = $.CreatePanel("Panel", strip, config.stripId + "TitleRow")
	titleRow.style.flowChildren = "right"
	titleRow.style.width = "100%"
	titleRow.style.height = "fit-children"
	titleRow.style.marginBottom = "1px"

	for(let i = 0; i < config.icons.length; i++){
		let iconCfg = config.icons[i]
		let panelType = iconCfg.type === "Image" ? "Panel" : iconCfg.type
		let icon = $.CreatePanel(panelType, titleRow, config.stripId + "Icon" + i)
		if(iconCfg.type === "DOTAItemImage"){
			icon.itemname = iconCfg.name
			icon.style.width = "22px"
			icon.style.height = "16px"
		}else if(iconCfg.type === "Image"){
			icon.style.width = "16px"
			icon.style.height = "16px"
			icon.style.backgroundImage = "url('" + iconCfg.src + "')"
			icon.style.backgroundSize = "contain"
			icon.style.backgroundRepeat = "no-repeat"
			icon.style.backgroundPosition = "center center"
			if(iconCfg.washColor){
				icon.style.washColor = iconCfg.washColor
			}
		}else{
			// Способности — высота как у item-иконки (16px), ширина равна высоте
			icon.abilityname = iconCfg.name
			icon.style.width = "16px"
			icon.style.height = "16px"
		}
		icon.style.marginRight = "5px"
		icon.style.align = "left center"
	}

	let titleLabel = $.CreatePanel("Label", titleRow, config.stripId + "Title")
	titleLabel.text = config.titleText
	titleLabel.style.color = config.titleColor
	titleLabel.style.fontSize = "16px"
	titleLabel.style.fontWeight = "bold"
	titleLabel.style.align = "left center"

	let bodyLabel = $.CreatePanel("Label", strip, config.stripId + "Body")
	bodyLabel.text = config.bodyText !== undefined ? config.bodyText : $.Localize(config.locKey)
	bodyLabel.style.color = config.bodyColor
	bodyLabel.style.fontSize = "15px"
	bodyLabel.style.width = "100%"
}

const MULTICAST_STRIP_CONFIG = {
	stripId: "MulticastExemptStrip",
	icons: [{type: "DOTAAbilityImage", name: "ogre_magi_multicast"}],
	titleText: "No Multicast",
	locKey: "#MULTICAST_EXEMPT_NOTE",
	titleColor: "#c89cff",
	bodyColor: "#ffffff",
}

const REARM_STRIP_CONFIG = {
	stripId: "RearmExemptStrip",
	icons: [{type: "DOTAAbilityImage", name: "tinker_rearm"}],
	titleText: "No Rearm",
	locKey: "#REARM_EXEMPT_NOTE",
	titleColor: "#f0d77a",
	bodyColor: "#ffffff",
}

// Partial Rearm — bodyText подставляется динамически (см. InsertRearmPartialStrip).
// locKey содержит плейсхолдер {percent}, который заменяется на значение из
// REARM_DISCOUNT[ability_name].
const REARM_PARTIAL_STRIP_CONFIG = {
	stripId: "RearmPartialStrip",
	icons: [{type: "DOTAAbilityImage", name: "tinker_rearm"}],
	titleText: "Partial Rearm",
	locKey: "#REARM_PARTIAL_NOTE",
	titleColor: "#f0d77a",
	bodyColor: "#ffffff",
}

const TORTURE_PIPE_STRIP_CONFIG = {
	stripId: "TorturePipeStrip",
	icons: [{type: "DOTAItemImage", name: "item_torture_pipe_2_datadriven"}],
	titleText: "Torture Pipe Upgrade",
	locKey: "#TORTURE_PIPE_AMPLIFIED_NOTE",
	titleColor: "#e6a368",
	bodyColor: "#ffffff",
}

const INSTA_KILL_STRIP_CONFIG = {
	stripId: "InstaKillStrip",
	icons: [], // временно без иконки — ванильных generic-черепов в Dota нет, кастомный PNG пока не готов
	titleText: "Insta-kill ability",
	locKey: "#INSTA_KILL_NOTE",
	titleColor: "#ff6b6b",
	bodyColor: "#ffffff",
}

const FAST_USE_STRIP_CONFIG = {
	stripId: "FastUseStrip",
	icons: [], // без иконки — заголовок Fast Use + body-текст самодостаточны
	titleText: "Fast Use",
	locKey: "#FAST_USE_NOTE",
	titleColor: "#5dd87a",  // мягкий зелёный — нейтрально-позитивный info-тон
	bodyColor: "#ffffff",
}

const FLYING_FORM_STRIP_CONFIG = {
	stripId: "FlyingFormStrip",
	icons: [], // нейтрально, без иконки (как Insta-kill/Fast Use) — нейтрального PNG крыльев пока нет.
	           // Появится ассет — вставить {type:"Image", src:"file://{images}/...vtex"}.
	titleText: "Flying Form",
	locKey: "#FLYING_FORM_NOTE",
	titleColor: "#8ec7ff",  // светло-голубой — «небо/полёт»
	bodyColor: "#ffffff",
}

function InsertMulticastExemptStrip(){ InsertNoteStrip(MULTICAST_STRIP_CONFIG) }
function InsertRearmExemptStrip(){ InsertNoteStrip(REARM_STRIP_CONFIG) }
function InsertInstaKillStrip(){ InsertNoteStrip(INSTA_KILL_STRIP_CONFIG) }
function InsertFastUseStrip(){ InsertNoteStrip(FAST_USE_STRIP_CONFIG) }
function InsertFlyingFormStrip(){ InsertNoteStrip(FLYING_FORM_STRIP_CONFIG) }

// Помощник: достаёт процент скидки и собирает финальный body-текст с подстановкой.
// Object.assign'им поверх базового config'а — не мутируем константу.
function BuildRearmPartialConfig(ability_name){
	let percent = REARM_DISCOUNT[ability_name]
	if(percent === undefined) return null
	return Object.assign({}, REARM_PARTIAL_STRIP_CONFIG, {
		bodyText: $.Localize(REARM_PARTIAL_STRIP_CONFIG.locKey).replace("{percent}", percent)
	})
}

function InsertRearmPartialStrip(ability_name){
	let cfg = BuildRearmPartialConfig(ability_name)
	if(cfg){ InsertNoteStrip(cfg) }
}

// Версия для innate-tooltip (DOTAHUDInnateStatusTooltip) — другая панель,
// отдельная логика поиска anchor'а. Дизайн идентичен InsertNoteStrip:
// блок-прямоугольник с заголовком и описанием.
function InsertInnateNoteStrip(innateTip, config){
	let oldStrip = innateTip.FindChildTraverse(config.stripId + "Innate")
	if(oldStrip){
		// Динамический body — обновляем текст без пересоздания.
		if(config.bodyText !== undefined){
			let bodyLbl = oldStrip.FindChildTraverse(config.stripId + "InnateBody")
			if(bodyLbl){ bodyLbl.text = config.bodyText }
		}
		return
	}

	let descOuter = innateTip.FindChildTraverse("AbilityDescriptionOuterContainer")
	let parent = descOuter ? descOuter.GetParent() : null
	if(!parent){return}

	let strip = $.CreatePanel("Panel", parent, config.stripId + "Innate")
	strip.style.flowChildren = "down"
	strip.style.width = "100%"
	strip.style.height = "fit-children"
	strip.style.marginTop = "8px"
	strip.style.paddingTop = "5px"
	strip.style.borderTop = "1px solid " + config.titleColor

	let titleRow = $.CreatePanel("Panel", strip, config.stripId + "InnateTitleRow")
	titleRow.style.flowChildren = "right"
	titleRow.style.width = "100%"
	titleRow.style.height = "fit-children"
	titleRow.style.marginBottom = "1px"

	for(let i = 0; i < config.icons.length; i++){
		let iconCfg = config.icons[i]
		let panelType = iconCfg.type === "Image" ? "Panel" : iconCfg.type
		let icon = $.CreatePanel(panelType, titleRow, config.stripId + "InnateIcon" + i)
		if(iconCfg.type === "DOTAItemImage"){
			icon.itemname = iconCfg.name
			icon.style.width = "22px"
			icon.style.height = "16px"
		}else if(iconCfg.type === "Image"){
			icon.style.width = "16px"
			icon.style.height = "16px"
			icon.style.backgroundImage = "url('" + iconCfg.src + "')"
			icon.style.backgroundSize = "contain"
			icon.style.backgroundRepeat = "no-repeat"
			icon.style.backgroundPosition = "center center"
			if(iconCfg.washColor){
				icon.style.washColor = iconCfg.washColor
			}
		}else{
			icon.abilityname = iconCfg.name
			icon.style.width = "16px"
			icon.style.height = "16px"
		}
		icon.style.marginRight = "5px"
		icon.style.align = "left center"
	}

	let titleLabel = $.CreatePanel("Label", titleRow, config.stripId + "InnateTitle")
	titleLabel.text = config.titleText
	titleLabel.style.color = config.titleColor
	titleLabel.style.fontSize = "16px"
	titleLabel.style.fontWeight = "bold"
	titleLabel.style.align = "left center"

	let bodyLabel = $.CreatePanel("Label", strip, config.stripId + "InnateBody")
	bodyLabel.text = config.bodyText !== undefined ? config.bodyText : $.Localize(config.locKey)
	bodyLabel.style.color = config.bodyColor
	bodyLabel.style.fontSize = "15px"
	bodyLabel.style.width = "100%"

	if(parent.MoveChildBefore){
		let children = parent.Children()
		let descIdx = -1
		for(let i = 0; i < children.length; i++){
			if(children[i] === descOuter){descIdx = i; break}
		}
		if(descIdx >= 0 && descIdx + 1 < children.length){
			for(let j = descIdx + 1; j < children.length; j++){
				if(children[j] !== strip){
					parent.MoveChildBefore(strip, children[j])
					break
				}
			}
		}
	}
}

//Ожидание появления тултипа в первый раз
function Init() {
	if (!base) {
		base = GetDotaHud();
	}
	if (!tooltipManager) {
		tooltipManager = base.FindChildTraverse("Tooltips");
	}

	// Запускаем мониторинг innate-тултипа независимо от готовности обычного.
	// Innate-tooltip не диспатчит DOTAShowAbilityTooltip* events — приходится
	// поллить его текущий ability через InnateImage.abilityname.
	StartInnateTooltipMonitor()

	ability_tooltip = tooltipManager.FindChildTraverse("DOTAAbilityTooltip");
	if (!ability_tooltip) {
		$.Schedule(0.3, Init);
		return;
	}
	let trList = ability_tooltip.FindChildrenWithClassTraverse("TooltipRow")
	details_raw = trList && trList[0];
	if(!details_raw){
		$.Schedule(0.3, Init);
		return;
	}
	details = details_raw.FindChildTraverse("AbilityDetails");
}

// === Innate-tooltip support ===
// DOTAHUDInnateStatusTooltip — отдельная панель, которая не диспатчит
// DOTAShowAbilityTooltip*-события. Чтобы показать на ней полоску Pipe,
// поллим InnateImage.abilityname и при смене обновляем полоску.
let innateMonitorStarted = false
let lastInnateAbilityName = ""

function StartInnateTooltipMonitor(){
	if(innateMonitorStarted){return}
	innateMonitorStarted = true
	PollInnateTooltip()
}

function PollInnateTooltip(){
	$.Schedule(0.3, PollInnateTooltip)
	if(!tooltipManager){return}

	let innateTip = tooltipManager.FindChildTraverse("DOTAHUDInnateStatusTooltip")
	if(!innateTip){return}

	let innateImg = innateTip.FindChildTraverse("InnateImage")
	if(!innateImg){return}

	// Сначала пробуем property abilityname, если она не работает — берём
	// ability через contextEntityIndex.
	let name = innateImg.abilityname || ""
	if(!name && innateImg.contextEntityIndex && innateImg.contextEntityIndex !== -1){
		try {
			name = Abilities.GetAbilityName(innateImg.contextEntityIndex) || ""
		} catch(e) { name = "" }
	}

	if(name === lastInnateAbilityName){return}
	lastInnateAbilityName = name

	UpdateInnateTorturePipeStrip(innateTip, name)
	UpdateInnateExemptionStrips(innateTip, name)
}

// Управляет полосками Multicast/Rearm exemption на innate-tooltip'е аналогично
// UpdateInnateTorturePipeStrip — добавляет или удаляет в зависимости от того,
// есть ли innate-ability в соответствующем NetTable-списке.
function UpdateInnateExemptionStrips(innateTip, ability_name){
	let mcExempt = ability_name && MULTICAST_EXEMPT[ability_name] != undefined
	let rmExempt = ability_name && REARM_EXEMPT[ability_name] != undefined
	let rmPartial = ability_name && REARM_DISCOUNT[ability_name] != undefined && !rmExempt

	let oldMc = innateTip.FindChildTraverse("MulticastExemptStripInnate")
	let oldRm = innateTip.FindChildTraverse("RearmExemptStripInnate")
	let oldRp = innateTip.FindChildTraverse("RearmPartialStripInnate")

	if(mcExempt){
		if(!oldMc){InsertInnateNoteStrip(innateTip, MULTICAST_STRIP_CONFIG)}
	}else if(oldMc && oldMc.DeleteAsync){oldMc.DeleteAsync(0)}

	if(rmExempt){
		if(!oldRm){InsertInnateNoteStrip(innateTip, REARM_STRIP_CONFIG)}
	}else if(oldRm && oldRm.DeleteAsync){oldRm.DeleteAsync(0)}

	if(rmPartial){
		let cfg = BuildRearmPartialConfig(ability_name)
		if(cfg){ InsertInnateNoteStrip(innateTip, cfg) }
	}else if(oldRp && oldRp.DeleteAsync){oldRp.DeleteAsync(0)}
}

function UpdateInnateTorturePipeStrip(innateTip, ability_name){
	let amplified = ability_name && TORTURE_PIPE_AMPLIFIED[ability_name] != undefined
	let oldStrip = innateTip.FindChildTraverse("TorturePipeStripInnate")

	if(!amplified){
		if(oldStrip && oldStrip.DeleteAsync){oldStrip.DeleteAsync(0)}
		return
	}
	if(oldStrip){return}
	InsertInnateNoteStrip(innateTip, TORTURE_PIPE_STRIP_CONFIG)
}

function PortraitUnitChanged() {
	const unit = Players.GetLocalPlayerPortraitUnit();
	if (!Entities.IsRealHero(unit)) {
		return;
	}
	for (i = 0; i < Entities.GetAbilityCount(unit); i++) {
		const ability = Entities.GetAbility(unit, i);
		if (ability && ability != -1 && !Abilities.IsHidden(ability)) {
			const ability_name = Abilities.GetAbilityName(ability);
			if (ability_name.match("special_bonus")) {
				continue;
			}
			RegisterHoverableAbility({
				ability_name: ability_name,
			});
		}
	}
}
$.RegisterForUnhandledEvent("DOTAShowAbilityTooltip", function(panel, ability_name){
	CheckAndUpdateTooltip(panel, ability_name)
});
$.RegisterForUnhandledEvent("DOTAShowAbilityTooltipForEntityIndex", function(panel, ability_name, entindex){
	CheckAndUpdateTooltip(panel, ability_name)
});
$.RegisterForUnhandledEvent("DOTAShowAbilityShopItemTooltip", function(panel, ability_name, entindex){
	CheckAndUpdateTooltip(panel, ability_name)
});
$.RegisterForUnhandledEvent("DOTAShowAbilityInventoryItemTooltip", function(panel, entindex, slot){
	let Slot = Entities.GetItemInSlot( entindex, slot )
	if(Slot != -1){
		let ability_name = Abilities.GetAbilityName( Slot )
		// $.Msg("[PIPE-NEUTRAL-DIAG] DOTAShowAbilityInventoryItemTooltip: ", ability_name, " slot=", slot)
		CheckAndUpdateTooltip(panel, ability_name)
	} else {
		// $.Msg("[PIPE-NEUTRAL-DIAG] DOTAShowAbilityInventoryItemTooltip: slot=", slot, " is empty")
	}
});

// Tooltip нейтрал-предмета (в слоте) — отдельное событие и отдельная панель,
// не DOTAAbilityTooltip. Перехватываем здесь.
$.RegisterForUnhandledEvent("DOTAShowNeutralItemTooltip", function(panel, activeID, passiveID, tier, level){
	let activeName = activeID && activeID !== -1 ? Abilities.GetAbilityName(activeID) : null
	let passiveName = passiveID && passiveID !== -1 ? Abilities.GetAbilityName(passiveID) : null
	// $.Msg("[PIPE-NEUTRAL-DIAG] DOTAShowNeutralItemTooltip: active=", activeName, " passive=", passiveName, " tier=", tier, " level=", level)

	// Diagnostic: поищем неутрал-tooltip-панель в DotaHud
	let hud = GetDotaHud ? GetDotaHud() : null
	if(hud){
		let candidates = ["DOTAHUDNeutralItemTooltip", "NeutralItemTooltip", "DOTANeutralItemTooltip"]
		for(let id of candidates){
			let p = hud.FindChildTraverse(id)
			// $.Msg("[PIPE-NEUTRAL-DIAG]   tried ", id, ": found=", (p != null))
		}
	}
});

// DIAG: мониторим какие tooltip-узлы становятся видимыми при hover на нейтрал-слот.
// Запускается после Init (нужен tooltipManager).
let NEUTRAL_DIAG_STARTED = false
function StartNeutralDiag(){
	return // [PIPE-NEUTRAL-DIAG] диагностика отключена (флудила консоль каждые 0.3с)
	if(NEUTRAL_DIAG_STARTED || !tooltipManager){
		if(!NEUTRAL_DIAG_STARTED){$.Schedule(0.5, StartNeutralDiag)}
		return
	}
	NEUTRAL_DIAG_STARTED = true
	let knownIds = {}
	let prevAlive = ""
	// $.Msg("[PIPE-NEUTRAL-DIAG] === tooltipManager children list ===")
	let cnt = tooltipManager.GetChildCount()
	for(let i = 0; i < cnt; i++){
		let c = tooltipManager.GetChild(i)
		if(c){
			// $.Msg("[PIPE-NEUTRAL-DIAG]   [", i, "] id='", c.id, "'")
			knownIds[c.id || ("#" + i)] = true
		}
	}
	function poll(){
		if(!tooltipManager){$.Schedule(0.3, poll); return}
		let cnt2 = tooltipManager.GetChildCount()
		for(let i = 0; i < cnt2; i++){
			let c = tooltipManager.GetChild(i)
			if(!c){continue}
			let id = c.id || ("#" + i)
			if(!knownIds[id]){
				// $.Msg("[PIPE-NEUTRAL-DIAG] NEW PANEL APPEARED: ", id)
				knownIds[id] = true
			}
		}
		let alive = []
		for(let i = 0; i < cnt2; i++){
			let c = tooltipManager.GetChild(i)
			if(!c){continue}
			if(c.visible !== false && !(c.BHasClass && c.BHasClass("Hidden"))){
				alive.push(c.id || ("#" + i))
			}
		}
		let cur = alive.join(",")
		if(cur !== prevAlive){
			// $.Msg("[PIPE-NEUTRAL-DIAG] alive: [", cur, "]")
			prevAlive = cur
		}
		$.Schedule(0.3, poll)
	}
	poll()
}
$.Schedule(2, StartNeutralDiag)

let CustomRuneScheduler = -1

$.RegisterForUnhandledEvent("DOTAShowDroppedItemTooltip", function(panel, x, y, itemName){
	// $.Msg(x, " ", y)
	if(itemName.includes("custom_rune")){
		CustomRuneScheduler = $.Schedule(0.01, function(){
			$.DispatchEvent( "DOTAHideDroppedItemTooltip", panel )
			$.DispatchEvent( "DOTAHideAbilityTooltip", panel )

			$.DispatchEvent(
				"UIShowCustomLayoutParametersTooltip",
				panel,
				"CustomRuneTooltip",
				"file://{resources}/layout/custom_game/custom_rune_tooltip.xml",
				`name=${itemName}&x=${x}&y=${y}`
			);
		})
	}
});

$.RegisterForUnhandledEvent("DOTAHideDroppedItemTooltip", function(panel){
	// if(itemName.includes("custom_rune")){
		if(CustomRuneScheduler != -1){
			$.CancelScheduled(CustomRuneScheduler)
			CustomRuneScheduler = -1
		}
		$.DispatchEvent("UIHideCustomLayoutTooltip", panel, "CustomRuneTooltip");
	// }
});

function CheckAndUpdateTooltip(panel, ability_name){
	let CustomNoteLocToken = `#DOTA_Tooltip_ability_${ability_name}_ability_note`
	let ScepterLocToken = `#DOTA_Tooltip_ability_${ability_name}_scepter_description`
	let ShardLocToken = `#DOTA_Tooltip_ability_${ability_name}_shard_description`
	let CustomNoteLoc = $.Localize(CustomNoteLocToken)
	let ScepterLoc = $.Localize(ScepterLocToken)
	let ShardLoc = $.Localize(ShardLocToken)

	// Динамическая подстановка плейсхолдеров (см. GetDynamicAbilityNoteText).
	let dynamicNote = GetDynamicAbilityNoteText(ability_name, CustomNoteLoc)
	if(dynamicNote !== null){ CustomNoteLoc = dynamicNote }

	let bHasCustomNoteLoc = CustomNoteLoc != CustomNoteLocToken && CustomNoteLoc != ""
	let bHasScepterLoc = ScepterLoc != ScepterLocToken && ScepterLoc != ""
	let bHasShardLoc = ShardLoc != ShardLocToken && ShardLoc != ""
	let bIsTorturePipeAmplified = TORTURE_PIPE_AMPLIFIED[ability_name] != undefined
	let bIsMulticastExempt = MULTICAST_EXEMPT[ability_name] != undefined
	let bIsRearmExempt = REARM_EXEMPT[ability_name] != undefined
	let bIsRearmPartial = REARM_DISCOUNT[ability_name] != undefined && !bIsRearmExempt
	let bIsInstaKill = INSTA_KILL_ABILITIES[ability_name] != undefined
	let bIsFastUse = FAST_USE_ABILITIES[ability_name] != undefined
	let bIsFlyingForm = FLYING_FORM_ABILITIES[ability_name] != undefined

	let bHasInfo = bHasCustomNoteLoc || bHasScepterLoc || bHasShardLoc || bIsTorturePipeAmplified || bIsMulticastExempt || bIsRearmExempt || bIsRearmPartial || bIsInstaKill || bIsFastUse || bIsFlyingForm

	if(bHasInfo){
		if(!RegisteredAbilities[ability_name] && !RegisteredToGetInfo[ability_name]){
			RegisteredToGetInfo[ability_name] = true
			GameEvents.SendCustomGameEventToServer( "key_values_get_ability_info", {ability_name: ability_name} )
		}else if(RegisteredAbilities[ability_name]){
			UpdateTooltip(ability_name)
		}else if(bIsTorturePipeAmplified || bIsMulticastExempt || bIsRearmExempt || bIsRearmPartial || bIsInstaKill || bIsFastUse || bIsFlyingForm){
			UpdateTooltip(ability_name)
		}
	}else{
		UpdateTooltip(ability_name)
	}
}

function RegisterAbility(event){
	if(!RegisteredAbilities[event.ability_name]){
		RegisteredAbilities[event.ability_name] = event.values

		UpdateTooltip(event.ability_name)
	}
}

function UpdateTooltip(AbilityName){
	ability_tooltip = tooltipManager.FindChildTraverse("DOTAAbilityTooltip");
	if(ability_tooltip){
		details = ability_tooltip.FindChildTraverse("AbilityDetails");

		// Определяем заранее — нужно и внутри if(details), и снаружи (для innate-тултипов,
		// у которых AbilityDetails может отсутствовать).
		let bIsTorturePipeAmplified = TORTURE_PIPE_AMPLIFIED[AbilityName] != undefined
		let bIsMulticastExempt = MULTICAST_EXEMPT[AbilityName] != undefined
		let bIsRearmExempt = REARM_EXEMPT[AbilityName] != undefined
		let bIsRearmPartial = REARM_DISCOUNT[AbilityName] != undefined && !bIsRearmExempt
		let bIsInstaKill = INSTA_KILL_ABILITIES[AbilityName] != undefined
		let bIsFastUse = FAST_USE_ABILITIES[AbilityName] != undefined
		let bIsFlyingForm = FLYING_FORM_ABILITIES[AbilityName] != undefined

		if(details){
			details.SetHasClass("AbilityDraftDetails", RegisteredAbilities[AbilityName] != undefined)

			let CustomNoteLocToken = `#DOTA_Tooltip_ability_${AbilityName}_ability_note`
			let ScepterLocToken = `#DOTA_Tooltip_ability_${AbilityName}_scepter_description`
			let ShardLocToken = `#DOTA_Tooltip_ability_${AbilityName}_shard_description`
			let CustomNoteLoc = $.Localize(CustomNoteLocToken)
			let ScepterLoc = $.Localize(ScepterLocToken)
			let ShardLoc = $.Localize(ShardLocToken)

			let dynamicNote = GetDynamicAbilityNoteText(AbilityName, CustomNoteLoc)
			if(dynamicNote !== null){ CustomNoteLoc = dynamicNote }

			let bHasCustomNoteLoc = CustomNoteLoc != CustomNoteLocToken && CustomNoteLoc != ""
			let bHasScepterLoc = ScepterLoc != ScepterLocToken && ScepterLoc != ""
			let bHasShardLoc = ShardLoc != ShardLocToken && ShardLoc != ""

			// Для способностей с любой из плашек (Pipe / Multicast / Rearm) —
			// активируем AbilityDraftDetails чтобы DOM-структура AA-note рендерилась
			// (нужно для anchor'инга через невидимый маркер). HasADNote НЕ форсим —
			// если у способности нет своего custom_note, ячейка AA-note остаётся
			// скрытой, и плашка отображается на её месте.
			let bAnyStripActive = bIsTorturePipeAmplified || bIsMulticastExempt || bIsRearmExempt || bIsRearmPartial || bIsInstaKill || bIsFastUse || bIsFlyingForm
			if(bAnyStripActive && !details.BHasClass("AbilityDraftDetails")){
				details.SetHasClass("AbilityDraftDetails", true)
			}

			details.SetHasClass("HasADNote", bHasCustomNoteLoc)
			details.SetHasClass("HasScepterDetails", bHasScepterLoc)
			details.SetHasClass("HasShardDetails", bHasShardLoc)

			$.Schedule(0, function(){
				FixDescs()
			})

			// Маркер для FindStripSiblingSection инжектится ВСЕГДА, если есть
			// custom note + любая плашка — независимо от RegisteredAbilities.
			// Раньше инжект был внутри if(Registered…) и пропускался для
			// способностей без custom values → walk-up падал на описание и
			// strip уходил вниз тултипа. Здесь добавляем маркер при пустых
			// Stats; ReplaceSpecialValues с пустым Stats просто не находит
			// никаких %placeholder%, текст остаётся как есть.
			{
				let bAnyStripForMarker = bIsTorturePipeAmplified || bIsMulticastExempt || bIsRearmExempt || bIsRearmPartial || bIsInstaKill || bIsFastUse || bIsFlyingForm
				if(bHasCustomNoteLoc && bAnyStripForMarker){
					let noteText = CustomNoteLoc + GetTorturePipeNoteHtml()
					details.SetDialogVariable("ability_draft_note", noteText)
				}
			}

			if(RegisteredAbilities[AbilityName]){
				let Stats = {}
				for (const ValueName in RegisteredAbilities[AbilityName]) {
					let current_value = RegisteredAbilities[AbilityName][ValueName] || 0
					let with_scepter = 0
					let with_shard = 0
					if(typeof current_value == "object"){
						if(current_value.special_bonus_scepter){
							let ScepterBonus = current_value.special_bonus_scepter
							let ScepterNum = parseFloat(ScepterBonus.substring(1))
							with_scepter = current_value.value
							let bIsPlus = ScepterBonus.charAt(0) == "+"
							let bIsMinus = ScepterBonus.charAt(0) == "-"
							let bIsEqual = ScepterBonus.charAt(0) == "="
							if(bIsPlus)
								with_scepter+= ScepterNum

							if(bIsMinus)
								with_scepter-= ScepterNum

							if(bIsEqual)
								with_scepter = ScepterNum

							if(!bIsPlus && !bIsMinus && !bIsEqual)
								with_scepter = parseFloat(ScepterBonus)
						}else if(current_value.RequiresScepter){
							with_scepter = current_value.value || 0
						}
						if(current_value.special_bonus_shard){
							let ShardBonus = current_value.special_bonus_shard
							let ShardNum = parseFloat(ShardBonus.substring(1))
							with_shard = current_value.value
							let bIsPlus = ShardBonus.charAt(0) == "+"
							let bIsMinus = ShardBonus.charAt(0) == "-"
							let bIsEqual = ShardBonus.charAt(0) == "="
							if(bIsPlus)
								with_shard+= ShardNum

							if(bIsMinus)
								with_shard-= ShardNum

							if(bIsEqual)
								with_shard = ShardNum

							if(!bIsPlus && !bIsMinus && !bIsEqual)
								with_shard = parseFloat(ShardBonus)
						}else if(current_value.RequiresShard){
							with_shard = current_value.value || 0
						}
						current_value = current_value.value || 0
					}

					Stats[ValueName] = {
						value: current_value,
						scepter: with_scepter,
						shard: with_shard
					}
				}

				// Маркер инжектится при ЛЮБОЙ из трёх плашек чтобы
				// FindStripSiblingSection нашёл AA-note секцию как anchor.
				// Маркер невидим, не меняет визуал AA-note. HasADNote НЕ форсим —
				// если у способности нет своего custom_note, AA-note ячейка
				// остаётся скрытой, и плашка просто оказывается ниже описания.
				let bAnyStripForMarker = bIsTorturePipeAmplified || bIsMulticastExempt || bIsRearmExempt || bIsRearmPartial || bIsInstaKill || bIsFastUse || bIsFlyingForm
				if(bHasCustomNoteLoc){
					let noteText = ReplaceSpecialValues(Stats, CustomNoteLoc, "value")
					if(bAnyStripForMarker){
						noteText += GetTorturePipeNoteHtml()
					}
					details.SetDialogVariable("ability_draft_note", noteText)
				}else if(bAnyStripForMarker){
					details.SetDialogVariable("ability_draft_note", GetTorturePipeNoteHtml())
				}

				if(bHasScepterLoc){
					details.SetDialogVariable("ability_draft_scepter", ReplaceSpecialValues(Stats, ScepterLoc, "scepter"))
				}

				if(bHasShardLoc){
					details.SetDialogVariable("ability_draft_shard", ReplaceSpecialValues(Stats, ShardLoc, "shard"))
				}
			}
			// Для случая "no custom note + amplified" не трогаем ability_draft_note
			// и не активируем HasADNote — полоска ставится через description anchor
		}

		// Multicast/Rearm exemption strips — управляются независимо от Torture Pipe.
		if(bIsMulticastExempt){
			$.Schedule(0.05, InsertMulticastExemptStrip)
		}else{
			let strip = ability_tooltip.FindChildTraverse("MulticastExemptStrip")
			if(strip && strip.DeleteAsync){strip.DeleteAsync(0)}
		}

		if(bIsRearmExempt){
			$.Schedule(0.05, InsertRearmExemptStrip)
		}else{
			let strip = ability_tooltip.FindChildTraverse("RearmExemptStrip")
			if(strip && strip.DeleteAsync){strip.DeleteAsync(0)}
		}

		if(bIsRearmPartial){
			// AbilityName замыкаем в локальную переменную для Schedule-замыкания.
			let CapturedAbilityName = AbilityName
			$.Schedule(0.05, function(){ InsertRearmPartialStrip(CapturedAbilityName) })
		}else{
			let strip = ability_tooltip.FindChildTraverse("RearmPartialStrip")
			if(strip && strip.DeleteAsync){strip.DeleteAsync(0)}
		}

		// Pipe-strip вставляется/удаляется независимо от наличия AbilityDetails —
		// у innate-тултипов этой панели может не быть, но полоска всё равно нужна.
		if(bIsTorturePipeAmplified){
			$.Schedule(0.05, InsertTorturePipeStrip)
		}else{
			// Способность не усиливается — удаляем полоску полностью.
			// visibility:collapse недостаточно: panel с DOTAItemImage детьми
			// может всё равно занимать место в layout родителя (тултип-singleton
			// переиспользуется для всех способностей).
			let strip = ability_tooltip.FindChildTraverse("TorturePipeStrip")
			if(strip && strip.DeleteAsync){strip.DeleteAsync(0)}
		}

		if(bIsInstaKill){
			$.Schedule(0.05, InsertInstaKillStrip)
		}else{
			let strip = ability_tooltip.FindChildTraverse("InstaKillStrip")
			if(strip && strip.DeleteAsync){strip.DeleteAsync(0)}
		}

		if(bIsFastUse){
			$.Schedule(0.05, InsertFastUseStrip)
		}else{
			let strip = ability_tooltip.FindChildTraverse("FastUseStrip")
			if(strip && strip.DeleteAsync){strip.DeleteAsync(0)}
		}

		if(bIsFlyingForm){
			$.Schedule(0.05, InsertFlyingFormStrip)
		}else{
			let strip = ability_tooltip.FindChildTraverse("FlyingFormStrip")
			if(strip && strip.DeleteAsync){strip.DeleteAsync(0)}
		}

		// Подавление ванильной авто-стат-строки для айтемов из SUPPRESS_VANILLA_AUTO_STAT.
		// Через $.Schedule — Dota дорисовывает auto-stat row после нашего render-кадра.
		let CapturedAbilityName2 = AbilityName
		$.Schedule(0.05, function(){ UpdateVanillaAutoStatSuppression(CapturedAbilityName2) })

		// Подстановка плейсхолдеров в _Description для item_relearn_book_sss.
		$.Schedule(0.05, function(){ UpdateRelearnBookDescription(CapturedAbilityName2) })
	}
}

// Прячет/восстанавливает ванильную auto-stat секцию в DOTAAbilityTooltip.
// Тултип-singleton переиспользуется на разных hover'ах. Хранилище: {panel, prev}
// чтобы при restore вернуть ИСХОДНОЕ значение visibility, а не угадывать
// "visible"/"collapse". Раньше пробовали style.visibility = "" — Panorama
// бросает "Failed to parse style value for visibility".
let _suppressedAutoStatPanels = []

function UpdateVanillaAutoStatSuppression(AbilityName){
	if(!ability_tooltip) return

	// 1. Восстанавливаем ранее спрятанные панели в их исходное состояние.
	for(let entry of _suppressedAutoStatPanels){
		if(!entry || !entry.panel) continue
		try {
			// prev может быть "visible"/"collapse"/undefined. Для undefined ставим
			// "visible" — это безопаснее чем "" (Panorama не парсит пустую строку).
			entry.panel.style.visibility = entry.prev || "visible"
		} catch(e){ $.Msg("[AUTO_STAT_SUPPRESS restore err] ", String(e)) }
	}
	_suppressedAutoStatPanels = []

	// 2. Если айтем в suppress-списке, прячем кандидатов и сохраняем ссылки.
	if(SUPPRESS_VANILLA_AUTO_STAT[AbilityName] !== true) return

	let candidates = [
		"AbilityHeaderDetails",
		"AbilityValueDetails",
		"AbilityValuesScroll",
		"AbilityStats",
		"AbilityValues",
		"AbilityAttributes",
	]

	let foundAny = false
	for(let id of candidates){
		let panel = ability_tooltip.FindChildTraverse(id)
		if(!panel) continue
		foundAny = true
		let prev = panel.style.visibility
		panel.style.visibility = "collapse"
		_suppressedAutoStatPanels.push({panel: panel, prev: prev})
	}

	if(!foundAny){
		$.Msg("[AUTO_STAT_SUPPRESS] ", AbilityName, ": NO candidate panel found — dumping DOTAAbilityTooltip structure:")
		DumpPanelTree(ability_tooltip, 0, 6)
	}
}

// Рекурсивный дамп дерева панели — id + текст-сниппет каждого узла.
// Используется для диагностики, чтобы найти точное имя panel ID.
function DumpPanelTree(panel, depth, maxDepth){
	if(!panel || depth > maxDepth) return
	let pad = "  ".repeat(depth)
	let snippet = ""
	if(panel.text && typeof panel.text == "string"){
		snippet = " text=\"" + panel.text.substring(0, 60).replace(/\n/g, "\\n") + "\""
	}
	$.Msg(pad, "id=", panel.id || "(none)", snippet)
	if(panel.GetChildCount){
		let cnt = panel.GetChildCount()
		for(let i = 0; i < cnt; i++){
			DumpPanelTree(panel.GetChild(i), depth + 1, maxDepth)
		}
	}
}

function ReplaceSpecialValues(Tokens, LocalizedText, Type){

	for (const ValueName in Tokens) {
		let Values = Tokens[ValueName]
		let value = Values[Type]
		LocalizedText = LocalizedText.replace(new RegExp(`%${ValueName}%`, "g"), `<font class='GameplayVariable'>${value}</font>`)

		// Ванильный синтаксис: %bonus_X% — дельта между scepter/shard-значением и базой
		// (например %bonus_rot_radius% = "+200" если rot_radius 250 → 450 с скипетром).
		// Без этого описания scepter/shard не подставляли значения, оставляя литералы.
		if(Type === "scepter" || Type === "shard"){
			let delta = (Values[Type] || 0) - (Values.value || 0)
			if(delta !== 0){
				let sign = delta > 0 ? "+" : ""
				LocalizedText = LocalizedText.replace(new RegExp(`%bonus_${ValueName}%`, "g"), `<font class='GameplayVariable'>${sign}${delta}</font>`)
			}
		}
	}

	LocalizedText = LocalizedText.replace(new RegExp(`%%`, "g"), `<font class='GameplayVariable'>%</font>`)

	return LocalizedText
}

function FixDescs(){
	if(details){
		let Entity = Players.GetLocalPlayerPortraitUnit()
		let ScepterDesc = details.FindChildTraverse("ScepterUpgradeDescription")
		let ShardDesc = details.FindChildTraverse("ShardUpgradeDescription")
		if(ScepterDesc && ShardDesc){
			if(ScepterDesc.BHasClass("NoUpgrade") && Entities.HasScepter( Entity )){
				ScepterDesc.AddClass("Hidden")
			}
			if(ShardDesc.BHasClass("NoUpgrade") && HasModifier(Entity, "modifier_item_aghanims_shard")){
				ShardDesc.AddClass("Hidden")
			}
		}
	}
}

GameEvents.Subscribe("key_values_send_ability_info", RegisterAbility);

Init()