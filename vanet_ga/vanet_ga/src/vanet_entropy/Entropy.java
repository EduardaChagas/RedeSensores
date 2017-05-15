package vanet_entropy;

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
	private Rsu first;
	
	
	
	
	public Entropy(int i, int j) throws NumberFormatException, IOException{
		BufferedReader reader = new BufferedReader(new FileReader(new File(path[i][j])));
		String iLine = "";
		data = new ArrayList<Double>();
		while((iLine = reader.readLine())!=null){
			String sData[] = iLine.split(",");
			if(!sData[1].contains("x")) data.add(Double.parseDouble(sData[1]));
			
		}
		
		Rsu first = new Rsu(0,data.get(0));
		Rsu rsu = first;
		for(int m = 1;m<data.size()-1;m++){
			Rsu newRsu = new Rsu(m,data.get(m));
			if(m==1) first.setRight(newRsu);
			newRsu.setLeft(rsu);
			rsu = newRsu;
		}
		Rsu last = new Rsu(data.size()-1,data.get(data.size()-1));
		rsu.setRight(last);
		last.setLeft(rsu);
		last.setRight(first);
		first.setLeft(last);
		
		while(rsu.getPosition()!=last.getPosition()){
			Rsu left = rsu.getLeft();
			left.setRight(rsu);
			rsu=left;			
		}
		
		first.setWeights();
		
		this.first = first;	
		reader.close();
	}
	

	public ArrayList<Double> getData(){
		return data;
	}
	
	public ArrayList<Integer> getOrdered(){
		return orderedByMax;
	}
	
	public Rsu getFirst(){
		return this.first;
	}
	
	public int getMax(int s){		
		return orderedByMax.get(s);
	}
	
	public void showWeights(){

		first.showWeights();	
	}
}
