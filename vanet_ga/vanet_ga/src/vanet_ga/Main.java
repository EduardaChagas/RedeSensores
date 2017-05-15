package vanet_ga;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

public class Main {
	private static final String[] path = {"E0-T-60s-4CP","E1-T-60s-4CP","E2-T-60s-4CP","E3-T-60s-4CP"};
	
	

	public static void main(String[] args) {
		
		long millis = System.nanoTime();
		try {
			for(int i = 3; i>=0;i--){
				for(int j = 0; j<3;j++){
					for(int k = 5; k<=25;k+=5){
//						Entropy e = new Entropy(i,j);
//						//nGenerations, popSize, nRsus, time, crossProb, mutProb, matrix
//						Genetic genetic3 = new Genetic(100,200,k,30,0.80,0.10,readMatrix(path[i]),e);
//						System.out.println("cenario: "+i+"|entropia: "+j+"|rsu: "+k+"|resultado: "+genetic3.evolve());
					}
				}
			}
			
			Entropy e = new Entropy(3,0);
			//nGenerations, popSize, nRsus, time, crossProb, mutProb, matrix
			Genetic genetic3 = new Genetic(100,200,5,30,0.80,0.10,readMatrix(path[3]),e);
			System.out.println("cenario: "+3+"|entropia: "+0+"|rsu: "+5+"|resultado: "+genetic3.evolve());			
			
			
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		millis = System.nanoTime() - millis;
        millis=millis/1000000;
        System.out.println("time: "+millis);
	}
	
	private static ArrayList<ArrayList<Integer>> readMatrix(String path) throws IOException{
		System.out.print("reading matrix...");
		ArrayList<ArrayList<Integer>> matrix = new ArrayList<ArrayList<Integer>>();		
		BufferedReader reader = new BufferedReader(new FileReader(new File(path)));
		String iLine = "";
		while((iLine = reader.readLine())!=null){
			String sData[] = iLine.split(" ");
			ArrayList<Integer> data = new ArrayList<Integer>();
			for(int i  = 0;i<sData.length;i++){
				data.add(Integer.parseInt(sData[i]));
			}
			matrix.add(data);
		}
		reader.close();
		System.out.println(" done");
		return matrix;
	}
}
