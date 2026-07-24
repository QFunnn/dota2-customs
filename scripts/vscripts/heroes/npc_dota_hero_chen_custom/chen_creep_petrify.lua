--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_chen_creep_petrify", "heroes/npc_dota_hero_chen_custom/chen_creep_petrify", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_chen_creep_petrify_orb", "heroes/npc_dota_hero_chen_custom/chen_creep_petrify", LUA_MODIFIER_MOTION_NONE )

chen_creep_petrify = class({})

function chen_creep_petrify:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/creep_particles/prowler_shaman_shamanistic_ward.vpcf", context )
end

function chen_creep_petrify:GetIntrinsicModifierName()
	return "modifier_chen_creep_petrify_orb"
end

function chen_creep_petrify:GetCastRange(vLocation, hTarget)
	return self:GetCaster():Script_GetAttackRange() + 50
end

function chen_creep_petrify:GetProjectileName()
	return "particles/units/heroes/hero_drow/drow_frost_arrow.vpcf"
end

function chen_creep_petrify:OnOrbImpact( params )
    if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration")
    params.target:EmitSound("n_creep_Spawnlord.Freeze")
	params.target:AddNewModifier( self:GetCaster(), self, "modifier_chen_creep_petrify", { duration = duration+FrameTime() } )
end

modifier_chen_creep_petrify = class({})

function modifier_chen_creep_petrify:IsHidden()
	return false
end

function modifier_chen_creep_petrify:IsDebuff()
	return true
end

function modifier_chen_creep_petrify:IsStunDebuff()
	return false
end

function modifier_chen_creep_petrify:IsPurgable()
	return true
end

function modifier_chen_creep_petrify:OnCreated( kv )
	self.damage_intellect = self:GetAbility():GetSpecialValueFor( "damage_intellect" )
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/creep_particles/prowler_shaman_shamanistic_ward.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    self:AddParticle(particle, false, false, -1, false, false)
    self:StartIntervalThink(1)
end

function modifier_chen_creep_petrify:OnRefresh( kv )
	self.damage_intellect = self:GetAbility():GetSpecialValueFor( "damage_intellect" )
end

function modifier_chen_creep_petrify:OnIntervalThink()
    if not IsServer() then return end
    local damage = self:GetCaster():GetIntellect(false) / 100 * self.damage_intellect
    ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
end

function modifier_chen_creep_petrify:CheckState()
    return
    {
        [MODIFIER_STATE_ROOTED] = true,
    }
end

function modifier_chen_creep_petrify:GetEffectName()
	return "particles/generic_gameplay/generic_slowed_cold.vpcf"
end

function modifier_chen_creep_petrify:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

modifier_chen_creep_petrify_orb = class({})

function modifier_chen_creep_petrify_orb:IsHidden()
	return true
end

function modifier_chen_creep_petrify_orb:IsDebuff()
	return false
end

function modifier_chen_creep_petrify_orb:IsPurgable()
	return false
end

function modifier_chen_creep_petrify_orb:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT
end

function modifier_chen_creep_petrify_orb:OnCreated( kv )
	self.ability = self:GetAbility()
	self.cast = false
	self.records = {}
end

function modifier_chen_creep_petrify_orb:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_EVENT_ON_ATTACK_FAIL,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY,
		MODIFIER_EVENT_ON_ORDER,
        MODIFIER_PROPERTY_PROJECTILE_NAME,
	}
	return funcs
end

function modifier_chen_creep_petrify_orb:GetModifierProjectileName()
	if self:ShouldLaunch( self:GetCaster():GetAggroTarget() ) then
		return "particles/base_attacks/fountain_attack.vpcf"
	end
end

function modifier_chen_creep_petrify_orb:OnAttack( params )
	if params.attacker~=self:GetParent() then return end
	if self:ShouldLaunch( params.target ) then
		if not params.no_attack_cooldown then
			self.ability:UseResources( true, true, false, true )
		end
		self.records[params.record] = true
		if self.ability.OnOrbFire then self.ability:OnOrbFire( params ) end
	end

	self.cast = false
end

function modifier_chen_creep_petrify_orb:GetModifierProcAttack_Feedback( params )
	if self.records[params.record] then
		if self.ability.OnOrbImpact then self.ability:OnOrbImpact( params ) end
	end
end
function modifier_chen_creep_petrify_orb:OnAttackFail( params )
	if self.records[params.record] then
		if self.ability.OnOrbFail then self.ability:OnOrbFail( params ) end
	end
end
function modifier_chen_creep_petrify_orb:OnAttackRecordDestroy( params )
	self.records[params.record] = nil
end

function modifier_chen_creep_petrify_orb:OnOrder( params )
	if params.unit~=self:GetParent() then return end

	if params.ability then
		if params.ability==self:GetAbility() then
			self.cast = true
			return
		end
		local pass = false
		local behavior = params.ability:GetBehaviorInt()
		if self:FlagExist( behavior, DOTA_ABILITY_BEHAVIOR_DONT_CANCEL_CHANNEL ) or 
			self:FlagExist( behavior, DOTA_ABILITY_BEHAVIOR_DONT_CANCEL_MOVEMENT ) or
			self:FlagExist( behavior, DOTA_ABILITY_BEHAVIOR_IGNORE_CHANNEL )
		then
			local pass = true -- do nothing
		end

		if self.cast and (not pass) then
			self.cast = false
		end
	else
		if self.cast then
			if self:FlagExist( params.order_type, DOTA_UNIT_ORDER_MOVE_TO_POSITION ) or
				self:FlagExist( params.order_type, DOTA_UNIT_ORDER_MOVE_TO_TARGET )	or
				self:FlagExist( params.order_type, DOTA_UNIT_ORDER_ATTACK_MOVE ) or
				self:FlagExist( params.order_type, DOTA_UNIT_ORDER_ATTACK_TARGET ) or
				self:FlagExist( params.order_type, DOTA_UNIT_ORDER_STOP ) or
				self:FlagExist( params.order_type, DOTA_UNIT_ORDER_HOLD_POSITION )
			then
				self.cast = false
			end
		end
	end
end

function modifier_chen_creep_petrify_orb:ShouldLaunch( target )
	if self.ability:GetAutoCastState() then
		if self.ability.CastFilterResultTarget~=CDOTA_Ability_Lua.CastFilterResultTarget then
			if self.ability:CastFilterResultTarget( target )==UF_SUCCESS then
				self.cast = true
			end
		else
			local nResult = UnitFilter(
				target,
				self.ability:GetAbilityTargetTeam(),
				self.ability:GetAbilityTargetType(),
				self.ability:GetAbilityTargetFlags(),
				self:GetCaster():GetTeamNumber()
			)
			if nResult == UF_SUCCESS then
				self.cast = true
			end
		end
	end

	if self.cast and self.ability:IsFullyCastable() and (not self:GetParent():IsSilenced()) then
		return true
	end

	return false
end

function modifier_chen_creep_petrify_orb:FlagExist(a,b)
	local p,c,d=1,0,b
	while a>0 and b>0 do
		local ra,rb=a%2,b%2
		if ra+rb>1 then c=c+p end
		a,b,p=(a-ra)/2,(b-rb)/2,p*2
	end
	return c==d
end