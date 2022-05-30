local item = {
	index = "ticket",
	amount = 1,
}
local police = "policia.permissao"

checkTicket = function(user_id,raceID) -- Função que checa determinado item no seu inventário.
    return vRP.tryGetInventoryItem(user_id,item.index,item.amount,true)

end


cantStart = function(source,raceID) -- Caso a corrida não inicie, o ticket será devolvido.
    local user_id = vRP.getUserId(source)
    vRP.giveInventoryItem(user_id,item.index,item.amount,true)


    -- vRP.generateItem(user_id,item.index,item.amount,true) -- PARA BAHAMAS
end

checkPolice = function(raceID) -- Função que checa o número de policiais.
    local policiais = vRP.getUsersByPermission(police) or vRP.numPermission(police) or {}

    return #policiais >= 2
end

checkPermission = function(user_id,raceID) -- Função que checa a permissão para iniciar a corrida.
    return not (vRP.hasPermission(user_id,police) or vRP.hasPermission(user_id,"paramedico.permissao") ) -- Não permite que policiais, paramédicos, e pessoas "procuradas" iniciem a corrida.
end

payment = function(user_id,payment,pos,racers,raceID) -- Pagamento ao terminar a corrida. (user_id: id do player/ payment: valor que o player irá receber(isso pode ser alterado em blips.lua)/ pos: é a posição atual do player na corrida/ racers: é a quantidade de corredores )
    local policia = vRP.getUsersByPermission(police) or vRP.numPermission(police) or {}
    local posRewards = {[1] = 10000,[2] = 8000,[3] = 6000} -- Prêmio bonus baseado na posição do player (nesse exemplo, apenas os primeiros 3 ganham)
    local _source = vRP.getUserSource(user_id)
    vRP.giveInventoryItem(user_id,"dinheirosujo",parseInt(payment)+(posRewards[parseInt(pos)] or 0)) -- Para receber dinheiro sujo ao terminar a corrida.
    -- vRP.giveInventoryItem(user_id,"dollars2",parseInt(payment)+(posRewards[parseInt(pos)] or 0)) -- Para receber dinheiro sujo ao terminar a corrida.
    -- vRP.giveMoney(user_id,parseInt(payment)) -- Para receber dinheiro limpo ao terminar a corrida.
end

startedRace = function(source,callPolice,raceID) -- Evento que é acionado quando a corrida começa (source: source do player que puxou a corrida/ callPolice: é o que diz se a policia vai ser chamada, pode ser true or false(você pode alterar isso em blips.lua))
	local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	local webhook = "" -- (link do webhook desejado) Webhook do player que iniciou a corrida.

	PerformHttpRequest(webhook,function(err, text, headers) end, 'POST', json.encode({content = "```prolog\n[ID]: "..user_id.." "..identity.name.." "..(identity.firstname or identity.name2).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```"}), { ['Content-Type'] = 'application/json' })

    if callPolice then
        local police = vRP.getUsersByPermission(police) or vRP.numPermission(police) or {}
        for l,w in pairs(police) do
            local player = vRP.getUserSource(parseInt(w)) -- Se vc usa creative, deixe apenas: local player = w
            if player then
                async(function()
                    vRPclient.playSound(player,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
                    TriggerClientEvent('chatMessage',player,"911",{64,64,255},"Recebemos uma denúncia de corredor ilegal.")
                end)
            end
        end
    end
end


RegisterServerEvent("race-bip")
AddEventHandler("race-bip",function(x,y,z) -- Esse evento é chamado toda a vez q o player passa em um blip, o evento faz com que apareça um blip no mapa da policia de onde o player está
	local user_id = vRP.getUserId(source)

	if user_id then
		local policia = vRP.getUsersByPermission(police) or vRP.numPermission(police) or {}

		for l,w in pairs(policia) do
			local player = vRP.getUserSource(parseInt(w)) -- Se vc usa creative, deixe apenas: local player = w
			if player then
				async(function()
                	TriggerClientEvent('race-bip',player,x,y,z,user_id)		
				end)			
			end
		end		
	end
end)