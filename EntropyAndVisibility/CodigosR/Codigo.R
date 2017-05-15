library(ggplot2)
require(igraph)

#Lendo o dataset contendo os dados
ReadData<-function(){
  matriz = data.matrix(read.table(file.choose()))
  matriz
}

Read_txt<-function(name,column){
  data = read.table(name, stringsAsFactors=FALSE, fileEncoding="latin1")
  data = data[,column]
  if(mode(data)=="character"){
    data = type.convert(data)
  }
  data = na.omit(data)
  return(data)
}

EntropyComplexityData<-function(matriz){
  entropyShannonInter = complexidade = rep(0,dim(matriz)[1])
  for(i in 1:dim(matriz)[1]){
    a = matriz[i,1:length(matriz[i,])]
    a = a[a!=0]
    aa = hist(a)
    entropyShannonInter[i] = shannonEntropyNormalized(aa$density)
    complexidade[i] = C(aa$density)
  }
  write.csv(entropyShannonInter,file = "entropy")
  write.csv(complexidade,file = "Complexidade")
}

partitionMPR<-function(matriz,dimension,delay){
  entropy = complexity = rep(0,dim(matriz)[1])
  for(i in 1:dim(matriz)[1]){
    a = matriz[i,1:length(matriz[i,])]
    a = a[a!=0]
    aa = hist(a)
    entropy[i] = shannonEntropyNormalized(aa$density)
    complexity[i] = C(aa$density)
  }
  c1x = readingMPR(dimension,1)
  c1y = readingMPR(dimension,2)
  c2x = readingMPR(dimension,3)
  c2y = readingMPR(dimension,4)
  qplot(x=c2x,y=c2y,geom="line",xlab="Shannon Entropy",ylab="MPR Statistical Complexity") +
    ggtitle("Plane Complexity Entropy") + theme(plot.title = element_text(hjust=0.5)) +
    geom_line(aes(x=c1x,c1y)) + geom_point(aes(x=entropy,y=complexity),color="blue")
}

graficoVisibilidade<-function(matriz){
  entropyShannonInter = rep(0,dim(matriz)[1])
  for(i in 1:dim(matriz)[1]){
    a = matriz[i,1:length(matriz[i,])]
    a = a[a!=0]
    vg = visibilidade(a)
    aa = hist(vg)
    entropyShannonInter[i] = shannonEntropyNormalized(aa$density)
  }
  write.csv(entropyShannonInter,file = "Visibility")
}

shannonEntropyNormalized <- function(probability){
  h <- probability * log(probability)
  h[is.nan(h)] <- 0
  return(-sum(h)/log(length(probability)))
}

jensenDivergence<-function(p){
  q = rep(1/length(p),length(p))
  s_p = shannonEntropy(p)
  s_q = shannonEntropy(q)
  s_pq = shannonEntropy((p+q)/2)
  divergence = sum( s_pq - (s_p/2) - (s_q/2))
  return(divergence)
}

C<-function(p){
  c <- jensenDivergence(p) * constant(p) * shannonEntropyNormalized(p)
  return(c)
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
  curva1x = Read_txt(continua,1) 
  if(option==1) return(curva1x)
  curva1y = Read_txt(continua,2)
  if(option==2) return(curva1y)
  curva2x = Read_txt(trozo,1)
  if(option==3) return(curva2x)
  curva2y = Read_txt(trozo,2)
  if(option==4) return(curva2y)
}







