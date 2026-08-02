--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


$.GetContextPanel().SetHasClass("Quest", false);
$.GetContextPanel().visible = false;
$( "#QuestMsgPanelRight" ).visible = false;

function OnNewMessage(data)
{
	//$.Msg("OnNewMessage");
	$( "#MessagePanelName" ).text = $.Localize(data.messageName );
	$( "#MessagePanelText" ).text = $.Localize(data.messageText );
	$( "#MessagePanel" ).visible = true;

	$.Schedule(10,function()
	{
		$( "#MessagePanel" ).visible = false; 
	});
}

function OnNewQuestMsg(data)
{
	$.GetContextPanel().visible = true;
	$( "#QuestMsgPanelName" ).text = $.Localize(data.messageName );
	$( "#QuestMsgPanelText" ).text = $.Localize(data.messageText );
	$( "#QuestMsgPanel" ).visible = true;
	$( "#QuestMsgPanelRight" ).visible = true;
}


function OnCloseQuestMsgPanelRight() {
	$( "#QuestMsgPanelRight" ).visible = false;
	$.GetContextPanel().visible = false;
}


function debug()
{
	$.Msg("Debug");
	GameEvents.Subscribe("MessagePanel_create_new_message", OnNewMessage);
	GameEvents.Subscribe("QuestMsgPanel_create_new_message", OnNewQuestMsg);
}


debug();