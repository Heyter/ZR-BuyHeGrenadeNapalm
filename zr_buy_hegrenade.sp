#pragma semicolon 1
#include <zombiereloaded>
#include <sdktools_functions>
#pragma newdecls required

public Plugin myinfo = {
	author = "Hikka",
	name = "[ZR] Buy hegrenade",
	version = "0.01",
	url = "https://github.com/Heyter/ZR-BuyHeGrenadeNapalm/",
};

public void OnPluginStart() {
	AddCommandListener(Event_Say, "say");
	AddCommandListener(Event_Say, "say_team");
}

public Action Event_Say(int client, const char[] command, int args) {
	if (!IsPlayerAlive(client) || ZR_IsClientZombie(client)) return Plugin_Handled;
	
	char text[24];
	GetCmdArgString(text, sizeof(text));
	StripQuotes(text); TrimString(text);
	
	char menuTriggers[][] = { "!he", "/he", "!hegrenade", "/hegrenade" };
	
	for (int i = 0; i < sizeof(menuTriggers); i++) {
		if (strcmp(text, menuTriggers[i], false) == 0) {
			int getmoney = GetEntProp(client, Prop_Send, "m_iAccount");
			int price = 5000;	// price $5000
			if (getmoney < price) {
				ReplyToCommand(client, "You don't have money!");
				return Plugin_Handled;
			}
			SetEntProp(client, Prop_Send, "m_iAccount", getmoney - price);
			PrintToChat(client, "You purchased HeGrenade for \x04$%i", price);
			if (getmoney < 1) SetEntProp(client, Prop_Send, "m_iAccount", 0); // safe guard. if money = $-X;
			GivePlayerItem(client, "weapon_hegrenade");
			return Plugin_Handled;
		}
	}
	
	return Plugin_Continue;
}