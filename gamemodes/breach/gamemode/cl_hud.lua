
local hide = {
	CHudHealth = true,
	CHudBattery = true,
	CHudAmmo = true,
	CHudSecondaryAmmo = true,
	//CHudWeaponSelection = true,
	CHudDeathNotice = true
	//CHudWeapon = true
}

surface.CreateFont("ImpactBig", {font = "Impact",
                                  size = 45,
                                  weight = 700})
surface.CreateFont("ImpactSmall", {font = "Impact",
                                  size = 30,
                                  weight = 700})

surface.CreateFont( "RadioFont", {
	font = "Impact",
	extended = false,
	size = 26,
	weight = 7000,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

function GM:DrawDeathNotice( x,  y )
end

hook.Add( "HUDShouldDraw", "HideHUD", function( name )
	if ( hide[ name ] ) then return false end
end )

endmessages = {
	{
		main = clang.lang_end1,
		txt = clang.lang_end2,
		clr = gteams.GetColor(TEAM_SCP)
	},
	{
		main = clang.lang_end1,
		txt = clang.lang_end3,
		clr = gteams.GetColor(TEAM_SCP)
	}
}

function DrawInfo(pos, txt, clr)
	pos = pos:ToScreen()
	draw.TextShadow( {
		text = txt,
		pos = { pos.x, pos.y },
		font = "HealthAmmo",
		color = clr,
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	}, 2, 255 )
end

hook.Add( "Tick", "966check", function()
	local hide = true
	if LocalPlayer().GTeam == nil then return end
	if LocalPlayer():GTeam() == TEAM_SCP then
		hide = false
	end
	if IsValid(LocalPlayer():GetActiveWeapon()) then
		if LocalPlayer():GetActiveWeapon():GetClass() == "item_nvg" then
			hide = false
		end
	end
	for k,v in pairs(player.GetAll()) do
		if not v.GetNClass then
			player_manager.RunClass( v, "SetupDataTables" )
		end
		if v.GetNClass == nil then return end
		if v:GetNClass() == ROLES.ROLE_SCP966 then
			v:SetNoDraw(hide)
		end
	end
end )

local info1 = Material( "breach/info_mtf.png")
hook.Add( "HUDPaint", "Breach_DrawHUD", function()
	//cam.Start3D()
	//	for id, ply in pairs( player.GetAll() ) do
	//		if ply:GetNClass() == ROLES.ROLE_SCP966 then
	//			ply:DrawModel()
	//		end
	//	end
	//cam.End3D()
	if disablehud == true then return end
	if POS_914B_BUTTON != nil and isstring(buttonstatus) then
		if LocalPlayer():GetPos():Distance(POS_914B_BUTTON) < 200 then
			DrawInfo(POS_914B_BUTTON, buttonstatus, Color(255,255,255))
		end
	end
	
	/*
	for k,v in pairs(SPAWN_ARMORS) do
		DrawInfo(v, "Armor", Color(255,255,255))
	end
	
	for k,v in pairs(SPAWN_FIREPROOFARMOR) do
		DrawInfo(v, "FArmor", Color(255,255,255))
	end
	
	
	if BUTTONS != nil then
		for k,v in pairs(BUTTONS) do
			DrawInfo(v.pos, v.name, Color(0,255,50))
		end
		
		
		for k,v in pairs(SPAWN_KEYCARD2) do
			for _,v2 in pairs(v) do
				DrawInfo(v2, "Keycard2", Color(255,255,0))
			end
		end
		for k,v in pairs(SPAWN_KEYCARD3) do
			for _,v2 in pairs(v) do
				DrawInfo(v2, "Keycard3", Color(255,120,0))
			end
		end
		for k,v in pairs(SPAWN_KEYCARD4) do
			for _,v2 in pairs(v) do
				DrawInfo(v2, "Keycard4", Color(255,0,0))
			end
		end
		
		
		for k,v in pairs(SPAWN_SMGS) do
			DrawInfo(v, "SMG", Color(255,255,255))
		end
		for k,v in pairs(SPAWN_RIFLES) do
			DrawInfo(v, "RIFLE", Color(0,255,255))
		end
		
	end
	*/
	/*
	if #player.GetAll() < MINPLAYERS then
		draw.TextShadow( {
			text = "Not enough players to start the round",
			pos = { ScrW() / 2, ScrH() / 15 },
			font = "ImpactBig",
			color = Color(255,255,255),
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_CENTER,
		}, 2, 255 )
		draw.TextShadow( {
			text = "Waiting for more players to join the server",
			pos = { ScrW() / 2, ScrH() / 15 + 45 },
			font = "ImpactSmall",
			color = Color(255,255,255),
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_CENTER,
		}, 2, 255 )
		return
	
	elseif gamestarted == false then
		draw.TextShadow( {
			text = "Game is starting",
			pos = { ScrW() / 2, ScrH() / 15 },
			font = "ImpactBig",
			color = Color(255,128,70),
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_CENTER,
		}, 2, 255 )
		draw.TextShadow( {
			text = "Wait for the round to start",
			pos = { ScrW() / 2, ScrH() / 15 + 45 },
			font = "ImpactSmall",
			color = Color(255,255,255),
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_CENTER,
		}, 2, 255 )
		return
	end
	*/
	
	if shoulddrawinfo == true then
		local getrl = LocalPlayer():GetNClass()
		for k,v in pairs(ROLES) do
			if v == getrl then
				getrl = k
			end
		end
		for k,v in pairs(clang.starttexts) do
			if k == getrl then
				getrl = v
				break
			end
		end
		local align = 32
		local tcolor = gteams.GetColor(LocalPlayer():GTeam())
		if LocalPlayer():GTeam() == TEAM_CHAOS then
			tcolor = Color(29, 81, 56)
		end
		
		
		
		if getrl[1] != nil then
			draw.TextShadow( {
				text = getrl[1],
				pos = { ScrW() / 2, ScrH() / 15 },
				font = "ImpactBig",
				color = tcolor,
				xalign = TEXT_ALIGN_CENTER,
				yalign = TEXT_ALIGN_CENTER,
			}, 2, 255 )
		end
		for i,txt in ipairs(getrl[2]) do
			draw.TextShadow( {
				text = txt,
				pos = { ScrW() / 2, ScrH() / 15 + 10 + (align * i) },
				font = "ImpactSmall",
				color = Color(255,255,255),
				xalign = TEXT_ALIGN_CENTER,
				yalign = TEXT_ALIGN_CENTER,
			}, 2, 255 )
		end
		/*
		if roundtype != nil then
			draw.TextShadow( {
				text = string.Replace( clang.roundtype,  "{type}", roundtype ),
				pos = { ScrW() / 2, ScrH() - 25 },
				font = "ImpactSmall",
				color = Color(255, 130, 0),
				xalign = TEXT_ALIGN_CENTER,
				yalign = TEXT_ALIGN_CENTER,
			}, 2, 255 )
		end
		*/
	end
	if isnumber(drawendmsg) then
		local ndtext = clang.lang_end2
		if drawendmsg == 2 then
			ndtext = clang.lang_end3
		end
		//if clang.endmessages[drawendmsg] then
			shoulddrawinfo = false
			draw.TextShadow( {
				text = clang.lang_end1,
				pos = { ScrW() / 2, ScrH() / 15 },
				font = "ImpactBig",
				color = Color(0,255,0),
				xalign = TEXT_ALIGN_CENTER,
				yalign = TEXT_ALIGN_CENTER,
			}, 2, 255 )
			draw.TextShadow( {
				text = ndtext,
				pos = { ScrW() / 2, ScrH() / 15 + 45 },
				font = "ImpactSmall",
				color = Color(255,255,255),
				xalign = TEXT_ALIGN_CENTER,
				yalign = TEXT_ALIGN_CENTER,
			}, 2, 255 )
			for i,txt in ipairs(endinformation) do
				draw.TextShadow( {
					text = txt,
					pos = { ScrW() / 2, ScrH() / 8 + (35 * i)},
					font = "ImpactSmall",
					color = color_white,
					xalign = TEXT_ALIGN_CENTER,
					yalign = TEXT_ALIGN_CENTER,
				}, 2, 255 )
			end
		//else
		//	drawendmsg = nil
		//end
	else
		if isnumber(shoulddrawescape) then
			if CurTime() > lastescapegot then
				shoulddrawescape = nil
			end
			if clang.escapemessages[shoulddrawescape] then
				local tab = clang.escapemessages[shoulddrawescape]
				draw.TextShadow( {
					text = tab.main,
					pos = { ScrW() / 2, ScrH() / 15 },
					font = "ImpactBig",
					color = tab.clr,
					xalign = TEXT_ALIGN_CENTER,
					yalign = TEXT_ALIGN_CENTER,
				}, 2, 255 )
				draw.TextShadow( {
					text = string.Replace( tab.txt, "{t}", string.ToMinutesSecondsMilliseconds(esctime) ),
					pos = { ScrW() / 2, ScrH() / 15 + 45 },
					font = "ImpactSmall",
					color = Color(255,255,255),
					xalign = TEXT_ALIGN_CENTER,
					yalign = TEXT_ALIGN_CENTER,
				}, 2, 255 )
				draw.TextShadow( {
					text = tab.txt2,
					pos = { ScrW() / 2, ScrH() / 15 + 75 },
					font = "ImpactSmall",
					color = Color(255,255,255),
					xalign = TEXT_ALIGN_CENTER,
					yalign = TEXT_ALIGN_CENTER,
				}, 2, 255 )
			end
		end
	end
	local ply = LocalPlayer()
	if ply:Alive() == false then return end
	
	if ply:GTeam() == TEAM_SPEC then
		local ent = ply:GetObserverTarget()
		if IsValid(ent) then
			if ent:IsPlayer() then
				local sw = 350
				local sh = 35
				local sx =  ScrW() / 2 - (sw / 2)
				local sy = 0
				draw.RoundedBox(0, sx, sy, sw, sh, Color(50,50,50,255))
				draw.TextShadow( {
					text = string.sub(ent:Nick(), 1, 17),
					pos = { sx + sw / 2, 15 },
					font = "HealthAmmo",
					color = Color(255,255,255),
					xalign = TEXT_ALIGN_CENTER,
					yalign = TEXT_ALIGN_CENTER,
				}, 2, 255 )
			end
		end
		//return
	end 
	local wep = nil
	local ammo = -1
	local ammo2 = -1
	
	local width = 350
	local height = 120
	local role_width = width - 25
	
	local x,y
	x = 10
	y = ScrH() - height - 10
	local hl = math.Clamp(LocalPlayer():Health(), 1, LocalPlayer():GetMaxHealth()) / LocalPlayer():GetMaxHealth()
	if hl < 0.06 then hl = 0.06 end
	
	local name = "None"
	if not ply.GetNClass then
		player_manager.RunClass( ply, "SetupDataTables" )
	elseif LocalPlayer():GTeam() != TEAM_SPEC then
		name = GetLangRole(ply:GetNClass())
		/*
		if ply:GTeam() == TEAM_CHAOS then
			name = GetLangRole(ROLES.ROLE_CHAOS)
			//if ply:GetNClass() == ROLE_MTFNTF then
			//	name = "MTF NTF (SPY)"
			//end
		end
		*/
	else
		local obs = ply:GetObserverTarget()
		if IsValid(obs) then
			if obs.GetNClass != nil then
				name = GetLangRole(obs:GetNClass())
				ply = obs
			else
				name = GetLangRole(ply:GetNClass())
			end
		else
			name = GetLangRole(ply:GetNClass())
		end
	end
	local color = gteams.GetColor( ply:GTeam() )
	if ply:GTeam() == TEAM_CHAOS then
		color = Color(29, 81, 56)
	end
	draw.RoundedBox(0, x, y, width, height, Color(0,0,10,200))
	draw.RoundedBox(0, x, y, role_width - 70, 30, color )
	
	draw.TextShadow( {
		text = name,
		pos = { role_width / 2 - 30, y + 12.5 },
		font = "ClassName",
		color = Color(255,255,255),
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	}, 2, 255 )
	
	local tclr = Color(255,255,255)
	draw.TextShadow( {
		text = tostring(string.ToMinutesSeconds( cltime )),
		pos = { width - 68, y + 4 },
		font = "TimeLeft",
		color = tclr,
		xalign = TEXT_ALIGN_TOP,
		yalign = TEXT_ALIGN_TOP,
	}, 2, 255 )
	
	// Health bar
	draw.RoundedBox(0, 25, y + 40, width - 30, 27, Color(50,0,0,255))
	draw.RoundedBox(0, 25, y + 40, (width - 30) * hl, 27, Color(255,0,0,255))
	draw.TextShadow( {
		text = ply:Health(),
		pos = { width - 20, y + 40 },
		font = "HealthAmmo",
		color = Color(255,255,255),
		xalign = TEXT_ALIGN_RIGHT,
		yalign = TEXT_ALIGN_RIGHT,
	}, 2, 255 )
	
	local ammotext = nil
	local wep = nil
	
	
	if ply:GetActiveWeapon() != nil and #ply:GetWeapons() > 0 then
		wep = ply:GetActiveWeapon()
		if wep then
			if wep.Clip1 == nil then return end
			if wep:Clip1() > -1 then
				ammo1 = wep:Clip1()
				ammo2 = ply:GetAmmoCount( wep:GetPrimaryAmmoType() )
				ammotext = ammo1 .. " + ".. ammo2
			end
		end
	end
	
	if not ammotext then return end
	local am = math.Clamp(wep:Clip1(), 0, wep:GetMaxClip1()) / wep:GetMaxClip1()
	
	// Ammo
	draw.RoundedBox(0, 25, y + 75, width - 30, 27, Color(20,20,5,222))
	draw.RoundedBox(0, 25, y + 75, (width - 30) * am, 27, Color(205, 155, 0, 255))
	draw.TextShadow( {
		text = ammotext,
		pos = { width - 20, y + 75 },
		font = "HealthAmmo",
		color = Color(255,255,255),
		xalign = TEXT_ALIGN_RIGHT,
		yalign = TEXT_ALIGN_RIGHT,
	}, 2, 255 )
	
end )

