
------------------------------------------------------------------------------ SERVER ------------------------------------------------------------------------


cooldown = 20 -- (segundos) Tempo, em segundos, para o player poder iniciar outra corrida. (0 para não ter cooldown)

timeToStart = 60 -- Cooldown para startar a corrida.

once = false -- Para permitir apenas 1 corrida por vez.

------------------------------------------------------------------------------ CLIENT ------------------------------------------------------------------------

allowedVeh = { -- Aqui você determina os veículos que poderão iniciar a corrida de modo global (true para permitir, false para não permitir)
	[0] = true, -- Compactos
	[1] = true, -- Sedans
	[2] = true, -- SUVs
	[3] = true, -- Coupes
	[4] = true, -- Muscle
	[5] = true, -- Sports
	[6] = true, -- Sports
	[7] = true, -- Super
	[8] = false, -- Motos
	[9] = true, -- Off-Road
	[10] = false, -- Industrial
	[11] = true, -- Motos
	[12] = true, -- Vans
	[13] = true, -- Cycles
	[14] = false, -- Barcos
	[15] = false, -- Helicopteros
	[16] = false, -- Aviões
	[17] = true, -- Serviço
	[18] = true, -- Emergencial
	[19] = true, -- Militar
	[20] = true, -- Comercial
	[21] = false, -- Trem
}


showBlip = false -- (true/false) Mostrar o blip?

mapBlipColor = 49 -- (0 a 85) Cor do blip que aparecerá no mapa. Mais cores: https://docs.fivem.net/docs/game-references/blips/

blipsColor = {255, 0, 0} -- (r/g/b) Cor dos blips.

blipText = "~r~[E]~w~ INSCREVER-SE" -- (texto desejado) Texto que aparece no blip de iniciar a corrida.	
