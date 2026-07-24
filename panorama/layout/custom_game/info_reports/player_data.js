--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var player_table_shop = CustomNetTables.GetTableValue("sub_data", String(Players.GetLocalPlayer()));
var PLAYER_SERVER_DATA = CustomNetTables.GetTableValue("server_data", String(Players.GetLocalPlayer()))
var SAVE_DATA_SETS_ITEMS = {};
var ALL_TABLE_CUSTOM_SOUNDS = CustomNetTables.GetTableValue("custom_sounds", "sounds");
var PLAYER_CHATWHEEL_TABLE = CustomNetTables.GetTableValue("players_chat_wheel", String(Players.GetLocalPlayer()))
var ALL_PETS_TABLE = CustomNetTables.GetTableValue("shop_items", "pets")
var ALL_FIVE_TABLE = CustomNetTables.GetTableValue("shop_items", "high_five")
var ALL_EFFECTS_TABLE = CustomNetTables.GetTableValue("shop_items", "effects")
var ALL_TIPS_TABLE = CustomNetTables.GetTableValue("shop_items", "tips")
var CURRENT_TAB_ITEMS_HERO = "button_id_1"

CustomNetTables.SubscribeNetTableListener( "sub_data", UpdatePlayerShopTable );
CustomNetTables.SubscribeNetTableListener( "server_data", UpdatePlayerShopTable );
CustomNetTables.SubscribeNetTableListener( "players_chat_wheel", UpdatePlayerShopTable );

function UpdatePlayerShopTable(table, key, data ) 
{
	if (table == "sub_data") 
	{
		if (key == Players.GetLocalPlayer()) 
        {
            player_table_shop = data
            UpdateSelectionSets()
		}
	}
    if (table == "server_data")
	{
		if (key == Players.GetLocalPlayer()) 
        {
            PLAYER_SERVER_DATA = data
		}
	}
    if (table == "players_chat_wheel") 
	{
		if (key == Players.GetLocalPlayer()) 
        {
            PLAYER_CHATWHEEL_TABLE = data
            InitChatWheelData()
			CloseActiveChatBlock()
		}
	}
}