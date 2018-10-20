
milisecond =  os.date("%S")*1000
second =  os.date("%S") -- 1 - 61
minute =  os.date("%M") -- 1- 59
hour =  os.date("%H") -- 1- 24


day = os.date("%d") -- 1- 31
week =  0 
month = os.date("%m") -- 1- 12
year = os.date("%Y") -- full year 1996

period = os.date("%p") -- am or pm

week_day =  os.date("%w") -- 0- 6(sat-sun)

day_name =  os.date("%A") -- Wednesday
month_name =  os.date("%B") -- December

abbr_dayname =  os.date("%a") -- Wed.
abbr_monthname =  os.date("%b") -- Dec.

p2_digityear = os.date("%y") -- 98



full_date =  os.date("%x") -- 09/16/98
full_time =  os.date("%X") -- 23:48:10

date_time =  os.date("%c") -- 09/16/98 23:48:10


-- 1st day of the week(sunday)
if(os.date("%w") == 0) then
 week = week + 1
end

time_since_lua_started = os.clock()
 -- in seconds; e.g lua started 6 seconds ago
 
-- for k, v in pairs(os.date("*t")) do print(k, v) end


--print(os.date()) -- 09/16/98 23:48:10

--calculate # of seconds between t1 - t2
--os.difftime(time_end, time_begin)



previous_day = os.date("%d") - 1
previous_year = os.date("%Y") - 1
previous_month = os.date("%m") - 1

--print(previous_month.."/"..previous_day.."/"..previous_year)

local clock = os.clock
function sleep(n)  -- seconds
  local t0 = clock()
  while clock() - t0 <= n do end
end