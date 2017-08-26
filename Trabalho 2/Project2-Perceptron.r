#Aluno Miguel Pessoa
#Discriminador de digitos 1,2,7 Utilizando Perceptron
#Este arquivo utiliza  dois perceptrons como discriminador de digitos

library(ggplot2)

perceptron <- function(x, y, eta, niter) {
    # inicializa vetor de pesos
    weight <- rep(0, dim(x)[2] + 1)
    errors <- rep(0, niter)
    ypred <- rep(0, length(y))
    ypred1 <- rep(0, length(y))

    # loop sobre numero de iteracoes
    for (jj in 1:niter) {
        k <- 0

        # loop sobre o conjunto de treinamento
        for (ii in 1:length(y)) {

            # Predicao da saída discreta (-1, 1) usando uma função de limiar
            z <- sum(weight[2:length(weight)] * as.numeric(x[ii, ])) + weight[1]
            if(z < 0) {
                ypred <- -1
            } else {
                ypred <- 1
            }
            # Atualizacao dos Pesos - nao faz nada se saida estiver correta
            if (k == 0) {
                weightdiff <- eta * (y[ii] - ypred) * c(1, as.numeric(x[ii, ]))
                if (weightdiff[1] != 0){
                    k <- 1
                    weight <- weight + weightdiff
                    for (kk in 1:length(y)) {
                        w <- sum(weight[2:length(weight)] * as.numeric(x[kk, ])) + weight[1]
                        if(w < 0) {
                            ypred1[kk] <- -1
                        } else {
                            ypred1[kk] <- 1
                        }
                        # Update error function:
                        if ((y[kk] - ypred1[kk]) != 0) {
                            errors[jj] <- errors[jj] + 1
                        }
                    }
                }
            }
        }
    }

    # Peso para decidir entre as entradas
    return(list(Weight = weight, Errors = errors, Ypred1 = ypred1))
}

#############################################################################
#############################################################################
# TREINAMENTOS
#############################################################################

#dataset
#numbers
one = as.integer(unlist(strsplit("0,1,0,0,1,0,1,1,1,1",",")))
matrizOne <- matrix(unlist(one[1:9]), ncol = 3, byrow = TRUE)

two = as.integer(unlist(strsplit("1,1,1,0,1,0,1,1,1,2",",")))
matrizTwo <- matrix(unlist(two[1:9]), ncol = 3, byrow = TRUE)

seven = as.integer(unlist(strsplit("1,1,1,0,0,1,0,0,1,7",",")))
matrizSeven <- matrix(unlist(seven[1:9]), ncol = 3, byrow = TRUE)

numbers = matrix(cbind(one,two,seven), nrow=3,ncol=10, byrow = TRUE)

############## Treinamento #1
#respostas esperadas para o primeiro treinamento
# 1 = 1, 2 ou 7 = -1.
numbers <- cbind(numbers, 1)
numbers[numbers[,10] == 1, 11] <- 1
numbers[numbers[,10] == 2, 11] <- -1
numbers[numbers[,10] == 7, 11] <- -1

#Perceptron valores de entrada
# Treinando numeros 1 e 2
x <- numbers[, c(1:9)]
y <- numbers[, 11]

eta = 0.01
niter = 50
respostaTreinamento1 <- perceptron(x, y, eta, niter)

#Curva de Aprendizado 1
plot(1:niter, respostaTreinamento1$Errors, type="l", lwd=2, col="red", xlab="epoch #", ylab="errors")
title("Treinamento - Perceptron #1")

############## Treinamento #2
#respostas esperadas para o segundo treinamento
# 2 = -1 e 7 = 1
numbers <- cbind(numbers, 1)
numbers[numbers[,10] == 1, 11] <- 0
numbers[numbers[,10] == 2, 11] <- -1
numbers[numbers[,10] == 7, 11] <- 1

x <- numbers[2:3, c(1:9)]
y <- numbers[2:3, 11]

respostaTreinamento2 <- perceptron(x, y, eta, niter)

print(respostaTreinamento1)
print(respostaTreinamento2)

#Curva de Aprendizado 2
dev.new()
plot(1:niter, respostaTreinamento2$Errors, type="l", lwd=2, col="red", xlab="epoch #", ylab="errors")
title("Treinamento - Perceptron #2")

#############################################################################
#############################################################################
# PROGRAMA PRINCIPAL
#############################################################################

print("Discriminador de Digitos (1,2,7)")
print("Digito 1:")
prmatrix(matrizOne, rowlab=rep("",3), collab=rep("",3))
print("Digito 2:")
prmatrix(matrizTwo, rowlab=rep("",3), collab=rep("",3))
print("Digito 7:")
prmatrix(matrizSeven, rowlab=rep("",3), collab=rep("",3))

while (TRUE){
    entrada <- readline(prompt="Entre o digito que deseja discriminar (exe. 1,1,1,1,1,1,1,1,1): ")
    xUser <- as.integer(unlist(strsplit(entrada,",")))
    matrizUser <- matrix(unlist(xUser), ncol = 3, byrow = TRUE)
    
    primeiraSaida <- sum(respostaTreinamento1$Weight[2:length(respostaTreinamento1$Weight)] * as.numeric(xUser)) + respostaTreinamento1$Weight[1]
   
    print("Resultado do Discriminador: ")
    print("Entrada: ") 
    prmatrix(matrizUser, rowlab=rep("",3), collab=rep("",3))
    print("Saida: ")
    if(primeiraSaida < 0) {
        segundaSaida <- sum(respostaTreinamento2$Weight[2:length(respostaTreinamento2$Weight)] * as.numeric(xUser)) + respostaTreinamento2$Weight[1]
        if (segundaSaida > 0) {
            print("Digitou igual ou proximo a [7] ")
            prmatrix(matrizSeven, rowlab=rep("",3), collab=rep("",3))
        } else {
            print("Digitou igual ou proximo a [2] ")
            prmatrix(matrizTwo, rowlab=rep("",3), collab=rep("",3))
        }
    } else {
        print("Digitou igual ou proximo a [1] ")
        prmatrix(matrizOne, rowlab=rep("",3), collab=rep("",3))
    }
}









