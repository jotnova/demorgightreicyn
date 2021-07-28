local m=component.proxy(component.list("modem")())
m.open(2101)
local function respond(...)
local args=table.pack(...)
pcall(function() m.broadcast(2101, table.unpack(args)) end)
end
local function receive()
while true do
local e,_,_,_,_,cmd=computer.pullSignal()
if e=="modem_message" then return load(cmd) end
end
end
while true do
local result,reason=pcall(function()
local result,reason=receive()
if not result then return respond(reason) end
respond(result())
end)
if not result then respond(reason) end
end