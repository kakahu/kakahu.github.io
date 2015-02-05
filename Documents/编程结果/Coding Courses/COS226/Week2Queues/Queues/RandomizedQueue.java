import java.util.Iterator;
import java.util.NoSuchElementException;

public class RandomizedQueue<Item> implements Iterable<Item> {
	private class Node {
		private Item item;
		private Node next;
		private Node prev;
		public Node(){
			next = null;
			prev = null;
		}

	}
	private int N;
	private Node head;

	public RandomizedQueue(){
		N = 0;
		head = new Node();
	}

	public boolean isEmpty(){
		return N == 0;
	}

	public int size(){
		return N;
	}

	public void enqueue(Item item){
		if (item == null){
			throw new NullPointerException();
		}
		if (isEmpty()){
			Node tmp = new Node();
			tmp.item = item;
			tmp.prev = head;
			tmp.next = head;
			head.next = tmp;
			head.prev = tmp;
		}
		else{
			Node tmp = new Node();
			tmp.item = item;
			tmp.prev = head;
			tmp.next = head.next;
			head.next.prev = tmp;
			head.next = tmp;
		}
		N++;
	}

	public Item dequeue(){
		if (N == 0){
			throw new NoSuchElementException();
		}
		int n = StdRandom.uniform(N); // n between 0 and N-1
		Node tmp = head;
		while (n != 0){
			tmp = tmp.next;
			n--;
		}
		Node deNode = tmp.next;
		tmp.next.next.prev = tmp;
		tmp.next = deNode.next;
		N--;
		return deNode.item;
	}

	public Item sample(){
		if (N == 0){
			throw new NoSuchElementException();
		}
		int n = StdRandom.uniform(N); 
		Node tmp = head;
		while (n != 0){
			tmp = tmp.next;
			n--;
		}
		return tmp.next.item;
	}

	public Iterator<Item> iterator(){
		return new QueueIterator();
	}
	private class QueueIterator implements Iterator<Item>{
		private Node current = head;
		public boolean hasNext(){
			return current.next != head;
		}
		public void remove(){
			throw new UnsupportedOperationException();
		}		
		public Item next(){
			Item item = current.item;
			current = current.next;
			return item;
		}
	}
	public static void main(String[] args){
		RandomizedQueue test = new RandomizedQueue();
		for (int i = 0; i < 10; i++){
			test.enqueue(new Integer(i));
		}
		for (int i = 0; i < 10; i++){
			System.out.println(test.dequeue());
		}
		return;
	}
}