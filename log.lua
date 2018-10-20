
LOG = 
{
    num   =  0,
    event = {},
    time  = {},
    date  = {},
}
-----------------
LOG_mt =
{
    __index = LOG,
	__gc    = 
	function(self)
	end
}
-----------------
function LOG:new()
    local log = {}
    setmetatable(log, LOG_mt)
    return log
end
-----------------
-- adds a log event
function LOG:add(event)
    self.num = self.num + 1
    self.event[self.num] = event
    self.time[self.num] = os.date("%X %p")
    self.date[self.num] = os.date("  %A %m-%d-%y") -- %b(abbr. month)
end
-----------------
LOG.add_event = LOG.add
-----------------
-- saves all log events in a text file
function LOG:update()
    filename = ("log.txt")
 
    local cevent = self.event
    if not io.open(filename, "w") then
        local file = assert(io.open(filename, "w")); -- write to file
    end
    for s, i in pairs(cevent) do
        file = assert(io.open(filename, "a+")); -- attach new data, save data
        file:write(tostring(i), " " ,   self.date[s], " ", self.time[s], "\n"); 
		file:close(filename);
    end
end
-----------------
-- displays all the log events
function LOG:show()
    for _, n in pairs(self.event) do
        print(n, self.time[_])
    end
end 
-----------------
LOG:add("Last launch.")
--LOG:update()