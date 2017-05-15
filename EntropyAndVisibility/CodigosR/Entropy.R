library(ggplot2)
require(igraph)

#Lendo o dataset contendo os dados
ReadData<-function(){
  matriz = data.matrix(read.table(file.choose()))
  matriz
}

EntropyData<-function(matriz,op,q=0){
  entropyShannonInter = rep(0,dim(matriz)[1])
  for(i in 1:dim(matriz)[1]){
    a = matriz[i,1:length(matriz[i,])]
    a = a[a!=0]
    aa = hist(a,probability = TRUE)
    if(i == 5){
      print(aa$density)
    }
    if(op == 1){
      entropyShannonInter[i] = shannonEntropyNormalized(aa$density)
    }else if(op == 2){
      entropyShannonInter[i] = tsallisEntropy(aa$density,q)
    }else{
      entropyShannonInter[i] = renyiEntropy(aa$density,q)
    }
  }
  #entropyShannonInter
  write.csv(entropyShannonInter,file = "entropyteste")
}

shannonEntropyNormalized <- function(probability){
  h <- probability * log(probability)
  h[is.nan(h)] <- 0
  return(-sum(h)/log(length(probability)))
}

tsallisEntropy <- function(probability,q){  
  entropy = sum(probability^q)
  entropy = (1 - entropy)*(1/(q - 1))
  ent_max = (1 - (length(probability)^(1 - q)))/(q - 1)
  return( entropy/ent_max)
}

renyiEntropy <- function(probability,q){
  entropy = sum(probability^q)
  entropy = log(entropy)
  entropy = entropy * (1/(1 - q))
  return ( entropy/log(length(probability)))
}

readingMPR<-function(dimension,option=0){
  if(dimension == 3){ 
    continua = "continuaN6.txt"
    trozo = "trozosN6.txt"
  }
  if(dimension == 4){ 
    continua = "continuaN24.txt"
    trozo = "trozosN24.txt"
  }
  if(dimension == 5){ 
    continua = "continuaN120.txt"
    trozo = "trozosN120.txt"
  }
  if(dimension == 6){ 
    continua = "continuaN720.txt"
    trozo = "trozosN720.txt"
  }
  curva1x = Read_txt2(continua,1) 
  if(option==1) return(curva1x)
  curva1y = Read_txt2(continua,2)
  if(option==2) return(curva1y)
  curva2x = Read_txt2(trozo,1)
  if(option==3) return(curva2x)
  curva2y = Read_txt2(trozo,2)
  if(option==4) return(curva2y)
}

# Partition indicates the number of parts in which we divide the series
partitionMPR<-function(series,dimension,delay,partition){
  complexity = entropy = rep(0,partition)
  div = floor(length(series)/partition)
  if(partition != 1){
    for(i in 1:partition){
      initial = ((i-1)*div)
      end = initial + div
      if(i == 1){
        initial = 1
        end = div
      }
      aux = series[initial:end]
      probability = distribution(aux,dimension,delay)
      entropy[i] = shannonEntropyNormalized(probability)
      complexity[i] = C(probability)
    }
  }
  else{
    probability = distribution(series,dimension,delay)
    entropy = shannonEntropyNormalized(probability)
    complexity = C(probability)
  }
  print(entropy)
  print(complexity)
  c1x = readingMPR(dimension,1)
  c1y = readingMPR(dimension,2)
  c2x = readingMPR(dimension,3)
  c2y = readingMPR(dimension,4)
  qplot(x=c2x,y=c2y,geom="line",xlab="Shannon Entropy",ylab="MPR Statistical Complexity") +
    ggtitle("Plane Complexity Entropy") + theme(plot.title = element_text(hjust=0.5)) +
    geom_line(aes(x=c1x,c1y)) + geom_point(aes(x=entropy,y=complexity),color="blue")
}

graficoVisibilidade<-function(matriz,op,q){
  entropyShannonInter = rep(0,dim(matriz)[1])
  for(i in 1:dim(matriz)[1]){
    a = matriz[i,1:length(matriz[i,])]
    a = a[a!=0]
    vg = visibilidade(a)
    aa = hist(vg,probability = TRUE)
    if(i == 43){
      write.csv(a,file = "Densidade43")
      write.csv(vg,file = "Grau43")
    }else if(i == 42){
      write.csv(a,file = "Densidade42")
      write.csv(vg,file = "Grau42")
    }else if(i == 56){
      write.csv(a,file = "Densidade56")
      write.csv(vg,file = "Grau56")
    }
    if(op == 1){
      entropyShannonInter[i] = shannonEntropyNormalized(aa$density)
    }else if(op == 2){
      entropyShannonInter[i] = tsallisEntropy(aa$density,q)
    }else{
      entropyShannonInter[i] = renyiEntropy(aa$density,q)
    }
  }
  write.csv(entropyShannonInter,file = "Visibility04")
}




