set ant 999
set ite 0
battery set 100

atget id id
getpos2 lonSen latSen

loop
wait 10
read mens
rdata mens tipo valor

if((tipo=="hola") && (ant == 999))
   set ant valor
   data mens tipo id
   send mens * valor
end

if(tipo=="alerta")
   send mens ant
end

areadsensor tempSen
rdata tempSen SensTipo idSens temp

if(temp>30)
   data mens "alerta" lonSen latSen id
   send mens ant
end

inc ite
if(ite>=1000)
   stop
end

inc ite
battery bat

cprint "Sensor: " id ", la iteracion es: " ite ", bateria: " bat
if(bat<5)
   cprint "Sensor: " id ", la iteracion es: " ite ", bateria: " bat
   data mens "critico" lonSen latSen id
   send mens ant
end

if(tipo == "stop")
   data mens "stop"
   send mens * valor
   cprint "Para sensor: " id
   wait 1000
   stop
end