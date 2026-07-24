--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_queenofpain_blood_pact", "abilities/queen_of_pain/custom_queenofpain_blood_pact", LUA_MODIFIER_MOTION_NONE)


custom_queenofpain_blood_pact = class({})


function custom_queenofpain_blood_pact:CreateTalent()
self:SetHidden(false)
end

function custom_queenofpain_blood_pact:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle","particles/brist_proc.vpcf", context )
PrecacheResource( "particle","particles/queen_of_pain/scream_legendary.vpcf", context )
PrecacheResource( "particle","particles/qop_scepter.vpcf", context )

end

function custom_queenofpain_blood_pact:GetCooldown(iLevel)
return self:GetCaster():GetTalentValue("modifier_queen_scream_7", "cd")
end

function custom_queenofpain_blood_pact:GetHealthCost(level)
return self:GetCaster():GetTalentValue("modifier_queen_scream_7", "cost")*self:GetCaster():GetMaxHealth()/100
end 


function custom_queenofpain_blood_pact:OnSpellStart()
local caster = self:GetCaster()
caster:EmitSound("QoP.Scepter")
caster:AddNewModifier(caster, self, "modifier_queenofpain_blood_pact", {duration = caster:GetTalentValue("modifier_queen_scream_7", "duration")})

caster:GenericParticle("particles/brist_proc.vpcf")
end


modifier_queenofpain_blood_pact = class({})
function modifier_queenofpain_blood_pact:IsHidden() return false end
function modifier_queenofpain_blood_pact:IsPurgable() return false end


function modifier_queenofpain_blood_pact:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.interval = self.parent:GetTalentValue("modifier_queen_scream_7", "interval")
self.cost = self.parent:GetTalentValue("modifier_queen_scream_7", "cost")
self.cd = self.parent:GetTalentValue("modifier_queen_scream_7", "cd_bonus")
self.damage = self.parent:GetTalentValue("modifier_queen_scream_7", "damage")

self.parent:AddSpellEvent(self)

if not IsServer() then return end
self.ability:EndCd()

for abilitySlot = 0,8 do

	local ability = self.parent:GetAbilityByIndex(abilitySlot)

	if ability ~= nil and ability ~= self.ability and ability:GetName() ~= "custom_queenofpain_blink" then
		local cooldown_mod = self.parent:AddNewModifier(self.parent, self.ability, "modifier_cooldown_speed", {ability = ability:entindex(), cd_inc = self.cd})
		local name = self:GetName()

		cooldown_mod:SetEndRule(function()
			return self.parent:HasModifier(name)
		end)
	end
end

self.particle = ParticleManager:CreateParticle("particles/queen_of_pain/scream_legendary.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(self.particle, 0, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, self.parent:GetAbsOrigin(), true )
ParticleManager:SetParticleControlEnt(self.particle, 3, self.parent, PATTACH_OVERHEAD_FOLLOW, nil, self.parent:GetAbsOrigin(), true )
self:AddParticle(self.particle, false, false, -1, false, false)


self.pfx_2 = ParticleManager:CreateParticle("particles/qop_scepter.vpcf", PATTACH_OVERHEAD_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(self.pfx_2, 3, self.parent, PATTACH_OVERHEAD_FOLLOW, nil , self.parent:GetAbsOrigin(), true )
self:AddParticle(self.pfx_2, false, false, -1, false, false)
self.max_time = self:GetRemainingTime()
self:OnIntervalThink()
self:StartIntervalThink(0.1)
end


function modifier_queenofpain_blood_pact:OnIntervalThink()
if not IsServer() then return end
self.parent:UpdateUIshort({max_time = self.max_time, time = self:GetRemainingTime(), stack = tostring(self.damage*self:GetStackCount()).."%" , style = "QopPact"})
end


function modifier_queenofpain_blood_pact:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
}
end

function modifier_queenofpain_blood_pact:OnDestroy()
if not IsServer() then return end
self.ability:StartCd()
self.parent:UpdateUIshort({hide = 1, hide_full = 1, style = "QopPact"})
end

function modifier_queenofpain_blood_pact:SpellEvent( params )
if not IsServer() then return end
if params.unit~=self:GetParent() then return end
if params.ability:IsItem() then return end
self:IncrementStackCount()
end 

function modifier_queenofpain_blood_pact:GetModifierSpellAmplify_Percentage()
return self.damage*self:GetStackCount()
end 