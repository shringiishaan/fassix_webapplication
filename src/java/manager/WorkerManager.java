package manager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import model.Service;
import model.Worker;

public class WorkerManager 
{
	private DataSource dataSource;
	private Connection connection;
	private Statement statement;
	
	public WorkerManager()
	{
		try 
		{
			Context initContext  = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			dataSource = (DataSource)envContext.lookup("hsolutionsDB");
		} 
		catch (Exception e) 
		{
			System.out.println("System Error : WorkerManager : " + e);
		}
	}
	
	public Worker getWorkerByID(int id)
	{
		ResultSet resultSet = null;
		Worker worker = null;
		try 
		{
			connection = dataSource.getConnection();
			statement = connection.createStatement();
			String query = "SELECT * FROM worker_master where id="+id+" ;";
			resultSet = statement.executeQuery(query);
			while (resultSet.next()) 
			{
				worker = new Worker();
				worker.setID(id);
				worker.setName(resultSet.getString("name"));
				worker.setContact(resultSet.getString("contact"));
			}
		} 
		catch (SQLException e) 
		{
			System.out.println("System Error : WorkerManager/getWorkerByID : " + e);
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
		return worker;
	}
	
	public Worker getWorkerByName(String name)
	{
		ResultSet resultSet = null;
		Worker worker = null;
		try 
		{
			connection = dataSource.getConnection();
			statement = connection.createStatement();
			String query = "SELECT * FROM worker_master where name='"+name+"' ;";
			resultSet = statement.executeQuery(query);
			while (resultSet.next()) 
			{
				worker = new Worker();
				worker.setID(resultSet.getInt("id"));
				worker.setName(resultSet.getString("name"));
				worker.setContact(resultSet.getString("contact"));
			}
		} 
		catch (SQLException e) 
		{
			System.out.println("System Error : WorkerManager/getWorkerByContact : " + e);
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
		return worker;
	}

	public int createWorker(Worker worker)
	{		
		try 
		{
			connection = dataSource.getConnection();
			statement = connection.createStatement();
			if(statement.executeUpdate("insert into worker_master "
					+ "(name,contact) "
					+ "values ('"
					+ worker.getName() + "','"
					+ worker.getContact() + "') ;")==1)
				return 1;
			else return 0;
		} 
		catch (SQLException e) 
		{
			System.out.println("System Error : WorkerManager/createWorker : " + e);
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
	
	public int deleteWorkerByID(int id)
	{		
		try
		{
			connection = dataSource.getConnection();
			statement = connection.createStatement();
			if(statement.executeUpdate("delete from worker_master where id = "+ id +" ;")==1)
				return 1;
			else return 0;
		}
		catch (SQLException e) 
		{
			System.out.println("System Error : WorkerManager/deleteWorkerByID : " + e);
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
	
	public ArrayList<Worker> getWorkers(String orderBy)
	{
		ResultSet resultSet = null;
		ArrayList<Worker> workers = new ArrayList<Worker>();
		Worker worker = null;
		try 
		{
			connection = dataSource.getConnection();
			statement = connection.createStatement();
			String query = "SELECT * FROM worker_master order by "+orderBy+" ;";
			resultSet = statement.executeQuery(query);
			while (resultSet.next()) 
			{
				worker = new Worker();
				worker.setID(resultSet.getInt("id"));
				worker.setName(resultSet.getString("name"));
				worker.setContact(resultSet.getString("contact"));
				workers.add(worker);
			}
		} 
		catch (SQLException e) 
		{
			System.out.println("System Error : WorkerManager/getWorkers : " + e);
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
		return workers;
	}
	
	public int getDebtByID(int id)
	{
		ResultSet resultSet = null;
		try 
		{
			connection = dataSource.getConnection();
			statement = connection.createStatement();
			String query = "SELECT sum(debt) FROM order_history where workerid="+id+" ;";
			resultSet = statement.executeQuery(query);
			if(resultSet.next())
			{
				return resultSet.getInt(1);
			}
			return 0;
		} 
		catch (SQLException e) 
		{
			System.out.println("System Error : WorkerManager/getDebtByID : " + e);
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
		return 0;
	}
	
	public int getOrdersCountByWorkerID(int id)
	{
		ResultSet resultSet = null;
		try 
		{
			connection = dataSource.getConnection();
			statement = connection.createStatement();
			String query = "SELECT count(*) FROM order_history where workerid="+id+" ;";
			resultSet = statement.executeQuery(query);
			if(resultSet.next())
			{
				return resultSet.getInt(1);
			}
			return 0;
		} 
		catch (SQLException e) 
		{
			System.out.println("System Error : WorkerManager/getOrdersCountByWorkerID : " + e);
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
		return 0;
	}

	public int updateWorkerByID(Worker worker)
	{		
		try 
		{
			connection = dataSource.getConnection();
			statement = connection.createStatement();
			if(statement.executeUpdate("update worker_master "
					+ " set "
					+ " name = '"
					+ worker.getName() + "' , contact = '"
					+ worker.getContact() + "' where id = "+ worker.getID() +" ;")==1)
				return 1;
			else return 0;
		} 
		catch (SQLException e) 
		{
			System.out.println("System Error : WorkerManager/updateWorkerByID : " + e);
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

	public void clearWorkerDebtByID(int id)
	{		
		try 
		{
			connection = dataSource.getConnection();
			statement = connection.createStatement();
			statement.executeUpdate("update order_history set debt = 0 where workerid = "+ id +" ;");
		} 
		catch (SQLException e) 
		{
			System.out.println("System Error : WorkerManager/clearWorkerDebtByID : " + e);
		}
		finally 
		{
			try { if(null!=statement)statement.close();} catch (SQLException e) 
			{e.printStackTrace();}
			try { if(null!=connection)connection.close();} catch (SQLException e) 
			{e.printStackTrace();}
		}
	}
}
