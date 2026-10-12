--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10073.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10073.lua",
	{
		["10"] = "2:1",
		["11"] = "2:10",
		["12"] = "3:1",
		["13"] = "3:26",
		["14"] = "4:1",
		["15"] = "4:10",
		["17"] = "9:1",
		["18"] = "10:14",
		["19"] = "9:1",
		["20"] = "10:38",
		["21"] = "13:5",
		["22"] = "14:9",
		["23"] = "13:5",
		["24"] = "17:5",
		["25"] = "18:9",
		["26"] = "17:5",
		["27"] = "22:5",
		["28"] = "23:9",
		["29"] = "22:5",
		["30"] = "26:5",
		["31"] = "27:9",
		["32"] = "26:5",
		["33"] = "30:5",
		["34"] = "31:14",
		["37"] = "32:15",
		["38"] = "33:15",
		["39"] = "34:14",
		["42"] = "35:9",
		["43"] = "36:9",
		["44"] = "37:9",
		["45"] = "39:9",
		["46"] = "41:15",
		["47"] = "42:9",
		["48"] = "42:26",
		["49"] = "42:31",
		["50"] = "42:38",
		["51"] = "42:46",
		["52"] = "42:49",
		["53"] = "42:56",
		["54"] = "42:9",
		["55"] = "44:9",
		["56"] = "30:5",
		["57"] = "47:5",
		["58"] = "48:14",
		["61"] = "50:15",
		["62"] = "51:15",
		["63"] = "52:13",
		["64"] = "53:13",
		["65"] = "53:32",
		["66"] = "53:35",
		["67"] = "54:21",
		["68"] = "56:21",
		["70"] = "53:35",
		["71"] = "53:13",
		["73"] = "47:5",
		["74"] = "64:5",
		["75"] = "65:9",
		["76"] = "64:5",
		["77"] = "68:5",
		["78"] = "69:14",
		["81"] = "70:15",
		["82"] = "71:15",
		["83"] = "72:14",
		["86"] = "74:15",
		["87"] = "75:9",
		["88"] = "75:9",
		["89"] = "75:9",
		["91"] = "81:9",
		["92"] = "68:5",
		["93"] = "84:5",
		["94"] = "85:9",
		["95"] = "84:5",
		["96"] = "88:5",
		["97"] = "89:9",
		["98"] = "88:5",
		["99"] = "94:5",
		["100"] = "95:9",
		["101"] = "94:5",
		["102"] = "102:5",
		["103"] = "103:14",
		["106"] = "104:15",
		["107"] = "105:14",
		["110"] = "106:9",
		["111"] = "102:5",
		["112"] = "112:5",
		["113"] = "113:15",
		["114"] = "114:13",
		["115"] = "115:13",
		["116"] = "116:21",
		["117"] = "117:21",
		["121"] = "121:9",
		["122"] = "112:5",
		["123"] = "127:5",
		["124"] = "128:15",
		["125"] = "129:13",
		["126"] = "130:13",
		["128"] = "127:5",
		["129"] = "137:5",
		["130"] = "138:15",
		["131"] = "139:13",
		["132"] = "140:13",
		["133"] = "142:9",
		["134"] = "143:19",
		["135"] = "144:17",
		["136"] = "145:17",
		["138"] = "147:13",
		["140"] = "150:9",
		["141"] = "137:5",
		["142"] = "156:5",
		["143"] = "161:9",
		["144"] = "162:13",
		["145"] = "163:13",
		["147"] = "156:5",
		["148"] = "170:5",
		["149"] = "171:14",
		["152"] = "172:14",
		["155"] = "175:15",
		["156"] = "176:14",
		["157"] = "178:19",
		["158"] = "179:17",
		["159"] = "180:17",
		["160"] = "181:21",
		["165"] = "188:15",
		["166"] = "189:9",
		["168"] = "190:19",
		["169"] = "191:18",
		["170"] = "191:35",
		["172"] = "193:18",
		["173"] = "194:17",
		["175"] = "196:19",
		["176"] = "197:13",
		["180"] = "201:15",
		["181"] = "202:15",
		["182"] = "203:13",
		["183"] = "204:13",
		["184"] = "205:23",
		["185"] = "206:21",
		["186"] = "208:25",
		["187"] = "209:25",
		["189"] = "211:25",
		["194"] = "218:21",
		["196"] = "219:18",
		["197"] = "219:89",
		["199"] = "221:66",
		["200"] = "221:21",
		["201"] = "221:34",
		["202"] = "221:54",
		["203"] = "224:17",
		["204"] = "225:18",
		["205"] = "227:17",
		["207"] = "235:17",
		["209"] = "238:17",
		["210"] = "239:17",
		["215"] = "244:21",
		["216"] = "245:18",
		["217"] = "247:21",
		["218"] = "248:21",
		["222"] = "170:5",
		["223"] = "257:5",
		["224"] = "258:14",
		["227"] = "259:14",
		["230"] = "262:15",
		["231"] = "263:14",
		["232"] = "265:13",
		["235"] = "269:15",
		["236"] = "272:15",
		["237"] = "273:13",
		["238"] = "275:13",
		["240"] = "257:5",
		["241"] = "10:14",
		["242"] = "9:2",
		["243"] = "9:2",
		["244"] = "9:19",
		["245"] = "9:2",
		["247"] = "9:2",
		["248"] = "10:14",
		["250"] = "10:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase_Debuff = ____sl_modifier_base.SLModifierBase_Debuff
local ____sl_modifier_bless_10073_display = require("modifiers.bless_modifiers.sl_modifier_bless_10073_display")
local sl_modifier_bless_10073_display = ____sl_modifier_bless_10073_display.sl_modifier_bless_10073_display
--- 10073 灼烧debuff，每层独立计时
____exports.sl_modifier_bless_10073 = __TS__Class()
local sl_modifier_bless_10073 = ____exports.sl_modifier_bless_10073
sl_modifier_bless_10073.name = "sl_modifier_bless_10073"
__TS__ClassExtends(sl_modifier_bless_10073, SLModifierBase_Debuff)
function sl_modifier_bless_10073.prototype.GetDmgPct(self)
	return self._dmg_pct
end
function sl_modifier_bless_10073.prototype.IsHidden(self)
	return true
end
function sl_modifier_bless_10073.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function sl_modifier_bless_10073.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TOOLTIP }
end
function sl_modifier_bless_10073.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local parent = self:GetParent()
	if not IsValid(caster) or not IsValid(parent) then
		return
	end
	self._dmg_pct = params.dmg_pct
	self:SetHasCustomTransmitterData(true)
	self:SendBuffRefreshToClients()
	self:StartIntervalThink(1)
	local pid = SParticleManager:CreateGenericParticle(BLESS_PARTICLES.bless_10073, PATTACH_ABSORIGIN_FOLLOW, parent)
	self:AddParticle(pid, false, false, -1, false, false)
	self:_UpdateDisplayModifier()
