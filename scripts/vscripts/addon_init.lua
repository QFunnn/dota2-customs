--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


-- if IsServer() then
--     if CDOTA_Ability_Lua.GetCastRangeBonus_Engine == nil then
--         CDOTA_Ability_Lua.GetCastRangeBonus_Engine = CDOTA_Ability_Lua.GetCastRangeBonus
--     end
--     function CDOTA_Ability_Lua:GetCastRangeBonus(h)
--         return CDOTA_Ability_Lua.GetCastRangeBonus_Engine(self, h)
--     end
-- else
--     if C_DOTA_Ability_Lua.GetCastRangeBonus_Engine == nil then
--         C_DOTA_Ability_Lua.GetCastRangeBonus_Engine = C_DOTA_Ability_Lua.GetCastRangeBonus
--     end
--     function C_DOTA_Ability_Lua:GetCastRangeBonus(h)
--         return C_DOTA_Ability_Lua.GetCastRangeBonus_Engine(self, h)
--     end
-- end