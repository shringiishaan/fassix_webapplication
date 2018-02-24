package manager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import model.Order;

public class OrderManager 
{
	private DataSource dataSource;
	private Connection connection;
	private Statement statement;
	
	public OrderManager()
	{
		try 
		{
			Context initContext  = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			dataSource = (DataSource)envContext.lookup("hsolutionsDB");
		} 
		catch (Exception e) 
		{
			System.out.println("System Error : OrderManager : " + e);
		}
	}
	
	public Order getOrderByID(int id)
	{
		ResultSet resultSet = null;
		Order order = null;
		try 
		{
			connection = dataSource.getConnection();
			statement = connection.createStatement();
			String query = "SELECT * FROM order_master where id="+id+" ;";
			resultSet = statement.executeQuery(query);
			resultSet.next();
			order = new Order();
			order.setID(id);
			order.setServiceID(resultSet.getInt("serviceid"));
			order.setClientLocationID(resultSet.getInt("clientlocationid"));
			order.setClientContact(resultSet.getString("clientcontact"));
			order.setClientAddress(resultSet.getString("clientaddress"));
			order.setNote(resultSet.getString("note"));
			order.setCreateTime(resultSet.getTimestamp("createtime"));
		} 
		catch (SQLException e) 
		{
			System.out.println("System Error : OrderManager/getOrderByID : " + e);
		}
		finally 
		{
			try { if(null!=resultSet)resultSet.close();} catch (SQLException e) 
			{e.printStackTrace();}
			try { if(null!=statement)statement.close();} catch (SQLException e) 
			{e.printStackTrace();}
			try { if(null!=connection)connection.close();} catch (SQLException e) 
			{e.printStackTrace();}
		}
		return order;
	}
	
	public ArrayList<Order> getOrders()
	{
		ResultSet resultSet = null;
		ArrayList<Order> orders = new ArrayList<Order>();
		Order order;
		
		try 
		{
			connection = dataSource.getConnection();
			statement = connection.createStatement();
			String query = "SELECT * FROM order_master order by createtime desc ;";
			resultSet = statement.executeQuery(query);
			while(resultSet.next())
			{
				order = new Order();
				order.setID(resultSet.getInt("id"));
				order.setServiceID(resultSet.getInt("serviceid"));
				order.setClientLocationID(resultSet.getInt("clientlocationid"));
				order.setNote(resultSet.getString("note"));
				order.setClientContact(resultSet.getString("clientcontact"));
				order.setClientAddress(resultSet.getString("clientaddress"));
				order.setCreateTime(resultSet.getTimestamp("createtime"));
				orders.add(order);
			}
		} 
		catch (SQLException e) 
		{
			System.out.println("System Error : OrderManager/getOrders : " + e);
		}
		finally 
		{
			try { if(null!=resultSet)resultSet.close();} catch (SQLException e) 
			{e.printStackTrace();}
			try { if(null!=statement)statement.close();} catch (SQLException e) 
			{e.printStackTrace();}
			try { if(null!=connection)connection.close();} catch (SQLException e) 
			{e.printStackTrace();}
		}
		return orders;
	}
	
	public ArrayList<Order> getOrdersHistory()
	{
		ResultSet resultSet = null;
		ArrayList<Order> orders = new ArrayList<Order>();
		Order order;
		
		try 
		{
			connection = dataSource.getConnection();
			statement = connection.createStatement();
			String query = "SELECT * FROM order_history order by createtime desc ;";
			resultSet = statement.executeQuery(query);
			while(resultSet.next())
			{
				order = new Order();
				order.setID(resultSet.getInt("id"));
				order.setServiceID(resultSet.getInt("serviceid"));
				order.setClientLocationID(resultSet.getInt("clientlocationid"));
				order.setNote(resultSet.getString("note"));
				order.setClientContact(resultSet.getString("clientcontact"));
				order.setClientAddress(resultSet.getString("clientaddress"));
				order.setCreateTime(resultSet.getTimestamp("createtime"));
				order.setWorkerID(resultSet.getInt("workerid"));
				order.setLabourCost(resultSet.getString("labourcost"));
				order.setMaterialCost(resultSet.getString("materialcost"));
				order.setVisitingCost(resultSet.getString("visitingcost"));
				order.setDebt(resultSet.getString("debt"));
				order.setIncome(resultSet.getString("income"));
				
				orders.add(order);
			}
		} 
		catch (SQLException e) 
		{
			System.out.println("System Error : OrderManager/getOrdersHistory : " + e);
		}
		finally 
		{
			try { if(null!=resultSet)resultSet.close();} catch (SQLException e) 
			{e.printStackTrace();}
			try { if(null!=statement)statement.close();} catch (SQLException e) 
			{e.printStackTrace();}
			try { if(null!=connection)connection.close();} catch (SQLException e) 
			{e.printStackTrace();}
		}
		return orders;
	}
	
