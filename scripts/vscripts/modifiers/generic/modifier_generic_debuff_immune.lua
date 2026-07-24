--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



modifier_generic_debuff_immune = class(mod_hidden)
function modifier_generic_debuff_immune:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_generic_debuff_immune:CheckState()
return 
{
    [MODIFIER_STATE_DEBUFF_IMMUNE] = true
}
end

function modifier_generic_debuff_immune:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
    --MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE
}
end

function modifier_generic_debuff_immune:GetAbsoluteNoDamagePure(params)
if not self:CheckAllow(params) then return 0 end
return 1
end

function modifier_generic_debuff_immune:GetModifierMagicalResistanceBonus(params)
if IsClient() then return self.magic_damage * -1 end
if not self:CheckAllow(params) then return end

return (self.magic_damage)*-1
end


function modifier_generic_debuff_immune:CheckAllow(params)
if not IsServer() then return end
if self ~= self.parent:FindAllModifiersByName(self:GetName())[1] then return end
if not params.attacker then return end
if not params.inflictor then return end

if bit.band(params.inflictor:GetAbilityTargetFlags(), DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES) == 0 then
    return true
end
return false
end


function modifier_generic_debuff_immune:OnCreated(table)
if not IsServer() then return end

self.parent = self:GetParent()
self.RemoveForDuel = true

if table.effect then
    local effect 
    if table.effect == 1 then 
       effect = "particles/items_fx/black_king_bar_avatar.vpcf"
    elseif table.effect == 2 then
        effect = "particles/items5_fx/minotaur_horn.vpcf"
    end 
    if table.sound == 1 then
        self.parent:EmitSound("DOTA_Item.MinotaurHorn.Cast")
    end
    self.parent:GenericParticle(effect, self)
end

self.magic_damage = -60

if (table.magic_damage and table.magic_damage < self.magic_damage) or table.magic_damage == 0 then 
    self.magic_damage = table.magic_damage
end

if self.magic_damage > 0 then 
	self.magic_damage = self.magic_damage * -1
end

self:SetHasCustomTransmitterData(true)
end

function modifier_generic_debuff_immune:AddCustomTransmitterData() return 
{
    magic_damage = self.magic_damage,
} 
end

function modifier_generic_debuff_immune:HandleCustomTransmitterData(data)
self.magic_damage  = data.magic_damage
end