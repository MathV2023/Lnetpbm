
P1 = {}
P1.__index = P1


-- Funções locais
local separar = function(str)
   local _table = {} 
   for str_parte in string.gmatch(str, "%S+") do
      _table[#_table+1] = str_parte
   end
   return _table
end


-- Metodos
function P1:new(name --[[str]], comments --[[str]], width --[[number]], height --[[number]])
   self = setmetatable({}, self)
   self.name --[[str]] = (name .. '.pbm')
   self.comments --[[str]] = comments
   self.width --[[number]] = width
   self.height --[[number]] = height
   self.img --[[str]]  = ''

   return self
end

function P1:draw(mode --[[number: 0 or 2]], ...)
   local args --[[table]] = ...
   local str --[[str]] = ''
   local w --[[number]] = self.width
   local size --[[number]] = (self.width*self.height)
   local is_correct --[[boolean]] = false

   for i, value in ipairs(args) do
      is_correct = type(value) == 'number' and (value == 0 or value == 1)
      
      if i <= size then
         if mode == 0 and is_correct then
            str = (str .. tostring(value))
            
         elseif mode == 1 and is_correct then
            str = (str .. tostring(value) .. ' ')

	         if i == size then
               str = str .. '\r'
            end
         elseif mode == 2 and is_correct then
            str = (str .. tostring(value) .. ' ')
            
            if i == w and i ~= size then
               str = str .. '\n'
               w = w + self.width
            end
         else
            error('Some invalid value in the "P1:draw()".')
         end
      end
   end

   self.img --[[str]] = str
   return str
end

function P1:mount_image()
   local str --[[str]] = 'P1\n'..self.comments..'\n'..self.width..' '..self.height..'\n'..self.img
   return str
end

function P1:drawTerminal(path)
   local file = io.open(path, "r")
   local pixels --[[table]] = {}
   local pixel --[[number]] = 0
   local width --[[number]] = 0
   local w --[[number]] = 0
   local writeLine = io.write
   
   if not file then 
      print("Erro: Arquivo não encontrado em " .. tostring(path))
      return 
   end

   local conteudo --[[str]] = file:read("*a")
   file:close()


   local _, posicao_final --[[number]] = conteudo:find("[%d] [%d]")
   local width --[[number]] = tonumber(conteudo:match("(%d+)%s+%d+"))

   if posicao_final then
      conteudo = conteudo:sub(posicao_final + 2)
      pixels = separar(conteudo)

      print(" ." .. string.rep("==", width) .. ". ")
      writeLine("\27[0m||")

      for i = 1, #pixels do
         pixel = tonumber(pixels[i])

         if (pixel == 1) then
            writeLine("\27[40m  ")
         elseif (pixel == 0) then
            writeLine("\27[47m  ")
         end

         if (i == (width + w)) then
            w = w + width
            writeLine("\27[0m||\n||")
         end
      end

      writeLine("\r `" .. string.rep("==", width) .. "´ ")
   else
      print("Erro: valor da largura não encontrado.")
   end
end


return P1
