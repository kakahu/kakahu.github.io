public class Subset {
	public Subset(){

	}

	public static void main(String[] args) {
		int k = Integer.parseInt(args[0]);
		RandomizedQueue test = new RandomizedQueue();
		String string;
		while (!StdIn.isEmpty()){
			string = StdIn.readString();
//			System.out.println(string);
			test.enqueue(string);
		}	
		for (int i = 0; i < k; i++){
			System.out.println(test.dequeue());
		}
			/*
		for (int i = 0; i < strings.length; i++){
			test.enqueue(Integer.parseInt(strings[i]));
		}
		for (int i = 0; i < k; i++){
			System.out.println(test.dequeue());
		}
		*/
	}
}