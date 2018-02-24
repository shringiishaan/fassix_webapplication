package model;

public class Admin 
{
	int id;
	String name,email,password;

	public Admin() {}

	public int getID() {return id;}
	public void setID(int id) {this.id = id;}
	
	public String getName()	{return name;}
	public void setName(String nam)	{this.name = nam;}

	public String getEmail() {return email;}
	public void setEmail(String nam) {this.email = nam;}

	public String getPassword()	{return password;}
	public void setPassword(String nam)	{this.password = nam;}
}
