--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


const mainQuestsPanel = $("#MainQuests")
const additionalQuestsPanel = $("#AdditionalQuests")
const questsDividerLine = $("#QuestsDividerLine")
const questMsgPanel = $("#QuestMsgPanel")

const questPanels = {}
const questsData = {}

function startQuest(questData, suppressQuestStatus) {
	const { id, name, description, target, goal, type, priority, rewards } = questData

	if (questPanels[id]) {
		return
	}
	// if (questPanels[id]) {
	// 	delete questsData[id]
	// 	questPanels[id].DeleteAsync(0)
	// }
	
	const panel = $.CreatePanel("Panel", priority == "main" ? mainQuestsPanel : additionalQuestsPanel, "")

	panel.BLoadLayoutSnippet("Quest")

	const questPriorityMark = panel.FindChildrenWithClassTraverse("QuestPriorityMark")[0]
	if (priority === "main") {
		questPriorityMark.text = "!"
		questPriorityMark.SetHasClass("MainQuest", true)
	} else {
		questPriorityMark.text = "?"
		questPriorityMark.SetHasClass("AdditionalQuest", true)
	}

	panel.FindChildrenWithClassTraverse("QuestHeader")[0].text = $.Localize(`#${name}`)
	
	let completeDescription = type === "bring" ? `${$.Localize(`#${description}`)} ${$.Localize(`#DOTA_Tooltip_ability_${target}`)}` : $.Localize(`#${description}`)
	
	panel.FindChildrenWithClassTraverse("QuestDescriptionLabel")[0].text = completeDescription

	panel.FindChildrenWithClassTraverse("QuestGoldRewardLabel")[0].text = rewards.gold
	panel.FindChildrenWithClassTraverse("QuestExpRewardLabel")[0].text = rewards.exp

	panel.questId = id

	questPanels[id] = panel
	
	questsData[id] = {
		priority,
		id,
		name,
		type,
		completeDescription,
		expireAt: questData.expireAt,
		goal,
		current: 0,
		rewards,
	}

	initQuestTimer(id)
	
	refreshQuestHeader(id)
	refreshQuestPanelDescription(id)

	handleQuestsDividerVisibility()

	if (!suppressQuestStatus) {
		showQuestStatusText(null, description)
	}
}

function initQuestTimer(questId) {
	const questData = questsData[questId]
	if (!questData) return
	if (questData.expireAt == null) return

	function loop() {
		const questData = questsData[questId]
		if (!questData) return

		refreshQuestHeader(questId)

		$.Schedule(1, loop)
	}

	loop()
}

function prettyDuration(time) {
	if (time <= 0)
		return "0:00"

	return `${Math.floor(time / 60)}:${String(Math.floor(time) % 60).padStart(2, "0")}`
}

function refreshQuestHeader(questId) {
	const questPanel = questPanels[questId]
	if (!questPanel) return

	const questData = questsData[questId]
	if (!questData) return

	let text = $.Localize(`#${questData.name}`)

	if (questData.expireAt) {
		text += ` <font color="#f00">${prettyDuration(questData.expireAt - Game.GetGameTime())}</font>`
	}

	questPanel.FindChildrenWithClassTraverse("QuestHeader")[0].text = text
}

function refreshQuestPanelDescription(questId) {
	const questPanel = questPanels[questId]
	if (!questPanel) return

	const questData = questsData[questId]
	if (!questData) return

	if (!["kill", "collect"].includes(questData.type)) return

	questPanel.FindChildrenWithClassTraverse("QuestDescriptionLabel")[0].text = `(${questData.current}/${questData.goal}) ${questData.completeDescription}`
}

function handleQuestsDividerVisibility() {
	if (!questsDividerLine) return

	if (mainQuestsPanel.GetChildCount() > 0 && additionalQuestsPanel.GetChildCount() > 0) {
		questsDividerLine.visible = true
	} else {
		questsDividerLine.visible = false
	}
}

function onQuestUpdate({id: questId, current}) {
	const questData = questsData[questId]
	if (!questData) return

	questData.current = current

	refreshQuestPanelDescription(questId)
}

function onQuestRemove({num: questId, status, description}) {
	const questPanel = questPanels[questId]
	if (questPanel) {
		questPanel.DeleteAsync(0)
		delete questPanels[questId]
	}
	if (questsData[questId])
		delete questsData[questId]
	
	showQuestStatusText(status, description)
}

function onRequestQuestsResponce({data}) {
	for (const i in data) {
		const quest = data[i]
		
		startQuest(quest, true)
		onQuestUpdate({
			id: quest.id,
			current: quest.current ?? 0,
		})
	}
}

function showQuestStatusText(status, description) {
	const lineContainer = $.CreatePanel("Panel", questMsgPanel, "");
	lineContainer.AddClass("QuestLineContainer");

	let statusClass = "";
	let questStatus = "";

	switch (status) {
		case "success": 
			statusClass = "SuccessStatus"; 
			questStatus = "success_quest";
			break;
		case "fail": 
			statusClass = "FailStatus"; 
			questStatus = "fail_quest";
			break;
		default: 
			statusClass = "NewStatus"; 
			questStatus = "new_quest";
			break;
	}

	const questLabel = $.CreatePanel("Label", lineContainer, "");
	questLabel.AddClass("QuestMessage");
	questLabel.html = true;

	const statusText = $.Localize("#" + questStatus);
	const descriptionText = $.Localize("#" + description);

	questLabel.text = `<span class="${statusClass}">${statusText}</span> <span class="DescriptionText"> ${descriptionText}</span>`;

    $.Schedule(3, function() {
        if (lineContainer) {
            lineContainer.DeleteAsync(0);
        }
    });
}

(function(){
	mainQuestsPanel.RemoveAndDeleteChildren()
	additionalQuestsPanel.RemoveAndDeleteChildren()

	GameEvents.Subscribe("quest_system_start_quest", startQuest)
	GameEvents.Subscribe("quest_system_update", onQuestUpdate)
	GameEvents.Subscribe("quest_system_remove", onQuestRemove)
	GameEvents.Subscribe("debug", () => {
		showQuestStatusText({description : "fail"})
	})

	GameEvents.Subscribe("RequestQuests", onRequestQuestsResponce)
	GameEvents.SendCustomGameEventToServer("RequestQuests", {})

	const ROOT_PANEL = $.GetContextPanel()

	if (ROOT_PANEL.GetParent().type === "DOTACustomUITypeContainer") {
		const DOTA_HUD = ROOT_PANEL.GetParent().GetParent().GetParent()
		const HUD_ELEMENTS = DOTA_HUD.FindChildTraverse("HUDElements")

		ROOT_PANEL.SetParent(HUD_ELEMENTS)
	}
})()