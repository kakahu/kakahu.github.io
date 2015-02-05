import java.util.Iterator;
import java.util.NoSuchElementException;

public class Deque<Item> implements Iterable<Item> {
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

	public Deque(){
		N = 0;
		head = new Node();
	}

	public boolean isEmpty(){
		return N == 0;
	}

	public int size(){
		return N;
	}

	public void addFirst(Item item){
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

	public void addLast(Item item){
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
			tmp.next = head;
			tmp.prev = head.prev;
			head.prev.next = tmp;
			head.prev = tmp;
		}
		N++;		
	}

	public Item removeFirst(){
		if (isEmpty()){
			throw new NoSuchElementException();
		}
		Node tmp = head.next;
		head.next = head.next.next;
		tmp.next.prev = head;
		tmp.next = null;
		tmp.prev = null;
		N--;
		return tmp.item;
	}

	public Item removeLast(){
		if (isEmpty()){
			throw new NoSuchElementException();
		}
		Node tmp = head.prev;
		head.prev = head.prev.prev;
		tmp.prev.next = head;
		tmp.prev = null;
		tmp.next = null;
		N--;
		return tmp.item;
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
		Deque test = new Deque();
		test.addFirst(new Integer(1));
		test.addFirst(new Integer(2));
		test.addFirst(new Integer(3));
		System.out.println(test.removeFirst());
		System.out.println(test.removeLast());
		return;
	}
}