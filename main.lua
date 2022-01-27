local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
local wpoblizu = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(5)
    end
end)

local JobPED = nil
RegisterNetEvent("scrap_przewodnik:spawnNPC")
AddEventHandler("scrap_przewodnik:spawnNPC",function(NPC)
    local JobPedPos = NPC.Pos
    local JobPedHeading = NPC.Heading
    RequestModel(GetHashKey(NPC.Ped))
    while not HasModelLoaded(GetHashKey(NPC.Ped)) do
        Citizen.Wait(100)
    end
    JobPED = CreatePed(7,GetHashKey(NPC.Ped),JobPedPos[1],JobPedPos[2],JobPedPos[3],JobPedHeading,0,true,true)
    FreezeEntityPosition(JobPED,true)
    SetBlockingOfNonTemporaryEvents(JobPED, true)
    TaskStartScenarioInPlace(JobPED, "WORLD_HUMAN_AA_SMOKE", 0, false)
    SetEntityInvincible(JobPED,true)
end)


Ciziten.CreateThread(function()
while(true) do 
    waypointset = waypointset(coords, x,y,z)
    Citizen.Wait(500)
    end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
			
		local coords = GetEntityCoords(PlayerPedId())
		local distance = GetDistanceBetweenCoords(coords, -1038.75,-2731.54,20.17, true)
		
            if distance <= 1.5 and not interacting then
                local Pozycja = {
                    ["x"] = -1038.84,
                    ["y"] = -2731.67,
                    ["z"] = 20.17
                }
                ESX.Game.Utils.DrawText3D(Pozycja, "NACIŚNIJ [~b~E~s~] ABY ROZMAWIAC Z PRZEWODNIKIEM", 0.55, 1.5, "~b~PRZEWODNIKIEM", 0.7)
			wpoblizu = true
		elseif distance > 1.0 then
			wpoblizu = false
		end
		
		if IsControlJustReleased(0, Keys['E']) and wpoblizu then
			ESX.UI.Menu.CloseAll()
			otworzmenu()
		end
	end
end)
  
function otworzmenu()
  
    local elements = {
        {label = 'Urzad Pracy',     value = 'lok1'},
        {label = 'Komisariat Policji',          value = 'lok2'}, 
        {label = 'Dealer Samochodow', value = 'lok3'},
        {label = 'Klub Nocny', value = 'lok4'},
        {label = 'Najblizszy Sklep', value = 'lok5'},
        {label = 'Wiezienie', value = 'lok6'},
        {label = 'Bank Fleeca', value = 'lok7'},

        }
    
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'kuba200menu_interakcji',
      {
        title    = 'Przewodnik',
        align    = 'center',
        elements = elements
        },
            function(data2, menu2)
                if data2.current.value == 'lok1' then
                    waypointset(-266.37, -961.13)
                end
  
                if data2.current.value == 'lok2' then 
                    waypointset(430.61, -999.78)
                end

                if data2.current.value == 'lok3' then 
                    waypointset(-31.64, -1104.19)
                end

                if data2.current.value == 'lok4' then 
                    waypointset(132.16, -1304.42)
                end
                
                if data2.current.value == 'lok5' then
                    waypointset(-53.97, -1758.03)
                end
  
                if data2.current.value == 'lok6' then
                    waypointset(1854.99, 2605.0)
                end

                if data2.current.value == 'lok7' then
                    waypointset(151.07, -1037.33)
                end
  
            end,
            function(data, menu)
            menu.close()
          end)
  end 
 
