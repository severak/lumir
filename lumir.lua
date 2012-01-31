homedir="html"

function string:split(sep)
        local sep, fields = sep or ":", {}
        local pattern = string.format("([^%s]+)", sep)
        self:gsub(pattern, function(c) fields[#fields+1] = c end)
        return fields
end

function answer(client,fn,qs)
  QS=qs
  
  client:send("HTTP/1.1 200 OK\r\n")
  headers_sent=false
  headers={["Connection"]="close",["Content-type"]="text/html"}
  
  echo=function(txt)
    if not headers_sent then
      for k,v in pairs(headers) do
        client:send(k..": "..v.."\r\n")
      end
      client:send("\r\n")
      headers_sent=true
    end
    client:send(tostring(txt))
  end
  fun,err=loadfile(homedir..fn)
  if type(fun)=="function" then
    ok,err=pcall(fun)
    if not ok then
      echo(lumir.errpage:gsub("ERR",err))
      print(err)
    end
  else
    echo(lumir.errpage:gsub("ERR",err))
    print(err)
  end
end



socket=require "socket"

lumir={}
lumir.errpage=[[
<html>
<head><title>error</title></head>
<body>
<h1>:-(</h1>
<pre>ERR</pre>
</body>
</html>]]

server = socket.bind("*",8009)
goon=1
while goon do
	local client = server:accept()
	client:settimeout(10)
	local line,err = client:receive()
	if line then
    p=line:split(" ")
    method=p[1]
    path=p[2]
    pp=path:split("?")
    if pp[1]=="/" then
      pp[1]="/index.lua"
    end
    print(method,pp[1],pp[2])
    answer(client,pp[1],pp[2])
  else
    print(err)
  end
  client:close()
end
		