library(ggplot2)

perceptron <- function(x, y, eta, niter) {
    # inicializa vetor de pesos
    weight <- rep(0, dim(x)[2] + 1)
    errors <- rep(0, niter)
    ypred <- rep(0, length(y))
    
    
    # loop sobre numero de iteracoes
    for (jj in 1:niter) {
        
        # loop sobre o conjunto de treinamento
        for (ii in 1:length(y)) {
            
            # Predicao da saída discreta (0, 1) usando uma função de limiar
            z <- sum(weight[2:length(weight)] * as.numeric(x[ii, ])) + weight[1]
            if(z < 0) {
                ypred[ii] <- 0
            } else {
                ypred[ii] <- 1
            }
            
            # Atualizacao dos Pesos - nao faz nada se saida estiver correta
            weightdiff <- eta * (as.numeric(y[ii]) - as.numeric(ypred[ii])) * c(1, as.numeric(x[ii, ]))
            weight <- weight + weightdiff
            
            # atualiza funcao de erro
            if ((as.numeric(y[ii]) - as.numeric(ypred[ii])) != 0.0) {
                errors[jj] <- 1/9 * sum((as.numeric(y[ii]) - ypred[ii])^2)    
            }       
            
        }
    }
    
    # pesos usados para classificar duas especies
    print(weight)
    print(ypred)
    return(errors)
}

#############################################################################
#############################################################################
# Programa Principal
#############################################################################

letterT <- c(1,1,1,0,1,0,0,1,0, "T")
letterH <- c(1,0,1,1,1,1,1,0,1, 'H')
column.names <- c("S1", "S2", "S3", "S4", "S5", "S6", "S7", "S8", "S9", "Char")
row.names <- c("Letter T", "Letter H")

letras <- matrix(c(letterT, letterH, 1), nrow=2, ncol=10, byrow=TRUE, dimnames = list(row.names,column.names))

letras[letras[,10] == "T", 10] <- 1
letras[letras[,10] == "H", 10] <- 0

apply(letras, 2, as.numeric)

x <- letras[c(1,2),]
y <- letras[,10]

learningRate <- 0.2
numberOfInteractions <- 10
err <- perceptron(x, y, learningRate, numberOfInteractions)

#Part A - Plot learning rate
plot(1:numberOfInteractions, err, type="l", lwd=2, col="red", xlab="# de iteracoes", ylab="errors")
title("Curva de Erro de Treinamento")


