StaticPopupDialogs["WBC_WIPE_BARS"] = {
	text = "Are you sure you want to wipe all your current build action bars? This cannot be undone.",
	button1 = "Yes",
	button2 = "No",
	OnAccept = function()
		if UnitAffectingCombat("player") == true then
			print(ERR_NOT_IN_COMBAT);
			return
		else
			for i = 1,120 do PickupAction(i) PutItemInBackpack() ClearCursor() end
		end
 	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
}

--WipeBarsConfirm_DB
local defaultsTable = {
	Talent = true,
	Editmode = true,
};

local buttonWipe = CreateFrame("Frame")
buttonWipe.button = CreateFrame("Button", nil, UIParent)
buttonWipe.button:SetWidth(130)
buttonWipe.button:SetHeight(25)
buttonWipe.button:SetText("Wipe Action Bars")
buttonWipe.button:SetNormalFontObject("GameFontNormal")

buttonWipe.button.ntex = buttonWipe.button:CreateTexture()
buttonWipe.button.ntex:SetTexture("Interface/Buttons/UI-Panel-Button-Up")
buttonWipe.button.ntex:SetTexCoord(0, 0.625, 0, 0.6875)
buttonWipe.button.ntex:SetAllPoints()
buttonWipe.button:SetNormalTexture(buttonWipe.button.ntex)

buttonWipe.button.htex = buttonWipe.button:CreateTexture()
buttonWipe.button.htex:SetTexture("Interface/Buttons/UI-Panel-Button-Highlight")
buttonWipe.button.htex:SetTexCoord(0, 0.625, 0, 0.6875)
buttonWipe.button.htex:SetAllPoints()
buttonWipe.button:SetHighlightTexture(buttonWipe.button.htex)

buttonWipe.button.ptex = buttonWipe.button:CreateTexture()
buttonWipe.button.ptex:SetTexture("Interface/Buttons/UI-Panel-Button-Down")
buttonWipe.button.ptex:SetTexCoord(0, 0.625, 0, 0.6875)
buttonWipe.button.ptex:SetAllPoints()
buttonWipe.button:SetPushedTexture(buttonWipe.button.ptex)
buttonWipe.button:SetScript("OnClick", function(self, button)
	StaticPopup_Show("WBC_WIPE_BARS")
end)
buttonWipe.button:Hide()

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
WipeBarsPanel.Version:SetText("Version" .. ": " .. GetAddOnMetadata("WipeBarsConfirm", "Version"));

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


InterfaceOptions_AddCategory(WipeBarsPanel);

function buttonWipe.TalentFrameEventFrame()
	if UnitAffectingCombat("player") ~= true and WipeBarsConfirm_DB.Talent == true then
		buttonWipe.button:SetParent(ClassTalentFrame.TalentsTab)
		buttonWipe.button:Show()
		buttonWipe.button:SetPoint("CENTER", ClassTalentFrame.TalentsTab, "BOTTOMLEFT", 153, 15)
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

EventRegistry:RegisterCallback('TalentFrame.TalentTab.Show', buttonWipe.TalentFrameEventFrame)
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

		WipeBarsPanel.TalentCheckbox:SetChecked(WipeBarsConfirm_DB.Talent);
		WipeBarsPanel.EditmodeCheckbox:SetChecked(WipeBarsConfirm_DB.Editmode);
	end
	if event == "PLAYER_REGEN_DISABLED" then
		buttonWipe.button:Hide()
		buttonWipe.button:ClearAllPoints();
	end
end

startup:SetScript("OnEvent", startup.OnEvent);