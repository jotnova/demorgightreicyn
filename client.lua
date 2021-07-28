local component = require("component")
local event = require("event")
local modem = component.modem
modem.open(2101)
modem.broadcast(2101, "drone=component.proxy(component.list('drone')())")
modem.broadcast(2101, "ic=component.proxy(component.list('inventory_controller')())")
while true do
local cmd=io.read()
if not cmd then return end
modem.broadcast(2101, cmd)
print(select(6, event.pull(5, "modem_message")))
end