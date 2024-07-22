local buttonWipe = CreateFrame("Frame")

function buttonWipe.func()
	if WipeBarsConfirm_DB.ActionBars.bar1 == true then
		-- action bar 1
		for i = 1,12 do PickupAction(i) PutItemInBackpack() ClearCursor() end
	end
	if WipeBarsConfirm_DB.ActionBars.bar2 == true then
		-- action bar 2
		for i = 61,72 do PickupAction(i) PutItemInBackpack() ClearCursor() end
	end
	if WipeBarsConfirm_DB.ActionBars.bar3 == true then
		-- action bar 3
		for i = 49,60 do PickupAction(i) PutItemInBackpack() ClearCursor() end
	end
	if WipeBarsConfirm_DB.ActionBars.bar4 == true then
		-- action bar 4
		for i = 25,36 do PickupAction(i) PutItemInBackpack() ClearCursor() end
	end
	if WipeBarsConfirm_DB.ActionBars.bar5 == true then
		-- action bar 5
		for i = 37,48 do PickupAction(i) PutItemInBackpack() ClearCursor() end
	end
	if WipeBarsConfirm_DB.ActionBars.bar6 == true then
		-- action bar 6
		for i = 145,156 do PickupAction(i) PutItemInBackpack() ClearCursor() end
	end
	if WipeBarsConfirm_DB.ActionBars.bar7 == true then
		-- action bar 7
		for i = 157,168 do PickupAction(i) PutItemInBackpack() ClearCursor() end
	end
	if WipeBarsConfirm_DB.ActionBars.bar8 == true then
		-- action bar 8
		for i = 169,180 do PickupAction(i) PutItemInBackpack() ClearCursor() end
	end
	if WipeBarsConfirm_DB.ActionBars.stance1 == true then
		-- stance bar 1
		for i = 73,84 do PickupAction(i) PutItemInBackpack() ClearCursor() end
	end
	if WipeBarsConfirm_DB.ActionBars.stance2 == true then
		-- stance bar 2
		for i = 97,108 do PickupAction(i) PutItemInBackpack() ClearCursor() end
	end
	if WipeBarsConfirm_DB.ActionBars.stance3 == true then
		-- stance bar 3
		for i = 109,120 do PickupAction(i) PutItemInBackpack() ClearCursor() end
	end
	if WipeBarsConfirm_DB.ActionBars.unknown1 == true then
		-- stance bar unknown
		for i = 13,24 do PickupAction(i) PutItemInBackpack() ClearCursor() end
		for i = 121,144 do PickupAction(i) PutItemInBackpack() ClearCursor() end
		for i = 181,255 do PickupAction(i) PutItemInBackpack() ClearCursor() end
	end
		--for i = 1,240 do PickupAction(i) PutItemInBackpack() ClearCursor() end
end

StaticPopupDialogs["WBC_WIPE_BARS"] = {
	text = "Are you sure you want to wipe all your current build action bars? This cannot be undone.",
	button1 = "Yes",
	button2 = "No",
	OnAccept = function()
		if UnitAffectingCombat("player") == true then
			print(ERR_NOT_IN_COMBAT);
			return
		else
			buttonWipe.func()
		end
 	end,
 	OnShow = function()
 		for k = 1,4 do
 			local bingus = _G["StaticPopup" .. 1]
 			local DialogText = _G["StaticPopup" .. k .. "Text"]:GetText()
 			if DialogText == StaticPopupDialogs["WBC_WIPE_BARS"].text then
 				bingus = _G["StaticPopup" .. k]
				buttonWipe.BackdropFrame:SetParent(bingus);
				buttonWipe.BackdropFrame:Show();
				buttonWipe.BackdropFrame:SetPoint("TOPLEFT", bingus, "TOPRIGHT", 0, 0);
 			end
 		end

 		for n = 1,8 do
 			_G["WBC_ActionBarCB" .. n]:SetChecked(_G["WipeBarsConfirm_DB"]["ActionBars"]["bar" .. n])
		end

 		for s = 1,3 do
 			_G["WBC_StanceBarCB" .. s]:SetChecked(_G["WipeBarsConfirm_DB"]["ActionBars"]["stance" .. s])
		end

		_G["WBC_UnkBarCB"]:SetChecked(_G["WipeBarsConfirm_DB"]["ActionBars"]["unknown" .. 1])

 	end,
 	OnHide = function()
		buttonWipe.BackdropFrame:Hide();
		buttonWipe.BackdropFrame:ClearAllPoints();
 	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
};

