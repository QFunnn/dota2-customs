--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


pugna_ward_winter_2018 = class({})
LinkLuaModifier("modifier_pugna_ward_winter_2018", "heroes/hero_pugna/modifier_pugna_ward_winter_2018", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pugna_ward_winter_2018_effect", "heroes/hero_pugna/modifier_pugna_ward_winter_2018_effect", LUA_MODIFIER_MOTION_NONE)

-----------------------------------------------------------------------------------------
function pugna_ward_winter_2018:ProcsMagicStick()
    return false
end

--------------------------------------------------------------------------------
function pugna_ward_winter_2018:OnSpellStart()
    if IsServer() then
        if self:GetCaster() == nil or self:GetCaster():IsNull() then
            return
        end
        local hWard = CreateUnitByName("npc_dota_pugna_ward_winter_2018", self:GetCursorPosition(), true, self:GetCaster(), self:GetCaster(), self:GetCaster():GetTeamNumber())
        if hWard ~= nil then
            local flDuration = self:GetSpecialValueFor("ward_duration")
            local kv =             {
                duration = flDuration,
            }
            self:GetCaster().hWard = hWard
            hWard:AddNewModifier(self:GetCaster(), self, "modifier_pugna_ward_winter_2018", kv)
            hWard:AddNewModifier(self:GetCaster(), self, "modifier_kill", kv)

            EmitSoundOn("Hero_Pugna.NetherWard", hWard)
        end
    end
end