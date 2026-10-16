--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


const filter_messages_basic = [
	"DOTA_Chat_Disconnect",
	"DOTA_Chat_PlayerLeft",
	"DOTA_Chat_DisconnectWaitForReconnect",
	"DOTA_Chat_DisconnectTimeRemaining",
	"DOTA_Chat_DisconnectTimeRemainingPlural",
];

let CHAT_FILTERS = [];
filter_messages_basic.forEach((loc_token) => {
	let text = $.Localize(loc_token);
	text = text
		.replace(/.*%s2/, "")
		.replace("%s1", "")
		.replace(/ +(?= )/g, "");
	text = text.replace(/<[^>]+>/g, "").trim();
	CHAT_FILTERS.push(text);
});