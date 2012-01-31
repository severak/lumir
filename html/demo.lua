demos={"Custom error messages","List all variables","Kill server","Headers","Quine"}  
if QS and QS=="show=4" then
  headers["Content-type"]="text/plain"    
elseif QS and QS=="show=5" then
  f=io.open(homedir..pp[1],"r")
  if f then
    headers["Content-type"]="text/plain"
    echo(f:read("*a"))
    f:close()
    client:close()
  end
end


echo([[
<html>
<head><title>demo</title></head>
<body>
]])

if QS then
  if QS=="show=1" then
    error("Example error.")  
  elseif QS=="show=2" then
    for k,v in pairs(_G) do
      echo(k.." = "..tostring(v).."<br>")
    end
  elseif QS=="show=3" then
    echo("Killed")
    goon=false
  elseif QS=="show=4" then
    echo(" - Custom headers and content types...\n")
  end
else
  echo("<h1>Demos</h1>")
  echo("<ul>")
  for k,v in pairs(demos) do
    echo('<li><a href="demo.lua?show='..k..'">'..v..'</a></li>')
  end
  echo("</ul>")
end

echo([[
</body>
</html>
]])