end
function sl_modifier_bless_10073.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local parent = self:GetParent()
	if IsValid(parent) and IsValid(caster) then
		Timers:CreateTimer(0, function()
			if IsValid(parent) and IsValid(caster) then
				____exports.sl_modifier_bless_10073:_UpdateDisplayModifierStackOnly(parent, caster)
			end
		end)
	end
end
function sl_modifier_bless_10073.prototype.SetSourceBless(self, bless)
	self._source_bless = bless
end
function sl_modifier_bless_10073.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local parent = self:GetParent()
	if not IsValid(caster) or not IsValid(parent) then
		return
	end
	local damage = parent:GetMaxHealth() * self._dmg_pct * 0.01
	local ____table__source_bless_ApplyDamage_result_0 = self._source_bless
	if ____table__source_bless_ApplyDamage_result_0 ~= nil then
		____table__source_bless_ApplyDamage_result_0 = ____table__source_bless_ApplyDamage_result_0:ApplyDamage({
			attacker = caster,
			victim = parent,
			damage = damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
		})
	end
	SLModules.ClientData:PushNumberData(parent, damage, 6)
end
function sl_modifier_bless_10073.prototype.HandleCustomTransmitterData(self, data)
	self._dmg_pct = data.dmg_pct
end
function sl_modifier_bless_10073.prototype.AddCustomTransmitterData(self)
	return { dmg_pct = self._dmg_pct }
end
function sl_modifier_bless_10073.prototype.OnTooltip(self)
	return self._dmg_pct
