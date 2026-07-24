--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_magic_immune_buff = class({})
function modifier_magic_immune_buff:IsPurgable() return false end
function modifier_magic_immune_buff:IsPurgeException() return false end
function modifier_magic_immune_buff:DeclareFunctions()
	return
	{
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
	}
end
function modifier_magic_immune_buff:GetModifierIncomingDamage_Percentage(params)
	if not IsServer() then return end
	if not params.attacker then return end
	if not params.inflictor then return end
	if self:FlagExist( params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION ) then
		return -100 
	end
	local behavior = params.inflictor:GetAbilityTargetFlags()
	if not self:FlagExist( behavior, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES ) then
    	if params.damage_type == DAMAGE_TYPE_MAGICAL then 
        	return -80
    	end
	end
end

function modifier_magic_immune_buff:FlagExist(a,b)
	local p,c,d=1,0,b
	while a>0 and b>0 do
		local ra,rb=a%2,b%2
		if ra+rb>1 then c=c+p end
		a,b,p=(a-ra)/2,(b-rb)/2,p*2
	end
	return c==d
end
function modifier_magic_immune_buff:GetModifierMagicalResistanceBonus()
	if not IsClient() then return end
	return 80
end
function modifier_magic_immune_buff:CheckState()
 	return 
 	{
 		[MODIFIER_STATE_DEBUFF_IMMUNE] = true
	}
end

function modifier_magic_immune_buff:GetEffectName()
    return "particles/items_fx/black_king_bar_avatar.vpcf"
end