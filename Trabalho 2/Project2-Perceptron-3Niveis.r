#Aluno Miguel Pessoa
#Discriminador de digitos 1,2,7 Utilizando Perceptron
#Este Arquivo utiliza Tres niveis de ativacao do Perceptron

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
            if(z < -1) {
                ypred <- -1
            } else if (z > 1){
                ypred <- 1
            } else {
                ypred <- 0
            }
            # Atualizacao dos Pesos - nao faz nada se saida estiver correta
            if (k == 0) {
                weightdiff <- eta * (y[ii] - ypred) * c(1, as.numeric(x[ii, ]))
                if (weightdiff[1] != 0){
                    k <- 1
                    weight <- weight + weightdiff
                    for (kk in 1:length(y)) {
                        w <- sum(weight[2:length(weight)] * as.numeric(x[kk, ])) + weight[1]
                        if(w < -1) {
                            ypred1[kk] <- -1
                        } else if (w > 1) {
                            ypred1[kk] <- 1
                        } else {
                            ypred1[kk] <- 0
                        }
                        # atualiza funcao de erro
                        if ((y[kk] - ypred1[kk]) != 0) {
                            errors[jj] <- errors[jj] + 1
                        }
                    }
                }
            }
        }
    }

    # Weight to decide between the two species
    return(list(Weight = weight, Errors = errors, Ypred1 = ypred1))
}

#############################################################################
#############################################################################
# TREINAMENTO
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

#respostas esperadas.
numbers <- cbind(numbers, 1)
numbers[numbers[,10] == 1, 11] <- -1
numbers[numbers[,10] == 2, 11] <- 0
numbers[numbers[,10] == 7, 11] <- 1

#Perceptron valores de entrada
# Treinando numeros 1 e 2
x <- numbers[, c(1:9)]
y <- numbers[, 11]

eta = 0.1
niter = 50
ypred <- perceptron(x, y, eta, niter)


#Curva de Aprendizado
plot(1:niter, ypred$Errors, type="l", lwd=2, col="red", xlab="epoch #", ylab="errors")
title("Erros vs iteracoes")

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
    
    saida <- sum(ypred$Weight[2:length(ypred$Weight)] * as.numeric(xUser)) + ypred$Weight[1]

    print("Resultado: ")
    print("Entrada: ") 
    prmatrix(matrizUser, rowlab=rep("",3), collab=rep("",3))
    print("Saida: ")
    if(saida < -1) {
        print("Digitou igual ou proximo a [1] ")
        prmatrix(matrizOne, rowlab=rep("",3), collab=rep("",3))
    } else if (saida > 1){
        print("Digitou igual ou proximo a [7] ")
        prmatrix(matrizSeven, rowlab=rep("",3), collab=rep("",3))
    } else {
        print("Digitou igual ou proximo a [2] ")
        prmatrix(matrizTwo, rowlab=rep("",3), collab=rep("",3))
    }
}