end
function sl_modifier_bless_10073.prototype._UpdateDisplayModifier(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(parent) then
		return
	end
	____exports.sl_modifier_bless_10073:_UpdateDisplayModifierStatic(parent)
end
function sl_modifier_bless_10073._GetDisplayModifierForCaster(self, parent, caster)
	local all_display_modifiers = parent:FindAllModifiersByName(sl_modifier_bless_10073_display.name)
	if all_display_modifiers then
		for ____, display_modifier in ipairs(all_display_modifiers) do
			if display_modifier:GetCaster() == caster then
				return display_modifier
			end
		end
	end
	return nil
end
function sl_modifier_bless_10073._RemoveDisplayModifierForCaster(self, parent, caster)
	local display_modifier = ____exports.sl_modifier_bless_10073:_GetDisplayModifierForCaster(parent, caster)
	if display_modifier and IsValid(display_modifier) then
		display_modifier:Destroy()
	end
end
function sl_modifier_bless_10073._CalculateStackInfo(self, modifiers)
	local stack_count = #modifiers
	local max_remaining_time = 0
	local dmg_pct = 0
	for ____, modifier in ipairs(modifiers) do
		local remaining_time = modifier:GetRemainingTime()
		if remaining_time > max_remaining_time then
			max_remaining_time = remaining_time
		end
		dmg_pct = modifier:GetDmgPct()
	end
	return { stack_count = stack_count, max_remaining_time = max_remaining_time, dmg_pct = dmg_pct }
end
function sl_modifier_bless_10073._UpdateDisplayModifierStackAndDuration(
	self,
	display_modifier,
	stack_count,
	max_remaining_time
)
	display_modifier:SetStackCount(stack_count)
	if max_remaining_time > 0 then
		display_modifier:SetDuration(max_remaining_time, true)
	end
end
function sl_modifier_bless_10073._UpdateDisplayModifierStatic(self, parent)
	if not IsServer() then
		return
	end
	if not IsValid(parent) then
		return
	end
	local all_modifiers = parent:FindAllSLModifiers(____exports.sl_modifier_bless_10073)
	if not all_modifiers or #all_modifiers == 0 then
		local all_display_modifiers = parent:FindAllModifiersByName(sl_modifier_bless_10073_display.name)
		if all_display_modifiers then
			for ____, display_modifier in ipairs(all_display_modifiers) do
				display_modifier:Destroy()
			end
		end
		return
	end
	local modifiers_by_caster = {}
	for ____, modifier in ipairs(all_modifiers) do
		do
			local caster = modifier:GetCaster()
			if not IsValid(caster) then
				goto __continue44
			end
			if not (modifiers_by_caster[caster] ~= nil) then
				modifiers_by_caster[caster] = {}
			end
			local caster_modifiers = modifiers_by_caster[caster]
			caster_modifiers[#caster_modifiers + 1] = modifier
		end
		::__continue44::
	end
	local existing_display_casters = {}
	local all_display_modifiers = parent:FindAllModifiersByName(sl_modifier_bless_10073_display.name)
	if all_display_modifiers then
		for ____, display_modifier in ipairs(all_display_modifiers) do
			local caster = display_modifier:GetCaster()
			if IsValid(caster) then
				if existing_display_casters[caster] ~= nil then
					display_modifier:Destroy()
				else
					existing_display_casters[caster] = display_modifier
				end
			end
		end
	end
	for caster, caster_modifiers in pairs(modifiers_by_caster) do
		do
			if not IsValid(caster) or not caster_modifiers or #caster_modifiers == 0 then
				goto __continue54
			end
			local ____temp_2 = ____exports.sl_modifier_bless_10073:_CalculateStackInfo(caster_modifiers)
			local stack_count = ____temp_2.stack_count
			local max_remaining_time = ____temp_2.max_remaining_time
			local dmg_pct = ____temp_2.dmg_pct
			local display_modifier = existing_display_casters[caster]
			if not display_modifier then
				display_modifier = parent:AddSLModifier(
					sl_modifier_bless_10073_display,
					{ caster = caster, modifierTable = { dmg_pct = dmg_pct } }
				)
			else
				display_modifier:OnRefresh({ dmg_pct = dmg_pct })
			end
			if display_modifier then
				____exports.sl_modifier_bless_10073:_UpdateDisplayModifierStackAndDuration(
					display_modifier,
					stack_count,
					max_remaining_time
				)
			end
		end
		::__continue54::
	end
	for caster, display_modifier in pairs(existing_display_casters) do
		if not (modifiers_by_caster[caster] ~= nil) then
			if IsValid(display_modifier) then
				display_modifier:Destroy()
			end
		end
	end
end
function sl_modifier_bless_10073._UpdateDisplayModifierStackOnly(self, parent, caster)
	if not IsServer() then
		return
	end
	if not IsValid(parent) or not IsValid(caster) then
		return
	end
	local caster_modifiers = parent:FindAllSLModifiers(____exports.sl_modifier_bless_10073, caster)
	if not caster_modifiers or #caster_modifiers == 0 then
		____exports.sl_modifier_bless_10073:_RemoveDisplayModifierForCaster(parent, caster)
		return
	end
	local stack_count = #caster_modifiers
	local display_modifier = ____exports.sl_modifier_bless_10073:_GetDisplayModifierForCaster(parent, caster)
	if display_modifier then
		display_modifier:SetStackCount(stack_count)
	end
end
sl_modifier_bless_10073 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10073", nil, getfenv()) },
	sl_modifier_bless_10073
)
____exports.sl_modifier_bless_10073 = sl_modifier_bless_10073
return ____exports