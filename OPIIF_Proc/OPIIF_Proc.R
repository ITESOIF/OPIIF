
# -- ------------------------------------------------------------------------------- -- #
# -- Contexto: Proyecto de Aplicacion Profesional ---------------------------------- -- #
# -- Proyecto: Optimizacion de Programas de Inversion en Intermediarios Financieros  -- #
# -- Periodo: Primavera 2016 ------------------------------------------------------- -- #
# -- Codigo: Funciones de Procesamiento de Datos ----------------------------------- -- #
# -- Licencia: MIT ----------------------------------------------------------------- -- #
# -- ------------------------------------------------------------------------------- -- #

# --------------------------------------------------- Matriz Mensual de Estadisticas -- #

EstadMens <- function(DataEnt,YearNumber, MonthNumber)  {

  DfRends <- DataEnt
  NumActivos <- length(DfRends[1,])-1
  Years   <- unique(year(DfRends$Index))
  Months  <- unique(month(DfRends$Index))
  EstadMens  <- data.frame(matrix(ncol = NumActivos+1, nrow = 5))
  row.names(EstadMens) <- c("Media","Varianza","DesvEst","Sesgo","Kurtosis")

  NvosDatos <- DfRends[which(year(DfRends$Index) == Years[YearNumber]),]
  NvosDatos <- NvosDatos[which(month(NvosDatos$Index) == Months[MonthNumber]),]
  colnames(EstadMens)[1] <- "Fecha"
  EstadMens$Fecha <- NvosDatos$Index[length(NvosDatos$Index)]

  EstadMens[1,2:length(EstadMens[1,])] <- round(apply(NvosDatos[,2:length(NvosDatos[1,])],
                                                      MARGIN=2,FUN=mean),4)
  EstadMens[2,2:length(EstadMens[1,])] <- round(apply(NvosDatos[,2:length(NvosDatos[1,])],
                                                      MARGIN=2,FUN=var),4)
  EstadMens[3,2:length(EstadMens[1,])] <- round(apply(NvosDatos[,2:length(NvosDatos[1,])],
                                                      MARGIN=2,FUN=sd),4)
  EstadMens[4,2:length(EstadMens[1,])] <- round(apply(NvosDatos[,2:length(NvosDatos[1,])],
                                                      MARGIN=2,FUN=skewness),4)
  EstadMens[5,2:length(EstadMens[1,])] <- round(apply(NvosDatos[,2:length(NvosDatos[1,])],
                                                      MARGIN=2,FUN=kurtosis),4)
  colnames(EstadMens)[2:length(EstadMens[1,])] <- colnames(DfRends[2:(NumActivos+1)])
return(EstadMens)
}

# Prueba
# Resultado <- EstadMens(DataEnt=DfRendimientos, YearNumber=2, MonthNumber=2)

NumAle <- 20
X2 <- runif(NumAle)/sum(runif(NumAle))