	public ArrayList<Order> getOrders(String where)
	{
		ResultSet resultSet = null;
		ArrayList<Order> orders = new ArrayList<Order>();
		Order order;
		
		try 
		{
			connection = dataSource.getConnection();
			statement = connection.createStatement();
			String query = "SELECT * FROM order_master where "+where+" order by createtime desc ;";
			resultSet = statement.executeQuery(query);
			while(resultSet.next())
			{
				order = new Order();
				order.setID(resultSet.getInt("id"));
				order.setServiceID(resultSet.getInt("serviceid"));
				order.setClientLocationID(resultSet.getInt("clientlocationid"));
				order.setNote(resultSet.getString("note"));
				order.setClientContact(resultSet.getString("clientcontact"));
				order.setClientAddress(resultSet.getString("clientaddress"));
				order.setCreateTime(resultSet.getTimestamp("createtime"));
				orders.add(order);
			}
		} 
		catch (SQLException e) 
		{
			System.out.println("System Error : OrderManager/getOrders : " + e);
		}
		finally 
		{
			try { if(null!=resultSet)resultSet.close();} catch (SQLException e) 
			{e.printStackTrace();}
			try { if(null!=statement)statement.close();} catch (SQLException e) 
			{e.printStackTrace();}
			try { if(null!=connection)connection.close();} catch (SQLException e) 
			{e.printStackTrace();}
		}
		return orders;
	}

	public int createOrder(Order order)
	{		
		try 
		{
			connection = dataSource.getConnection();
			statement = connection.createStatement();
			if(statement.executeUpdate("insert into order_master "
					+ "(serviceid,clientcontact,clientlocationid,note,clientaddress) "
					+ "values ("
					+ order.getServiceID() + ",'"
					+ order.getClientContact() + "',"
					+ order.getClientLocationID() + ",'"
					+ order.getNote() + "','"
					+ order.getClientAddress() + "');")==1)
				return 1;
			else return 0;
		} 
		catch (SQLException e) 
		{
			System.out.println("System Error : OrderManager/createOrder : " + e);
		}
		finally 
		{
			try { if(null!=statement)statement.close();} catch (SQLException e) 
			{e.printStackTrace();}
			try { if(null!=connection)connection.close();} catch (SQLException e) 
			{e.printStackTrace();}
		}
		return 0;
	}

	public int removeOrder(int oid)
	{		
		try 
		{
			connection = dataSource.getConnection();
			statement = connection.createStatement();
			if(statement.executeUpdate("delete from order_master where id="+oid+";")==1)
				return 1;
			else return 0;
		} 
		catch (SQLException e) 
		{
			System.out.println("System Error : OrderManager/removeOrder : " + e);
		}
		finally 
		{
			try { if(null!=statement)statement.close();} catch (SQLException e) 
			{e.printStackTrace();}
			try { if(null!=connection)connection.close();} catch (SQLException e) 
			{e.printStackTrace();}
		}
		return 0;
	}

	public int removeOrderRecord(int oid)
	{		
		try 
		{
			connection = dataSource.getConnection();
			statement = connection.createStatement();
			if(statement.executeUpdate("delete from order_history where id="+oid+";")==1)
				return 1;
			else return 0;
		} 
		catch (SQLException e) 
		{
			System.out.println("System Error : OrderManager/removeOrderRecord : " + e);
		}
		finally 
		{
			try { if(null!=statement)statement.close();} catch (SQLException e) 
			{e.printStackTrace();}
			try { if(null!=connection)connection.close();} catch (SQLException e) 
			{e.printStackTrace();}
		}
		return 0;
	}

	public int createOrderInHistory(Order order)
	{		
		try 
		{
			connection = dataSource.getConnection();
			statement = connection.createStatement();
			if(statement.executeUpdate("insert into order_history "
					+ "(serviceid,clientcontact,clientlocationid,note,clientaddress,workerid,labourcost,materialcost,visitingcost,income,debt) "
					+ "values ("
					+ order.getServiceID() + ",'"
					+ order.getClientContact() + "',"
					+ order.getClientLocationID() + ",'"
					+ order.getNote() + "','"
					+ order.getClientAddress() + "',"
					+ order.getWorkerID() + ","
					+ order.getLabourCost() + ","
					+ order.getMaterialCost() + ","
					+ order.getVisitingCost() + ","
					+ order.getIncome() + ","
					+ order.getDebt() + ");")==1)
				return 1;
			else return 0;
		} 
		catch (SQLException e) 
		{
			System.out.println("System Error : OrderManager/createOrderHistory : " + e);
		}
		finally 
		{
			try { if(null!=statement)statement.close();} catch (SQLException e) 
			{e.printStackTrace();}
			try { if(null!=connection)connection.close();} catch (SQLException e) 
			{e.printStackTrace();}
		}
		return 0;
	}
	
	public boolean isOrder(String clientid,int serviceid)
	{
		ResultSet resultSet = null;
		try 
		{
			connection = dataSource.getConnection();
			statement = connection.createStatement();
			String query = "SELECT * FROM order_master where clientid="+clientid+" and serviceid="+serviceid+" ;";
			resultSet = statement.executeQuery(query);
			return resultSet.next();
		}
		catch (SQLException e) 
		{
			System.out.println("System Error : OrderManager/isOrder : " + e);
		}
		finally 
		{
			try { if(null!=resultSet)resultSet.close();} catch (SQLException e) 
			{e.printStackTrace();}
			try { if(null!=statement)statement.close();} catch (SQLException e) 
			{e.printStackTrace();}
			try { if(null!=connection)connection.close();} catch (SQLException e) 
			{e.printStackTrace();}
		}
		return false;
	}
}
