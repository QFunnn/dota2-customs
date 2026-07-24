--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if HeroDemo == nil then
	_G.HeroDemo = class({})
end

-- Источник списка админов: модуль `web/admins.lua` (грузит из БД, fallback — хардкод там же).

function HeroDemo:OnGameRulesStateChange()
	-- [TEMP DEBUG] Удалить после диагностики "кнопка создать мишень не реагирует"
	print(string.format("[HeroDemo/State] called, state=%d, IsCheatsEnabled=%s, AdminsLoaded=%s",
		GameRules:State_Get(),
		tostring(IsCheatsEnabled()),
		tostring(Admins and Admins.AdminIDs ~= nil)))

	if GameRules:State_Get() == DOTA_GAMERULES_STATE_PRE_GAME then
        for i=0,19 do
            if PlayerResource:IsValidPlayerID(i) then
                local cheats = IsCheatsEnabled()
                local admin = Admins:IsAdminPlayer(i)
                print(string.format("[HeroDemo/State] PRE_GAME PID=%d admin=%s cheats=%s steamid=%s",
                    i, tostring(admin), tostring(cheats), tostring(PlayerResource:GetSteamAccountID(i))))

                if admin or cheats then
                    HeroDemo:Init()
                    print(string.format("[HeroDemo/State] Init() called for PID=%d, self.init=%s", i, tostring(HeroDemo.init)))

                    if cheats then
                        CustomUI:DynamicHud_Create( i, "Hero_Demo", "file://{resources}/layout/custom_game/hud_hero_demo/hud_hero_demo.xml", nil )
                        print(string.format("[HeroDemo/State] DynamicHud_Create called for PID=%d", i))
                    end
                end
            end
        end
	end
end

function HeroDemo:GetAllAdminTeams()
    local Teams = {}
    for PlayerID, PlayerInfo in pairs(Players:GetAllPlayers()) do
        if Admins:IsAdminPlayer(PlayerID) then
            table.insert(Teams, PlayerInfo.team)
        end
    end

    return Teams
end