AddCSLuaFile()

if SERVER then
	resource.AddFile("materials/vgui/ttt/icon_surv.vmt")
	resource.AddFile("materials/vgui/ttt/sprite_surv.vmt")
end

-- important to add roles with this function,
-- because it does more than just access the array ! e.g. updating other arrays
InitCustomRole("SURVIVALIST", { -- first param is access for ROLES array => ROLES["SURVIVALIST"] or SURVIVALIST
		color = Color(255, 127, 80, 255), -- ...
		dkcolor = Color(190, 62, 14, 255), -- ...
		bgcolor = Color(55, 176, 121, 255), -- ...
		abbr = "surv", -- abbreviation
		defaultTeam = TEAM_INNOCENT, -- the team name: roles with same team name are working together
		defaultEquipment = SPECIAL_EQUIPMENT, -- here you can set up your own default equipment
		radarColor = Color(150, 150, 150), -- color if someone is using the radar
		surviveBonus = 0, -- bonus multiplier for every survive while another player was killed
		scoreKillsMultiplier = 1, -- multiplier for kill of player of another team
		scoreTeamKillsMultiplier = -8, -- multiplier for teamkill
		unknownTeam = true -- player don't know their teammates
	}, {
		pct = 0.15, -- necessary: percentage of getting this role selected (per player)
		maximum = 2, -- maximum amount of roles in a round
		minPlayers = 7, -- minimum amount of players until this role is able to get selected
		credits = 1, -- the starting credits of a specific role
		togglable = true, -- option to toggle a role for a client if possible (F1 menu)
		shopFallback = SHOP_FALLBACK_DETECTIVE
})

-- now link this subrole with its baserole
hook.Add("TTT2BaseRoleInit", "TTT2ConBRIWithSurv", function()
	SetBaseRole(SURVIVALIST, ROLE_INNOCENT)
end)

if CLIENT then
	hook.Add("TTT2FinishedLoading", "SurvInitT", function()
		-- setup here is not necessary but if you want to access the role data, you need to start here
		-- setup basic translation !
		LANG.AddToLanguage("English", SURVIVALIST.name, "Survivalist")
		LANG.AddToLanguage("English", "info_popup_" .. SURVIVALIST.name,
			[[You are a Survivalist!
				Try to survive and protect your mates if possible!]])
		LANG.AddToLanguage("English", "body_found_" .. SURVIVALIST.abbr, "This was a Survivalist...")
		LANG.AddToLanguage("English", "search_role_" .. SURVIVALIST.abbr, "This person was a Survivalist!")
		LANG.AddToLanguage("English", "target_" .. SURVIVALIST.name, "Survivalist")
		LANG.AddToLanguage("English", "ttt2_desc_" .. SURVIVALIST.name, [[The Survivalist is a better innocent, because he is able to access his own ([C]) shop.
	Try to protect the innocents!]])

		---------------------------------

		-- maybe this language as well...
		LANG.AddToLanguage("Deutsch", SURVIVALIST.name, "Überlebender")
		LANG.AddToLanguage("Deutsch", "info_popup_" .. SURVIVALIST.name,
			[[Du bist ein Überlebender!
				Versuche zu überleben und beschütze dein Team, wenn es möglich sein sollte!]])
		LANG.AddToLanguage("Deutsch", "body_found_" .. SURVIVALIST.abbr, "Er war ein Überlebender...")
		LANG.AddToLanguage("Deutsch", "search_role_" .. SURVIVALIST.abbr, "Diese Person war ein Überlebender!")
		LANG.AddToLanguage("Deutsch", "target_" .. SURVIVALIST.name, "Überlebender")
		LANG.AddToLanguage("Deutsch", "ttt2_desc_" .. SURVIVALIST.name, [[Der Überlebender ist ein besserer Unschuldiger (oder sogar ein besserer Detektiv), denn er hat seinen eigenen ([C]) Shop.
	Versuche, die Unschuldigen zu beschützen!]])
	end)
end

-- nothing special, just a inno that is able to access the [C] shop
