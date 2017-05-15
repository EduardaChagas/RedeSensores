package vanet_entropy;

import java.util.ArrayList;

public class Individual {
	private ArrayList<Rsu> rsus;
	
	public Individual(Rsu first, int nRsus){
		rsus = new ArrayList<Rsu>();

		rsus.add(first);

		Rsu right = first.getRight();
		while(right.getPosition()!=first.getPosition()){
			if(rsus.size()<nRsus){
				rsus.add(right);
			}else{
				double min = right.getWeight();
				int pos = 0;
				for(int i = 0; i<nRsus;i++){
					if(rsus.get(i).getWeight()<min){
						pos = i;
						min = rsus.get(i).getWeight();
					}
				}
				if(min<right.getWeight()){
					rsus.remove(pos);
					rsus.add(right);
				}
			}
			right=right.getRight();		
		}
	}
	
	
	public Double calcFitness(int numberOfVehicles, int numberOfRSUs, ArrayList<ArrayList<Integer>> matrix, int iTime) {
		int coverage = 0;
		for (int j = 0; j < numberOfVehicles; j++) {
			int sum = 0;
			for (int i = 0; i < numberOfRSUs; i++) {
				sum += matrix.get(rsus.get(i).getPosition()).get(j);
			}
			if (sum >= iTime)
				coverage++;
		}
		return ((double) coverage*100) / numberOfVehicles;
	}
}
