library(phreeqc)
library(githubinstall)
library(git2r)
#-------------------------------------------------------------------------

path_bare <- tempfile(pattern="git2r-")
path_repo <- tempfile(pattern="git2r-")
dir.create(path_bare)
dir.create(path_repo)
repo_bare <- init(path_bare, bare = TRUE)

repo <- clone(path_bare, path_repo)
git2r::add(repo, "Manejo_PHREEQC-V3.R")
commit(repo, "Primera_Guia")
push(repo, "origin", "https://github.com/valizcanos/PHREEQC-V3.git")


#-------------------------------------------------------------------------
#Solubilidad y su dependencia de la temperatura del CaSO4 y del CaSO4.2H2O

# Ahora vamos a cargar la base de datos que trae por defecto la librería

phrLoadDatabaseString(phreeqc.dat)

?phrRunString() #Hacer consulta de la función

phrRunString(ex2) #Ejemplo 2 

str(ex2) #Mostrar estructura de los datos
class(ex2) #Mortrar tipo de datos

so <- phrGetSelectedOutput() #Convertir datos a una lista

attach(so$n1)#Graficar información
title  <- expression("CaSO"[4]*"-"*"CaSO"[4]*".2H"[2]*"O Estabilidad")
xlabel <- expression("Temperatura"^o*"C")
ylabel <- "Indice de saturación"
plot(temp.C., si_gypsum, main = title, xlab = xlabel, ylab = ylabel,
     col = "darkred", xlim = c(25, 75), ylim = c(-0.4, 0.0))
points(temp.C., si_anhydrite, col = "darkgreen")
legend("bottomright", c("CaSO4", "CaSO4.2H2O"), #Agregar leyenda
       col = c("darkred", "darkgreen"), pch = c(1, 1))


#-------------------------------------------------------------------------
#Especiación química
phrLoadDatabaseString(phreeqc.dat)
phrSetOutputStringsOn(TRUE)
phrRunString(ex1)
phrGetOutputStrings()
so1<- phrGetSelectedOutput()  #Convertir a lista los datos del este ejemplo
head(so1$n1,10) #Mostrar 10 primeros valores del dataframe

title  <- expression("Especiación química")
xlabel <- expression("Vol. Poro")
ylabel <- "Mol.gwg"
plot(so1$n1$Pore_vol,so1$n1$Na.mol.kgw, col = "darkred", main = title, 
     xlab = xlabel, ylab = ylabel)
points(so1$n1$Pore_vol, so1$n1$Cl.mol.kgw, col = "darkgreen")
legend("bottomright", c("Na", "Cl"), #Agregar leyenda
       col = c("darkred", "darkgreen"), pch = c(1, 1))

#Ejemplo con Solución sólida de aragonita-estrontianita

phrLoadDatabaseString(phreeqc.dat)
phrSetOutputStringsOn(TRUE)
phrRunString(ex10)
phrGetOutputStrings()

#Ejemplo de transporte e intercambio de cationes

phrLoadDatabaseString(phreeqc.dat)
phrSetOutputStringsOn(TRUE)
phrRunString(ex11)
phrGetOutputStrings()
so2<- phrGetSelectedOutput()#Convertir a lista

title  <- expression("Transporte de cationes")
xlabel <- expression("Vol. Poro")
ylabel <- "Mol.gwg"
plot(so2$n1$Pore_vol,so2$n1$Na.mol.kgw, col = "darkred", main = title, 
     xlab = xlabel, ylab = ylabel)
points(so2$n1$Pore_vol, so2$n1$Cl.mol.kgw, col = "darkgreen")
points(so2$n1$Pore_vol, so2$n1$K.mol.kgw, col = "darkblue")
points(so2$n1$Pore_vol, so2$n1$Ca.mol.kgw, col = "black")
legend("bottomright", c("Na", "Cl", "K","Ca"), #Agregar leyenda
       col = c("darkred", "darkgreen","darkblue","black"), pch = c(1, 1))

#Ejemplo de flux difusivo y advectivo de calor y solutos

phrLoadDatabaseString(phreeqc.dat)
phrSetOutputStringsOn(TRUE)
phrRunString(ex12)
phrGetOutputStrings()
