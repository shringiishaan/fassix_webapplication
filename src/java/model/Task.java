package model;

public class Task 
{
	int id,cost,serviceid;
	String task;
	
	public void setID(int id){this.id=id;}
	public int getID(){return id;}
	
	public void setServiceID(int id){this.serviceid=id;}
	public int getServiceID(){return serviceid;}
	
	public void setTask(String name){this.task = name;}
	public String getTask(){return task;}
	
	public void setCost(int des){this.cost = des;}
	public int getCost(){return cost;}
}