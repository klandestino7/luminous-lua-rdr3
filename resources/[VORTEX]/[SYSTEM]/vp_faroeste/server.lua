local sellables = {
    {model = -2011226991, value = 175}, -- eastern wild turkey black
    {model = -466054788, value = 175}, -- eastern wild turkey white
    {model = 1458540991, value = 200}, -- Racoon
    {model = 90267823, value = 300}, -- Cougar
    {model = 1110710183, value = 500}, -- whitetail deer
    {model = -1963605336, value = 500}, -- whitetail buck
    {model = 480688259, value = 300}, -- california valley coyote
    {model = -1414989025, value = 175}, -- virginia opossum
    {model = -2063183075, value = 175}, -- Dominique Chicken
    {model = -1170118274, value = 175}, -- American Badger
    {model = -1458540991, value = 200}, -- North American Raccoon
    {model = 1755643085, value = 500}, -- American Pronghorn Doe
    {model = -1464167925, value = 175}, -- Southern Copperhead Snake
    {model = -723190474, value = 175}, -- Canada Goose
    {model = -8651544272, value = 150}, -- Great Horned Owl
    {model = -1465438313, value = 300}, -- American Red Squirrel
    {model = -1568716381, value = 500}, -- Rocky Mountain Bighorn Ram
    {model = -885451903, value = 175}, -- Timber Wolf
    {model = -541762431, value = 175}, -- Black-Tailed Jackrabbit
    {model = 252669332, value = 125}, -- American Red Fox
    {model = -861544272, value = 200}, -- Coastal Horned Owl
    {model = -1003616053, value = 200}, -- Pekin Duck
    {model = -829273561, value = 300}, -- gray wolf
    {model = -885451903, value = 300}, -- gray wolf
    {model = -1143398950, value = 300}, -- gray wolf
    {model = -2145890973, value = 300}, -- Red-Tailed Hawk
    {model = 1007418994, value = 25}, -- Berkshire Pig
    {model = 40345436, value = 25}, -- Merino Sheep
    {model = -1568716381, value = 175}, -- Rocky Mountain Bighorn Sheep
    {model = -575340245, value = 200}, -- Western Raven
    {model = 1416324601, value = 175}, -- Ring-neck Phesant
    {model = -1553593718, value = 500}, -- Muskie
    {model = -1295720802, value = 200}, -- Aligator
    {model = -1211566332, value = 175}, -- Striped Skunk
    {model = -593056309, value = 175}, -- Desert Iguana
    {model = 457416415, value = 175}, -- Banded Gila Monster
    {model = 1265966684, value = 175}, -- American White Pelican
    {model = -300867788, value = 350}, -- Lake Sturgeon
    {model = 90264823, value = 350}, -- Cougar
    {model = -1134449699, value = 175}, -- American Musckrat
    {model = -2073130256, value = 175}, -- Neotropic Cormorant
    {model = -407730502, value = 175}, -- Alligator Snapping Turtle
    {model = -564099192, value = 175}, -- Whooping Crane
    {model = -1854059305, value = 200}, -- Green Iguana
    {model = 831859211, value = 175}, -- Little Egret
    {model = 1095117488, value = 175}, -- Tricolored Heron
    {model = 2079703102, value = 175}, -- Greater Prairie Chicken
    {model = 545068538, value = 175}, -- Timber Rattlesnake
    {model = 1464167925, value = 175}, -- Nothern Copperhead Snake
    {model = 1538187374, value = 175}, -- Channel Catfish
    {model = -1076508705, value = 175}, -- Roseate Spoonbill
    {model = 1459778951, value = 175}, -- Bald Eagle
    {model = 1104697660, value = 175}, -- Eastern Turkey Vulture
    {model = -164963696, value = 175}, -- Laughing Gull
    {model = 386506078, value = 175}, -- Yellow-Billed Loon
    {model = -1797625440, value = 275}, -- Nine-Banded Armadillo
    {model = 759906147, value = 175}, -- North American Beaver
    {model = -753902995, value = 175}, -- Alpine Goat
    {model = 1654513481, value = 375}, -- Legendary Panther
    {model = 723190474, value = 175}, -- Canada Goose
    {model = -711779521, value = 275}, -- Longnose Gar
    {model = 697075200, value = 275}, -- Northen Pike
    {model = -1553593715, value = 375}, -- Muskie
    {model = 1205982615, value = 175} -- Californian Condor
}

RegisterCommand("getlist", function(source, args)
    local num = math.random(0,62)
    print(sellables[num].model)


    for i = 1, #sellables, 1 do
        print(sellables[i].model, sellables[i].value)
    end

end)

