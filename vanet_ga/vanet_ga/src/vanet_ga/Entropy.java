package vanet_ga;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

public class Entropy {	
	private static final String[][] path = {
			{"entropy/entropy0101","entropy/entropy0102","entropy/entropy0103"},
			{"entropy/entropy0201","entropy/entropy0202","entropy/entropy0203"},
			{"entropy/entropy0301","entropy/entropy0302","entropy/entropy0303"},
			{"entropy/entropy0401","entropy/entropy0402","entropy/entropy0403"}};
	private ArrayList<Double> data;
	private ArrayList<Integer> orderedByMax;
	
	
	public Entropy(int i, int j) throws NumberFormatException, IOException{
		BufferedReader reader = new BufferedReader(new FileReader(new File(path[i][j])));
		String iLine = "";
		data = new ArrayList<Double>();
		while((iLine = reader.readLine())!=null){
			String sData[] = iLine.split(",");
			if(!sData[1].contains("x")) data.add(Double.parseDouble(sData[1]));
			
		}
		
		int max = 0;
		double maxValue = 0;
		ArrayList<Double> data2 = (ArrayList<Double>) data.clone();
		orderedByMax = new ArrayList<Integer>();
		for(int m = 0; m < data2.size();m++){
			max = 0;
			maxValue = 0;
			for(int n = 0; n < data2.size();n++){
				if(data2.get(n)>maxValue&&orderedByMax.indexOf(n)==-1){
					maxValue = data2.get(n);
					max = n;
				}
			}
			orderedByMax.add(max);
		}
		reader.close();
	}
	

	public ArrayList<Double> getData(){
		return data;
	}
	
	public ArrayList<Integer> getOrdered(){
		return orderedByMax;
	}
	
	public int getMax(int s){		
		return orderedByMax.get(s);
	}
}
