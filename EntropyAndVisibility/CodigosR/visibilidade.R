visibilidade<-function(serieT){
  grau = rep(1,length(serieT))
  for(i in 1:length(serieT)){
    if(i == 1){
      #Somando o grau a direita
      if((i+2)<=length(serieT)){
        for(j in (i+2):length(serieT)){
          if((serieT[j]<=serieT[j-1])&&(serieT[j-1]>=serieT[i])){
            break
          }else if((serieT[j]<serieT[j-1])&&((serieT[j-1]-serieT[j])>(serieT[i]-serieT[j-1]))){
            if((j+1)<=length(serieT)){
              if((serieT[j+1]<serieT[j-1])&&((serieT[j-1]-serieT[j+1])>(serieT[i]-serieT[j-1]))){
                break
              }
            }
          }else if((serieT[j]<serieT[j-1])&&(serieT[j]==serieT[i])){
            break
          }else{
            grau[i] = grau[i] +1
          }
        }
      }
    }else if(i == length(serieT)){
      #Somando o grau a esquerda
      j = i - 2
      if((i-2)>=1){
        while(j != 0){
          if((serieT[j]<=serieT[j+1])&&(serieT[j+1]>=serieT[i])){
            break
          }else if((serieT[j]<serieT[j+1])&&((serieT[j+1]-serieT[j])>(serieT[i]-serieT[j+1]))){
            if((j-1)>=1){
              if((serieT[j-1]<serieT[j+1])&&((serieT[j+1]-serieT[j-1])>(serieT[i]-serieT[j+1]))){
                break
              }
            }
          }else if((serieT[j]<serieT[j+1])&&(serieT[j]==serieT[i])){
            break
          }else{
            grau[i] = grau[i] + 1
          }
          j = j - 1
        }
      }
    }else{
      grau[i] = grau[i] +1 
      #Somando o grau a direita
      if((i+2)<=length(serieT)){
        for(j in (i+2):length(serieT)){
          if((serieT[j]<=serieT[j-1])&&(serieT[j-1]>=serieT[i])){
            break
          }else if((serieT[j]<serieT[j-1])&&((serieT[j-1]-serieT[j])>(serieT[i]-serieT[j-1]))){
            if((j+1)<=length(serieT)){
              if((serieT[j+1]<serieT[j-1])&&((serieT[j-1]-serieT[j+1])>(serieT[i]-serieT[j-1]))){
                break
              }
            }
          }else if((serieT[j]<serieT[j-1])&&(serieT[j]==serieT[i])){
            break
          }else{
            grau[i] = grau[i] +1
          }
        }
      }
      #Somando o grau a esquerda
      j = i - 2
      if((i-2)>=1){
        while(j != 0){
          if((serieT[j]<=serieT[j+1])&&(serieT[j+1]>=serieT[i])){
            break
          }else if((serieT[j]<serieT[j+1])&&((serieT[j+1]-serieT[j])>(serieT[i]-serieT[j+1]))){
            if((j-1)>=1){
              if((serieT[j-1]<serieT[j+1])&&((serieT[j+1]-serieT[j-1])>(serieT[i]-serieT[j+1]))){
                break
              }
            }
          }else if((serieT[j]<serieT[j+1])&&(serieT[j]==serieT[i])){
            break
          }else{
            grau[i] = grau[i] + 1
          }
          j = j - 1
        }
      }
    }
  }
  grau
}