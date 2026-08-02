--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "units/player_portraits/player_portrait_3"
local b = require("lualib_bundle")
local c = b.__TS__ObjectAssign
local d = b.__TS__SourceMapTraceBack
d(
	debug.getinfo(1).short_src,
	{
		["5"] = 2,
		["6"] = 3,
		["7"] = 4,
		["10"] = 7,
		["11"] = 8,
		["12"] = 9,
		["13"] = 9,
		["14"] = 9,
		["16"] = 9,
		["17"] = 10,
		["20"] = 11,
		["21"] = 11,
		["22"] = 11,
		["24"] = 11,
		["25"] = 12,
		["26"] = 13,
		["27"] = 14,
		["28"] = 15,
		["30"] = 17,
		["31"] = 17,
		["32"] = 17,
		["34"] = 17,
		["35"] = 18,
		["38"] = 19,
		["39"] = 21,
		["40"] = 22,
		["41"] = 22,
		["42"] = 22,
		["43"] = 22,
		["45"] = 22,
		["46"] = 23,
		["47"] = 24,
		["49"] = 26,
		["50"] = 29,
		["51"] = 29,
		["52"] = 29,
		["53"] = 29,
		["54"] = 29,
		["55"] = 29,
		["56"] = 29,
		["57"] = 29,
		["58"] = 29,
		["59"] = 29,
		["60"] = 29,
		["61"] = 29,
		["62"] = 29,
		["63"] = 29,
		["64"] = 29,
		["65"] = 29,
		["66"] = 29,
		["67"] = 29,
		["68"] = 29,
		["69"] = 29,
		["70"] = 29,
		["71"] = 29,
		["72"] = 29,
		["73"] = 29,
		["74"] = 29,
		["75"] = 29,
		["76"] = 29,
		["77"] = 29,
		["78"] = 29,
		["79"] = 29,
		["80"] = 29,
		["81"] = 29,
		["82"] = 29,
		["83"] = 29,
		["84"] = 29,
		["86"] = 66,
		["87"] = 66,
		["91"] = 66,
		["93"] = 66,
		["94"] = 66,
		["95"] = 66,
		["97"] = 66,
		["98"] = 67,
		["99"] = 68,
		["101"] = 69,
		["102"] = 69,
		["103"] = 70,
		["104"] = 71,
		["105"] = 72,
		["107"] = 69,
		["112"] = 76,
		["113"] = 76,
		["114"] = 77,
		["115"] = 78,
		["116"] = 79,
		["117"] = 79,
		["118"] = 79,
		["120"] = 79,
		["122"] = 79,
		["123"] = 79,
		["124"] = 79,
		["126"] = 79,
		["128"] = 79,
		["129"] = 80,
		["130"] = 81,
		["131"] = 82,
		["132"] = 83,
		["134"] = 85,
		["135"] = 86,
		["136"] = 87,
		["137"] = 88,
		["141"] = 76,
		["145"] = 94,
		["146"] = 97,
		["147"] = 97,
		["148"] = 97,
		["149"] = 97,
		["150"] = 97,
		["151"] = 97,
		["152"] = 97,
		["153"] = 97,
		["154"] = 97,
		["155"] = 97,
		["156"] = 97,
		["157"] = 97,
		["158"] = 97,
		["159"] = 97,
		["160"] = 97,
		["161"] = 97,
		["162"] = 97,
		["163"] = 97,
		["164"] = 97,
		["165"] = 97,
		["166"] = 97,
		["167"] = 97,
		["168"] = 97,
		["169"] = 97,
		["170"] = 122,
		["171"] = 122,
		["172"] = 122,
		["173"] = 122,
		["174"] = 122,
		["175"] = 122,
		["176"] = 122,
		["177"] = 122,
		["178"] = 122,
		["179"] = 122,
		["180"] = 122,
		["181"] = 122,
		["182"] = 122,
		["183"] = 122,
		["184"] = 122,
		["185"] = 122,
		["186"] = 122,
		["187"] = 122,
		["188"] = 122,
		["189"] = 141,
		["190"] = 143,
		["191"] = 145,
		["193"] = 2,
	}
)
function Spawn(self, e)
	local f = Client:GetPlayerPortraitData(3)
	if not f then
		return
	end
	local g = f.unit_name
	local h = f.playerID
	local i = KeyValues.UnitsKv[g]
	if i == nil then
		i = KeyValues.CosmeticsKV[g]
	end
	local j = i
	if j == nil then
		return
	end
	local k = j.Model
	if k == nil then
		k = j.resource
	end
	local l = k
	local m = l
	local n = Wearable:getUnitPortraitReplaceModel(m, h)
	if n then
		m = n
	end
	local o = KeyValues.Portrait[m]
	if o == nil then
		o = {}
	end
	local p = c(o, KeyValues.PortraitCustom[m])
	if p == nil then
		return
	end
	local q = p.cameras.default or p.cameras.Default
	local r = Wearable:getUnitPortraitReplaceSkin(m, h)
	local s = tostring
	local t = j.Skin
	if t == nil then
		t = ""
	end
	local u = s(t)
	if r then
		u = tostring(r)
	end
	local v = {}
	local w = {
		classname = "portrait_world_unit",
		targetname = "portraitUnit",
		origin = "0 0 0",
		model = m,
		skin = u,
		EnableAutoStyles = 0,
		ModelScale = 1,
		suppress_intro_effects = 1,
		spawn_background_models = 0,
		rare_loadout_anim_chance = -1,
		suppress_anim_event_sounds = 0,
		skip_pet_spawn = 0,
		flying_courier = 0,
		spawn_wearable_item_defs = 1,
		activity = "ACT_DOTA_CAPTURE",
		activity_modifier = "",
		item_def0 = 0,
		style_index0 = 0,
		item_def1 = 0,
		style_index1 = 0,
		item_def2 = 0,
		style_index2 = 0,
		item_def3 = 0,
		style_index3 = 0,
		item_def4 = 0,
		style_index4 = 0,
		item_def5 = 0,
		style_index5 = 0,
		item_def6 = 0,
		style_index6 = 0,
		item_def7 = 0,
		style_index7 = 0,
		rendercolor = "255 255 255",
	}
	local x
	if j ~= nil then
		x = j.Creature
	end
	local y
	if x ~= nil then
		y = x.AttachWearables
	end
	local z = y
	if z == nil then
		z = {}
	end
	local A = z
	local B = Wearable:getUnitWearablesModifier(l, h)
	if B then
		do
			local C = 0
			while C <= 9 do
				local D = B[C + 1]
				if D then
					w["item_def" .. tostring(C)] = D
				end
				C = C + 1
			end
		end
	else
		do
			local C = 0
			while C <= 9 do
				local E = "item_def" .. tostring(C)
				local F = "style_index" .. tostring(C)
				local G = j["wearable" .. tostring(C + 1)]
				if G == nil then
					local H = A[tostring(C + 1)]
					if H ~= nil then
						H = H.ItemDef
					end
					local I = H
					if I == nil then
						I = -1
					end
					G = I
				end
				local D = G
				local J = j[("wearable" .. tostring(C + 1)) .. "style"]
				w[E] = D
				if J ~= nil then
					w[F] = J
				else
					local K = KeyValues.ItemsGame[tostring(D)]
					if K ~= nil then
						if K.visuals and K.visuals.skin then
							w[F] = K.visuals.skin
						end
					end
				end
				C = C + 1
			end
		end
	end
	table.insert(v, w)
	table.insert(
		v,
		{
			classname = "point_camera",
			targetname = "camera_1",
			origin = q.PortraitPosition,
			angles = q.PortraitAngles,
			fov = q.PortraitFOV,
			ZFar = q.PortraitFar or KeyValues.Portrait.default_entity_replacement.cameras.default.PortraitFar,
			ZNear = 4,
			UseScreenAspectRatio = 0,
			aspectRatio = 1,
			fogEnable = 0,
			fogColor = "0 0 0",
			fogStart = 2048,
			fogEnd = 4096,
			fogMaxDensity = 1,
			rendercolor = "128 128 128",
			override_shadow_farz = 0,
			dof_enabled = 0,
			dof_near_blurry = 250,
			dof_near_crisp = 550,
			dac_dof_far_crisp = 1200,
			dac_dof_far_blurry = 1600,
			dac_dof_tilt_to_ground = 0.75,
		}
	)
	table.insert(
		v,
		{
			classname = "env_global_light",
			targetname = "portrait_light",
			origin = p.PortraitLightPosition or KeyValues.Portrait.default_entity_replacement.PortraitLightPosition,
			angles = p.PortraitLightAngles or KeyValues.Portrait.default_entity_replacement.PortraitLightPosition,
			fov = p.PortraitLightFOV or KeyValues.Portrait.default_entity_replacement.PortraitLightFOV,
			nearz = p.PortraitLightDistance or KeyValues.Portrait.default_entity_replacement.PortraitLightDistance,
			Color = p.PortraitLightColor or KeyValues.Portrait.default_entity_replacement.PortraitLightColor,
			ambientcolor2 = p.PortraitShadowColor or KeyValues.Portrait.default_entity_replacement.PortraitShadowColor,
			ambientscale2 = p.PortraitShadowScale or KeyValues.Portrait.default_entity_replacement.PortraitShadowScale,
			ambientcolor1 = p.PortraitAmbientColor
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientColor,
			ambientscale1 = p.PortraitAmbientScale
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientScale,
			specularcolor = p.PortraitSpecularColor
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularColor,
			specularpower = p.PortraitSpecularPower
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularPower,
			specularangles = p.PortraitSpecularDirection
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularDirection,
			lightscale = p.PortraitLightScale or KeyValues.Portrait.default_entity_replacement.PortraitLightScale,
			groundscale = p.PortraitGroundShadowScale
				or KeyValues.Portrait.default_entity_replacement.PortraitGroundShadowScale,
			ambientangles = p.PortraitAmbientDirection
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientDirection,
		}
	)
	SpawnEntityListFromTableSynchronous(v)
	if p.PortraitParticle ~= nil then
		local L = ParticleManager:CreateParticle(p.PortraitParticle, PATTACH_ABSORIGIN_FOLLOW, thisEntity)
	end
end