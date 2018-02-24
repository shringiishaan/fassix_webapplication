package model;

import java.sql.Timestamp;

public class Order 
{
	int id,serviceid,clientlocationid,workerid;
	String clientcontact,clientaddress,note,visitingcost,labourcost,materialcost,income,debt;
	Timestamp createtime;
	
	public void setID(int id){this.id = id;}
	public int getID(){return id;}
	
	public void setServiceID(int id){this.serviceid = id;}
	public int getServiceID() {return serviceid;}
	
	public void setClientLocationID(int id){this.clientlocationid = id;}
	public int getClientLocationID(){return clientlocationid;}

	public String getClientContact(){return clientcontact;}
	public void setClientContact(String s){this.clientcontact = s;}

	public String getClientAddress(){return clientaddress;}
	public void setClientAddress(String s){this.clientaddress = s;}

	public String getNote(){return note;}
	public void setNote(String s){this.note = s;}

	public String getLabourCost(){return labourcost;}
	public void setLabourCost(String s){this.labourcost = s;}

	public String getMaterialCost(){return materialcost;}
	public void setMaterialCost(String s){this.materialcost = s;}

	public String getVisitingCost(){return visitingcost;}
	public void setVisitingCost(String s){this.visitingcost = s;}

	public String getIncome(){return income;}
	public void setIncome(String s){this.income = s;}

	public String getDebt(){return debt;}
	public void setDebt(String s){this.debt = s;}
	
	public void setWorkerID(int id){this.workerid = id;}
	public int getWorkerID() {return workerid;}

	public Timestamp getCreateTime(){return createtime;}
	public void setCreateTime(Timestamp s){this.createtime = s;}
}
