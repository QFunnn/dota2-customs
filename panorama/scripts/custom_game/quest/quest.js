--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


var quests = {};

function AddDebugQuest(color)
{
	//make panel
	var panel = $.CreatePanel('Panel', $('#Quests'),'');
	panel.BLoadLayoutSnippet("Quest");
	
	panel.FindChildTraverse('QuestTitle').text = "survival on forest";
	panel.FindChildTraverse('QuestDiscription').text = "kill greevel";
	// panel.FindChildTraverse('QuestProgress').text = "3/10";
	SetQuestProgress(panel, 5, 10 );
}

function InitQuest(name, description, target)
{
	var panel = $.CreatePanel('Panel', $('#Quests'),'');
	panel.BLoadLayoutSnippet("Quest");
	
	panel.FindChildTraverse('QuestTitle').text = $.Localize(name);
	panel.FindChildTraverse('QuestDiscription').text = $.Localize(description);
	
	panel.name = name;
	panel.desc = description;
	panel.goal = target;
	panel.current = 0;
	
	SetQuestProgress(panel, 0, target)
	return panel;
}


function SetQuestProgress(quest,current, goal)
{
	
	if (goal < 200)
	{		
	quest.FindChildTraverse('QuestProgress').text = current + "/" + goal;
	}
	
	else if (goal > 600)
	{
	quest.FindChildTraverse('QuestProgress').text = "";
	}
	
	else
	{
	quest.FindChildTraverse('QuestProgress').text = "";
	}
	
	
	
	var percent = (current / goal);
	var background = quest.FindChildTraverse("Background");
	background.style.width = (percent * 100) + "%";
	
	quest.goal = goal;
	quest.current = current;
}

function RemoveQuest(quest)
	{
	quest.DeleteAsync(0);
	}
	
/*Event listeners*/

function OnNewQuest(dat)
{
	var quest = InitQuest(dat.name,dat.desc,dat.max);
	quest.tag = dat.id;	
	quests[dat.id] = quest;
}


function OnQuestUpdateProgress(dat)
{
	for (var x in quests)
	{
		quest = quests[x];
		if (quest.tag == dat.id)
		{
			SetQuestProgress(quest, dat.current, dat.max);
			break;
		}
	}
}

function OnQuestRemove(dat)
{
	for (var x in quests)
	{
		quest = quests[x];
		if (quest.tag == dat.id)
		{
			 RemoveQuest(quest);
			break;
		}
	}
}


function debug()
{
	GameEvents.Subscribe("quest_create_quest", OnNewQuest);
	GameEvents.Subscribe("quest_update_quest", OnQuestUpdateProgress);
	GameEvents.Subscribe("quest_remove_quest", OnQuestRemove);
}

debug();