--WipeBarsConfirm_DB
local defaultsTable = {
	Talent = true,
	Editmode = true,
	ActionBars = {
		bar1 = true, -- 1,12
		bar2 = true, -- 61,72
		bar3 = true, -- 49,60
		bar4 = true, -- 25,36
		bar5 = true, -- 37,48
		bar6 = true, -- 145,156
		bar7 = true, -- 157,168
		bar8 = true, -- 169,180
		unknown1 = true, --  13,24
		--unknown2 = true, -- 121,144
		--unknown3 = true, -- 181,255 --just grab the rest
		stance1 = true, -- 73,84 -- cat, stealth, etc.
		stance2 = true, -- 97,108 -- bear
		stance3 = true, -- 109,120 -- moonkin
	},
};


buttonWipe.button = CreateFrame("Button", nil, UIParent, "UIPanelButtonTemplate")
buttonWipe.button:SetWidth(164)
buttonWipe.button:SetHeight(22)
buttonWipe.button:SetText("Wipe Action Bars")
buttonWipe.button:SetNormalFontObject("GameFontNormal")
buttonWipe.button:SetScript("OnClick", function(self, button)
	StaticPopup_Show("WBC_WIPE_BARS")
end)
buttonWipe.button:Hide()

buttonWipe.backdropInfo =
{
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
 	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
 	tile = true,
 	tileEdge = true,
 	tileSize = 8,
 	edgeSize = 8,
 	insets = { left = 1, right = 1, top = 1, bottom = 1 },
}

buttonWipe.BackdropFrame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
buttonWipe.BackdropFrame:SetPoint("TOPLEFT", nil, "TOPRIGHT", 0, 0)
buttonWipe.BackdropFrame:SetWidth(130*2)
buttonWipe.BackdropFrame:SetHeight((23*8)+(23*2))
buttonWipe.BackdropFrame:SetBackdrop(buttonWipe.backdropInfo)
buttonWipe.BackdropFrame:Hide()
buttonWipe.BackdropFrame:SetBackdropColor(0,0,0,1)

for n = 1,8 do

	buttonWipe.BackdropFrame.Checkbox = CreateFrame("CheckButton", "WBC_ActionBarCB" .. n , buttonWipe.BackdropFrame, "UICheckButtonTemplate");
	buttonWipe.BackdropFrame.Checkbox:ClearAllPoints();
	buttonWipe.BackdropFrame.Checkbox:SetPoint("TOPLEFT", 10, -23*n);
	getglobal(buttonWipe.BackdropFrame.Checkbox:GetName().."Text"):SetText(BINDING_HEADER_ACTIONBAR .. " " .. n);

	buttonWipe.BackdropFrame.Checkbox:SetScript("OnClick", function(self)
		if _G["WBC_ActionBarCB" .. n]:GetChecked() then
			_G["WipeBarsConfirm_DB"]["ActionBars"]["bar" .. n] = true;
		else
			_G["WipeBarsConfirm_DB"]["ActionBars"]["bar" .. n] = false;
		end
	end);

end

for s = 1,3 do

	buttonWipe.BackdropFrame.Checkbox = CreateFrame("CheckButton", "WBC_StanceBarCB" .. s , buttonWipe.BackdropFrame, "UICheckButtonTemplate");
	buttonWipe.BackdropFrame.Checkbox:ClearAllPoints();
	buttonWipe.BackdropFrame.Checkbox:SetPoint("TOPLEFT", 10+130, -23*s);
	getglobal(buttonWipe.BackdropFrame.Checkbox:GetName().."Text"):SetText(HUD_EDIT_MODE_STANCE_BAR_LABEL .. " " .. s);

	buttonWipe.BackdropFrame.Checkbox:SetScript("OnClick", function(self)
		if _G["WBC_StanceBarCB" .. s]:GetChecked() then
			_G["WipeBarsConfirm_DB"]["ActionBars"]["stance" .. s] = true;
		else
			_G["WipeBarsConfirm_DB"]["ActionBars"]["stance" .. s] = false;
		end
	end);

