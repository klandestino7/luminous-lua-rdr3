local salario = {
	{"police", "0", 10},
	{"medic", "0", 10}
  }
  
  RegisterServerEvent('crz_salario:start')
  AddEventHandler('crz_salario:start', function()
	  local _source = source
	  TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
		  for i,v in pairs(salario) do       
			  if user.getJob() == v[1] then
				  user.addMoney(v[3])
				  TriggerClientEvent('chatMessage',_source,"SALARIO",{65,255,135},"Sua recompensa de ^1$"..v[3].." ^0 foi depositada.")
			  end
		  end
	  end)
  end)


RegisterServerEvent("fcxp:systemxp")
AddEventHandler('fcxp:systemxp', function(count)
    local countxp = count    
	local _source = tonumber(source)
	TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
		print("XP Distribuido com Sucesso.")
		if (user.getGroup() == "admin" or user.getGroup() == "superadmin") then			
			if user == nil then
				print("Admin command Feedback: this user doesnt exist")
			else
				user.addXP(tonumber(countxp))
			end
		elseif user.getGroup() == "user" then
			if user == nil then
				print("Admin command Feedback: this user doesnt exist")
			else
				user.addXP(tonumber(countxp))
			end
		elseif user.getGroup() == "vip1" then
			if user == nil then
				print("Admin command Feedback: this user doesnt exist")
			else
				user.addXP(tonumber(countxp*1.10))
			end
		elseif user.getGroup() == "vip2" then
			if user == nil then
				print("Admin command Feedback: this user doesnt exist")
			else
				user.addXP(tonumber(countxp*1.20))
			end
		elseif user.getGroup() == "vip3" then
			if user == nil then
				print("Admin command Feedback: this user doesnt exist")
			else
				user.addXP(tonumber(countxp*1.30))
			end
		end
	end)
end)

RegisterServerEvent("fcxp:xpremovedeath")
AddEventHandler('fcxp:xpremovedeath', function(src)
	local _source = source
	TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
		local xpBalance = user.getXP()
		local xpperda = tonumber(xpBalance)
		if (user.getGroup() == "admin" or user.getGroup() == "superadmin") then
			if user == nil then
				print("Admin command Feedback: this user doesnt exist")
			else
				user.setXP(tonumber(xpperda*0.80))
			end
		elseif user.getGroup() == "user" then	
			if user == nil then
				print("Admin command Feedback: this user doesnt exist")
			else
				user.setXP(tonumber(xpperda*0.80))
			end
		elseif user.getGroup() == "vip1" then				
			if user == nil then
				print("Admin command Feedback: this user doesnt exist")
			else
				user.setXP(tonumber(xpperda*0.85))
			end			
		elseif user.getGroup() == "vip2" then			
			if user == nil then
				print("Admin command Feedback: this user doesnt exist")
			else
				user.setXP(tonumber(xpperda*0.90))
			end
		elseif user.getGroup() == "vip3" then	
			if user == nil then
				print("Admin command Feedback: this user doesnt exist")
			else
				user.setXP(tonumber(xpperda*0.95))
			end			
		end
	end)
end)
