package vanet_entropy;

public class Rsu {
	private Rsu left, right;
	private Double value;
	private int position;
	private int visibilityWeight;
	
	public Rsu(int position, Double value){
		this.position = position;
		this.value = value;
	}	
	public void setLeft(Rsu l){
		this.left = l;
	}
	public void setRight(Rsu r){
		this.right = r;
	}
	public void setWeight(int w){
		this.visibilityWeight=w;
	}
	public int getPosition(){
		return this.position;
	}
	public Rsu getLeft(){
		return this.left;
	}
	public Rsu getRight(){
		return this.right;
	}
	public Double getValue(){
		return this.value;
	}
	public int getWeight(){
		return this.visibilityWeight;
	}
	
	public void roundLeft(){
		Rsu left = this.getLeft();
		while(left.getPosition()!=this.position){
			left=left.getLeft();	
		}
	}
	
	public void roundRight(){
		Rsu right = this.getRight();
		while(right.getPosition()!=this.position){
			right=right.getRight();		
		}
	}
	
	public void showWeights(){
		System.out.println(this.getPosition()+" - "+this.getWeight());
		Rsu right = this.getRight();
		while(right.getPosition()!=this.position){
			System.out.println(right.getPosition()+" - "+right.getWeight());
			right=right.getRight();		
		}
	}
	
	public void setWeights(){
		this.setWeight(this.countLeft()+this.countRight());
		Rsu right = this.getRight();
		while(right.getPosition()!=this.position){
			right.setWeight(right.countLeft()+right.countRight());
			right=right.getRight();		
		}
	}
	
	public int countLeft(){
		Rsu left = this.getLeft();
		int counter = 0;
		while((left.getPosition()!=this.position)&&(left.getValue()<this.value)){
			counter++;
			left=left.getLeft();		
		}
		return counter;
	}
	
	public int countRight(){
		Rsu right = this.getRight();
		int counter = 0;
		while((right.getPosition()!=this.position)&&(right.getValue()<this.value)){
			counter++;
			right=right.getRight();		
		}
		return counter;
	}
}
