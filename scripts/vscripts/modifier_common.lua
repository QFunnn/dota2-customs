--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


--通用处理
modifier_common = class({})

function modifier_common:IsHidden() return true end
function modifier_common:IsDebuff() return false end
function modifier_common:IsPurgable() return false end
function modifier_common:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end
function modifier_common:RemoveOnDeath() return false end
function modifier_common:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
    }
end
function modifier_common:OnCreated()
    if IsServer() then
    end
end
function modifier_common:OnRefresh()
    if IsServer() then
    end
end
function modifier_common:GetModifierIncomingDamage_Percentage(params)
    local hParent = self:GetParent()
    if IsServer() then
        if params.damage_type == DAMAGE_TYPE_MAGICAL and IsValid(hParent) then
            --处理魔法暴击
            if MAGIC_CRIT_RECORDS ~= nil then
                for i = #MAGIC_CRIT_RECORDS, 1, -1 do
                    if MAGIC_CRIT_RECORDS[i] == params.record then
                        local number_length = math.floor(math.log(math.floor(params.damage), 10) + 1)
                        local particleID = ParticleManager:CreateParticle("particles/msg_fx/msg_crit.vpcf", PATTACH_OVERHEAD_FOLLOW, hParent)
                        ParticleManager:SetParticleControl(particleID, 1, Vector(0, math.floor(params.damage), 4))
                        ParticleManager:SetParticleControl(particleID, 2, Vector(1, number_length + 1, 0))
                        ParticleManager:SetParticleControl(particleID, 3, Vector(0, 191, 255))
                        ParticleManager:ReleaseParticleIndex(particleID)
                        table.remove(MAGIC_CRIT_RECORDS, i)
                    end
                end
            end
        end
    end
end