end


buttonWipe.BackdropFrame.Checkbox = CreateFrame("CheckButton", "WBC_UnkBarCB", buttonWipe.BackdropFrame, "UICheckButtonTemplate");
buttonWipe.BackdropFrame.Checkbox:ClearAllPoints();
buttonWipe.BackdropFrame.Checkbox:SetPoint("TOPLEFT", 10+130, -23*5);
getglobal(buttonWipe.BackdropFrame.Checkbox:GetName().."Text"):SetText(OTHER);

buttonWipe.BackdropFrame.Checkbox:SetScript("OnClick", function(self)
	if buttonWipe.BackdropFrame.Checkbox:GetChecked() then
		_G["WipeBarsConfirm_DB"]["ActionBars"]["unknown" .. 1] = true;
	else
		_G["WipeBarsConfirm_DB"]["ActionBars"]["unknown" .. 1] = false;
	end
end);

buttonWipe.BackdropFrame.SelectAll = CreateFrame("Button", nil, buttonWipe.BackdropFrame, "UIPanelButtonTemplate")
buttonWipe.BackdropFrame.SelectAll:SetSize(80 ,22) -- width, height
buttonWipe.BackdropFrame.SelectAll:SetText("Select all")
buttonWipe.BackdropFrame.SelectAll:SetPoint("TOPLEFT", 10+130, -23*8)
buttonWipe.BackdropFrame.SelectAll:SetScript("OnClick", function()
	WipeBarsConfirm_DB.ActionBars = defaultsTable.ActionBars;

	for n = 1,8 do
		_G["WBC_ActionBarCB" .. n]:SetChecked(true)
	end

	for s = 1,3 do
		_G["WBC_StanceBarCB" .. s]:SetChecked(true)
	end

	_G["WBC_UnkBarCB"]:SetChecked(true)

end)



--BINDING_HEADER_ACTIONBAR
--HUD_EDIT_MODE_STANCE_BAR_LABEL
--MENU_EDIT_SELECT_ALL


local WipeBarsPanel = CreateFrame("Frame");
WipeBarsPanel.name = "Wipe Bars Confirm";

WipeBarsPanel.Headline = WipeBarsPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal");
WipeBarsPanel.Headline:SetFont(WipeBarsPanel.Headline:GetFont(), 23);
WipeBarsPanel.Headline:SetTextColor(0,1,0,1);
WipeBarsPanel.Headline:ClearAllPoints();
WipeBarsPanel.Headline:SetPoint("TOPLEFT", WipeBarsPanel, "TOPLEFT",12,-12);
WipeBarsPanel.Headline:SetText("Wipe Bars Confirm");

WipeBarsPanel.Version = WipeBarsPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal");
WipeBarsPanel.Version:SetFont(WipeBarsPanel.Version:GetFont(), 12);
WipeBarsPanel.Version:SetTextColor(1,1,1,1);
WipeBarsPanel.Version:ClearAllPoints();
WipeBarsPanel.Version:SetPoint("TOPLEFT", WipeBarsPanel, "TOPLEFT",400,-21);
WipeBarsPanel.Version:SetText("Version" .. ": " .. C_AddOns.GetAddOnMetadata("WipeBarsConfirm", "Version"));

WipeBarsPanel.TalentCheckbox = CreateFrame("CheckButton", "WBCTalentCheckbox", WipeBarsPanel, "UICheckButtonTemplate");
WipeBarsPanel.TalentCheckbox:ClearAllPoints();
WipeBarsPanel.TalentCheckbox:SetPoint("TOPLEFT", 350, -53);
getglobal(WipeBarsPanel.TalentCheckbox:GetName().."Text"):SetText(TALENTS);

