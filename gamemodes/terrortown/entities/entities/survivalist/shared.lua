AddCSLuaFile()

if SERVER then
   resource.AddFile("materials/vgui/ttt/icon_surv.vmt")
   resource.AddFile("materials/vgui/ttt/sprite_surv.vmt")
end

-- if sync of roles has finished
hook.Add("TTT2_FinishedSync", "SurvInitT", function(first)
	if CLIENT and first then -- just on client and first init !

		-- setup here is not necessary but if you want to access the role data, you need to start here
		-- setup basic translation !
		LANG.AddToLanguage("English", ROLES.SURVIVALIST.name, "Survivalist")
		LANG.AddToLanguage("English", "info_popup_" .. ROLES.SURVIVALIST.name, 
            [[You are a Survivalist! 
            Try to survive and protect your mates if possible!]])
		LANG.AddToLanguage("English", "body_found_" .. ROLES.SURVIVALIST.abbr, "This was a Survivalist...")
		LANG.AddToLanguage("English", "search_role_" .. ROLES.SURVIVALIST.abbr, "This person was a Survivalist!")
	    
	    -- optional for toggling whether player can avoid the role
		LANG.AddToLanguage("English", "set_avoid_" .. ROLES.SURVIVALIST.abbr, "Avoid being selected as Survivalist!")
		LANG.AddToLanguage("English", "set_avoid_" .. ROLES.SURVIVALIST.abbr .. "_tip", 
	        [[Enable this to ask the server not to select you as Survivalist if possible. Does not mean you are Traitor more often.]])
	    
	    ---------------------------------

		-- maybe this language as well...
		LANG.AddToLanguage("Deutsch", ROLES.SURVIVALIST.name, "Überlebenskünstler")
		LANG.AddToLanguage("Deutsch", "info_popup_" .. ROLES.SURVIVALIST.name, 
            [[Du bist ein Überlebenskünstler! 
            Versuche zu überleben und beschütze dein Team, wenn es möglich sein sollte!]])
		LANG.AddToLanguage("Deutsch", "body_found_" .. ROLES.SURVIVALIST.abbr, "Er war ein Überlebenskünstler...")
		LANG.AddToLanguage("Deutsch", "search_role_" .. ROLES.SURVIVALIST.abbr, "Diese Person war ein Überlebenskünstler!")
	    
		LANG.AddToLanguage("Deutsch", "set_avoid_" .. ROLES.SURVIVALIST.abbr, "Vermeide als Überlebenskünstler ausgewählt zu werden!")
		LANG.AddToLanguage("Deutsch", "set_avoid_" .. ROLES.SURVIVALIST.abbr .. "_tip", 
	        [[Aktivieren, um beim Server anzufragen, nicht als Überlebenskünstler ausgewählt zu werden. Das bedeuted nicht, dass du öfter Traitor wirst!]])
	end
end)

-- optional
CreateClientConVar("ttt_avoid_survivalist", "0", true, true) -- should be "ttt_avoid_" .. name ; if enabled: option to disable role if possible will be enabled

if SERVER then

	-- add CVars ! necessary for calculation
	CreateConVar("ttt_survivalist_pct", "0.13", FCVAR_NOTIFY)  -- should be "ttt_" .. name .. "_pct"
	CreateConVar("ttt_survivalist_max", "2")                   -- should be "ttt_" .. name .. "_max"
	CreateConVar("ttt_survivalist_min_players", "2")           -- should be "ttt_" .. name .. "_min_players"

    CreateConVar("ttt_survivalist_credits_starting", "1") -- needed if role is able to access the [C] shop

	-- necessary to init roles in this way, because we need to wait until the ROLES array is initialized 
	-- and every important function works properly
	hook.Add("TTT2_RoleInit", "AddSurvRole", function() -- unique hook identifier please
		if not ROLES["SURVIVALIST"] then

			-- important to add roles with this function,
			-- because it does more than just access the array ! e.g. updating other arrays
			AddCustomRole("SURVIVALIST", { -- first param is access for ROLES array => ROLES["SURVIVALIST"] or ROLES["JESTER"]
				color = Color(255, 127, 80, 255), -- ...
				dkcolor = Color(255, 105, 51, 255), -- ...
				bgcolor = Color(255, 165, 0, 200), -- ...
				name = "survivalist", -- just a unique name for the script to determine
				printName = "Survivalist", -- The text that is printed to the player, e.g. in role alert
				abbr = "surv", -- abbreviation
				shop = true, -- can the role access the [C] shop ? -> credits should be set
				team = TEAM_INNO, -- the team name: roles with same team name are working together
				moreThanOne = true, -- this should always be false
				defaultEquipment = SPECIAL_EQUIPMENT, -- here you can set up your own default equipment
                radarColor = Color(150, 150, 150), -- color if someone is using the radar
                surviveBonus = 0, -- bonus multiplier for every survive while another player was killed
                scoreKillsMultiplier = 1, -- multiplier for kill of player of another team
                scoreTeamKillsMultiplier = -8 -- multiplier for teamkill
			})
		end
	end)
    
    -- nothing special, just a inno that is able to access the [C] shop
end
