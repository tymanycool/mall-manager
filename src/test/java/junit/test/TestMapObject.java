package junit.test;

import java.util.Map;

class Person{
	int age;
	String name;
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}
public class TestMapObject {
	
	public static void main(String[] args) {
		Person person = new Person();
		person.setName("tianyao");
		Map map = (Map)person;
		System.out.println(map.get("name"));
	}
}
