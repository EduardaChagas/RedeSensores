package vanet_entropy;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

public class Main {
	private static final String[] path = {"E0-T-60s-4CP","E1-T-60s-4CP","E2-T-60s-4CP","E3-T-60s-4CP"};

	public static void main(String[] args) {
		int numberOfRSUs = 5;
		int i = 3;
		try {
			Entropy e = new Entropy(i,2);
			e.showWeights();
			
			Individual ind = new Individual(e.getFirst(),numberOfRSUs);

			ArrayList<ArrayList<Integer>> matrix = readMatrix(path[i]);
			int numberOfVehicles = matrix.get(0).size();

			
			double fitness = ind.calcFitness(numberOfVehicles, numberOfRSUs, matrix, 30);
			System.out.println(fitness);
			
		} catch (NumberFormatException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

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
