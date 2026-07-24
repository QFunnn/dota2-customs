--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


local skinID = _G.ProfileSkinID
local scale = 1
local camera = "camera_1"

function Spawn(params)
	local tKV = KeyValues.HeroSkinKV[skinID]
	if tKV == nil then return end
	local model = tKV.model
	local defaultData = KeyValues.PortraitFullBodyLoadout.npc_dota_hero_abaddon
	local tPortraitData = KeyValues.PortraitFullBodyLoadout[model] or defaultData
	if tPortraitData == nil then return end
	local tCameraData = tPortraitData.cameras[camera] or tPortraitData.cameras.default or tPortraitData.cameras.Default
	if not tCameraData then return end

	local t = {}
	local tData = {
		parentname = "root",
		targetname = "",
		classname = "prop_dynamic",
		origin = "0 0 0",
		angles = "0 0 0",
		scales = scale .. " " .. scale .. " " .. scale,
		model = model,
		rendertocubemaps = "1",
		lightmapstatic = "1",
		add_modifier = "",
		StartingAnim = "ACT_DOTA_IDLE",
		StartingAnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
	}

	table.insert(t, tData)

	-- 摄像头
	table.insert(t, {
		-- parentname = "root",
		classname = "point_camera",
		targetname = camera,
		origin = tCameraData.PortraitPosition,
		angles = tCameraData.PortraitAngles,
		fov = tCameraData.PortraitFOV,
		ZFar = tCameraData.PortraitFar or defaultData.cameras.default.PortraitFar,
		ZNear = 4,
		UseScreenAspectRatio = 0,
		aspectRatio = 0,
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
	})
	-- 光源
	local vSpecularDirection = StringToVector(tPortraitData.PortraitSpecularDirection or defaultData.PortraitSpecularDirection) or vec3_zero
	local aSpecularAngles = VectorToAngles(vSpecularDirection)
	local vAmbientDirection = StringToVector(tPortraitData.PortraitAmbientDirection or defaultData.PortraitAmbientDirection) or vec3_zero
	local aAmbientAngles = VectorToAngles(vAmbientDirection)
	table.insert(t, {
		-- parentname = "root",
		classname = "env_global_light",
		targetname = "portrait_light",
		origin = tPortraitData.PortraitLightPosition or defaultData.PortraitLightPosition,
		angles = tPortraitData.PortraitLightAngles or defaultData.PortraitLightAngles,
		fov = tPortraitData.PortraitLightFOV or defaultData.PortraitLightFOV,
		nearz = tPortraitData.PortraitLightDistance or defaultData.PortraitLightDistance,
		Color = tPortraitData.PortraitLightColor or defaultData.PortraitLightColor,
		ambientcolor2 = tPortraitData.PortraitShadowColor or defaultData.PortraitShadowColor,
		ambientscale2 = tPortraitData.PortraitShadowScale or defaultData.PortraitShadowScale,
		ambientcolor1 = tPortraitData.PortraitAmbientColor or defaultData.PortraitAmbientColor,
		ambientscale1 = tPortraitData.PortraitAmbientScale or defaultData.PortraitAmbientScale,
		specularcolor = tPortraitData.PortraitSpecularColor or defaultData.PortraitSpecularColor,
		specularpower = tPortraitData.PortraitSpecularPower or defaultData.PortraitSpecularPower,
		specularangles = aSpecularAngles,
		lightscale = tPortraitData.PortraitLightScale or defaultData.PortraitLightScale,
		groundscale = tPortraitData.PortraitGroundShadowScale or defaultData.PortraitGroundShadowScale,
		ambientangles = aAmbientAngles,
	})
	SpawnEntityListFromTableSynchronous(t)
end