WipeBarsPanel.TalentCheckbox:SetScript("OnClick", function(self)
	if WipeBarsPanel.TalentCheckbox:GetChecked() then
		WipeBarsConfirm_DB.Talent = true;
	else
		WipeBarsConfirm_DB.Talent = false;
		buttonWipe.button:Hide();
		buttonWipe.button:ClearAllPoints();
	end
end);

WipeBarsPanel.EditmodeCheckbox = CreateFrame("CheckButton", "WBCEditmodeCheckbox", WipeBarsPanel, "UICheckButtonTemplate");
WipeBarsPanel.EditmodeCheckbox:ClearAllPoints();
WipeBarsPanel.EditmodeCheckbox:SetPoint("TOPLEFT", 350/2, -53);
getglobal(WipeBarsPanel.EditmodeCheckbox:GetName().."Text"):SetText(HUD_EDIT_MODE_MENU);

WipeBarsPanel.EditmodeCheckbox:SetScript("OnClick", function(self)
	if WipeBarsPanel.EditmodeCheckbox:GetChecked() then
		WipeBarsConfirm_DB.Editmode = true;
	else
		WipeBarsConfirm_DB.Editmode = false;
		buttonWipe.button:Hide()
		buttonWipe.button:ClearAllPoints();
	end
end);

local category, layout = Settings.RegisterCanvasLayoutCategory(WipeBarsPanel, WipeBarsPanel.name, WipeBarsPanel.name);
category.ID = WipeBarsPanel.name;
Settings.RegisterAddOnCategory(category)

function buttonWipe.TalentFrameEventFrame()
	if UnitAffectingCombat("player") ~= true and WipeBarsConfirm_DB.Talent == true then
		buttonWipe.button:SetParent(PlayerSpellsFrame.TalentsFrame)
		buttonWipe.button:Show()
		buttonWipe.button:SetPoint("LEFT", PlayerSpellsFrame.TalentsFrame.SearchBox, "RIGHT", 15, 0)
	else
		return
	end
end

function buttonWipe.EditModeEventFrame()
	if UnitAffectingCombat("player") ~= true and WipeBarsConfirm_DB.Editmode == true then
		buttonWipe.button:SetParent(EditModeManagerFrame)
		buttonWipe.button:Show()
		buttonWipe.button:SetPoint("CENTER", EditModeManagerFrame, "TOPRIGHT", -75, -40)
	else
		return
	end
end

EventRegistry:RegisterCallback('PlayerSpellsFrame.TalentTab.Show', buttonWipe.TalentFrameEventFrame)
EventRegistry:RegisterCallback('EditMode.Enter', buttonWipe.EditModeEventFrame)

SLASH_WIPEBARS1 = "/wipebars"
SlashCmdList["WIPEBARS"] = function(msg)
	if UnitAffectingCombat("player") == true then
		print(ERR_NOT_IN_COMBAT);
		return
	else
		StaticPopup_Show("WBC_WIPE_BARS");
	end
end

local startup = CreateFrame("Frame");
startup:RegisterEvent("ADDON_LOADED");
startup:RegisterEvent("PLAYER_REGEN_DISABLED");
startup:RegisterEvent("PLAYER_REGEN_ENABLED");

function startup:OnEvent(event,arg1)
	if event == "ADDON_LOADED" and arg1 == "WipeBarsConfirm" then
		if not WipeBarsConfirm_DB then
			WipeBarsConfirm_DB = defaultsTable;
		end

		if not WipeBarsConfirm_DB.ActionBars then
			WipeBarsConfirm_DB.ActionBars = defaultsTable.ActionBars;
		end

		WipeBarsPanel.TalentCheckbox:SetChecked(WipeBarsConfirm_DB.Talent);
		WipeBarsPanel.EditmodeCheckbox:SetChecked(WipeBarsConfirm_DB.Editmode);
	end
	if event == "PLAYER_REGEN_DISABLED" then
		buttonWipe.button:Hide()
		buttonWipe.button:ClearAllPoints();
	end
end

startup:SetScript("OnEvent", startup.OnEvent);