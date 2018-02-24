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
import model.Service;
import model.Task;

public class ServiceManager 
{
	private DataSource dataSource;
	private Connection connection;
	private Statement statement;
	
	public ServiceManager()
	{
		try 
		{
			Context initContext  = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			dataSource = (DataSource)envContext.lookup("hsolutionsDB");
		} 
		catch (Exception e) 
		{
			System.out.println("System Error : ServiceManager : " + e);
		}
	}
	
	public Service getServiceByID(int id)
	{
		ResultSet resultSet = null;
		Service service = null;
		try 
		{
			connection = dataSource.getConnection();
			statement = connection.createStatement();
			String query = "SELECT * FROM service_master where id="+id+" ;";
			resultSet = statement.executeQuery(query);
			resultSet.next();
			service = new Service();
			service.setID(id);
			service.setName(resultSet.getString("name"));
			service.setDescription(resultSet.getString("description"));
		} 
		catch (SQLException e) 
		{
			System.out.println("System Error : ServiceManager/getServiceByID : " + e);
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
		return service;
	}
	
	public Service getServiceByName(String name)
	{
		ResultSet resultSet = null;
		Service service = null;
		try 
		{
			connection = dataSource.getConnection();
			statement = connection.createStatement();
			String query = "SELECT * FROM service_master where name='"+name+"' ;";
			resultSet = statement.executeQuery(query);
			resultSet.next();
			service = new Service();
			service.setID(resultSet.getInt("id"));
			service.setName(resultSet.getString("name"));
			service.setDescription(resultSet.getString("description"));
		} 
		catch (SQLException e) 
		{
			System.out.println("System Error : ServiceManager/getServiceByEmail : " + e);
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
		return service;
	}
	
	public ArrayList<Service> getServices(String orderBy)
	{
		ResultSet resultSet = null;
		ArrayList<Service> services = new ArrayList<Service>();
		Service service = null;
		try 
		{
			connection = dataSource.getConnection();
			statement = connection.createStatement();
			String query = "SELECT * FROM service_master order by "+orderBy+" ;";
			resultSet = statement.executeQuery(query);
			while (resultSet.next()) 
			{
				service = new Service();
				service.setID(resultSet.getInt("id"));
				service.setName(resultSet.getString("name"));
				service.setDescription(resultSet.getString("description"));
				services.add(service);
			}
		} 
		catch (SQLException e) 
		{
			System.out.println("System Error : ServiceManager/getServices : " + e);
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
		return services;
	}
	
	public ArrayList<Task> getServiceTasks(int serviceId)
	{
		ResultSet resultSet = null;
		ArrayList<Task> tasks = new ArrayList<Task>();
		Task task = null;
		try 
		{
			connection = dataSource.getConnection();
			statement = connection.createStatement();
			String query = "SELECT * FROM service_details where serviceid = "+serviceId+" ;";
			resultSet = statement.executeQuery(query);
			while (resultSet.next()) 
			{
				task = new Task();
				task.setID(resultSet.getInt("id"));
				task.setTask(resultSet.getString("task"));
				task.setCost(resultSet.getInt("cost"));
				task.setServiceID(resultSet.getInt("serviceid"));
				tasks.add(task);
			}
		} 
		catch (SQLException e) 
		{
			System.out.println("System Error : ServiceManager/getServiceTasks : " + e);
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
		return tasks;
	}
	
	public ArrayList<Task> getAllTasks()
	{
		ResultSet resultSet = null;
		ArrayList<Task> tasks = new ArrayList<Task>();
		Task task = null;
		try 
		{
			connection = dataSource.getConnection();
			statement = connection.createStatement();
			String query = "SELECT * FROM service_details ;";
			resultSet = statement.executeQuery(query);
			while (resultSet.next()) 
			{
				task = new Task();
				task.setID(resultSet.getInt("id"));
				task.setTask(resultSet.getString("task"));
				task.setCost(resultSet.getInt("cost"));
				task.setServiceID(resultSet.getInt("serviceid"));
				tasks.add(task);
			}
		} 
		catch (SQLException e) 
		{
			System.out.println("System Error : ServiceManager/getAllTasks : " + e);
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
		return tasks;
	}

	public int deleteServiceByID(int serviceid)
	{		
		try 
		{
			connection = dataSource.getConnection();
			statement = connection.createStatement();
			statement.executeUpdate("delete from service_details where serviceid = "+ serviceid +" ;");
			if(statement.executeUpdate("delete from service_master where id = "+ serviceid +" ;")==1)
				return 1;
			else return 0;
		} 
		catch (SQLException e) 
		{
			System.out.println("System Error : ServiceManager/deleteServiceByID : " + e);
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


	public int deleteTaskByID(int taskid)
	{		
		try 
		{
			connection = dataSource.getConnection();
			statement = connection.createStatement();
			if(statement.executeUpdate("delete from service_details where id = "+ taskid +" ;")==1)
				return 1;
			else return 0;
		} 
		catch (SQLException e) 
		{
			System.out.println("System Error : ServiceManager/deleteTaskByID : " + e);
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

	public int createTask(Task task)
	{		
		try 
		{
			connection = dataSource.getConnection();
			statement = connection.createStatement();
			if(statement.executeUpdate("insert into service_details "
					+ "(serviceid,task,cost) "
					+ "values ("
					+ task.getServiceID() + ",'"
					+ task.getTask() + "',"
					+ task.getCost() + ") ;")==1)
				return 1;
			else return 0;
		} 
		catch (SQLException e) 
		{
			System.out.println("System Error : ServiceManager/createTask : " + e);
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

	public int updateServiceByID(Service service)
	{		
		try 
		{
			connection = dataSource.getConnection();
			statement = connection.createStatement();
			if(statement.executeUpdate("update service_master "
					+ " set "
					+ " name = '"
					+ service.getName() + "' , description = '"
					+ service.getDescription() + "' where id = "+ service.getID() +" ;")==1)
				return 1;
			else return 0;
		} 
		catch (SQLException e) 
		{
			System.out.println("System Error : ServiceManager/updateServiceByID : " + e);
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

	public int updateTaskByID(Task task)
	{		
		try 
		{
			connection = dataSource.getConnection();
			statement = connection.createStatement();
			if(statement.executeUpdate("update service_details "
					+ " set "
					+ " task = '"
					+ task.getTask() + "' , cost = "
					+ task.getCost() + " where id = "+ task.getID() +" ;")==1)
				return 1;
			else return 0;
		} 
		catch (SQLException e) 
		{
			System.out.println("System Error : ServiceManager/updateTaskByID : " + e);
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

	public int createService(Service service)
	{		
		try 
		{
			connection = dataSource.getConnection();
			statement = connection.createStatement();
			if(statement.executeUpdate("insert into service_master "
					+ "(name,description) "
					+ "values ('"
					+ service.getName() + "','"
					+ service.getDescription() + "') ;")==1)
				return 1;
			else return 0;
		} 
		catch (SQLException e) 
		{
			System.out.println("System Error : ServiceManager/createService : " + e);
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
}