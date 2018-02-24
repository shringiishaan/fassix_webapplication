package manager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import model.Admin;

public class AdminManager 
{
	private DataSource dataSource;
	private Connection connection;
	private Statement statement;
	
	public AdminManager()
	{
		try 
		{
			Context initContext  = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			dataSource = (DataSource)envContext.lookup("hsolutionsDB");
		} 
		catch (Exception e) 
		{
			System.out.println("System Error : AdminManager : " + e);
		}
	}
	
	public Admin getAdminByID(int id)
	{
		ResultSet resultSet = null;
		Admin admin = null;
		try 
		{
			connection = dataSource.getConnection();
			statement = connection.createStatement();
			String query = "SELECT * FROM admin_master where id="+id+" ;";
			resultSet = statement.executeQuery(query);
			while (resultSet.next()) 
			{
				admin = new Admin();
				admin.setID(id);
				admin.setName(resultSet.getString("name"));
				admin.setEmail(resultSet.getString("email"));
				admin.setPassword(resultSet.getString("password"));
			}
		} 
		catch (SQLException e) 
		{
			System.out.println("System Error : AdminManager/getAdminByID : " + e);
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
		return admin;
	}
	
	public Admin getAdminByEmail(String email)
	{
		ResultSet resultSet = null;
		Admin admin = null;
		try 
		{
			// Get Connection and Statement
			connection = dataSource.getConnection();
			statement = connection.createStatement();
			String query = "SELECT * FROM admin_master where email='"+email+"' ;";
			resultSet = statement.executeQuery(query);
			while (resultSet.next()) 
			{
				admin = new Admin();
				admin.setID(resultSet.getInt("id"));
				admin.setName(resultSet.getString("name"));
				admin.setEmail(resultSet.getString("email"));
				admin.setPassword(resultSet.getString("password"));
			}
		} 
		catch (SQLException e) 
		{
			System.out.println("System Error : AdminManager/getAdminByEmail : " + e);
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
		return admin;
	}
	
	public boolean validateAdmin(String email, String password)
	{
		ResultSet resultSet = null;
		try 
		{
			connection = dataSource.getConnection();
			statement = connection.createStatement();
			String query = "SELECT password FROM admin_master where email='"+email+"' ;";
			resultSet = statement.executeQuery(query);
			while (resultSet.next()) 
			{
				return password.equals(resultSet.getString("password"));
			}
		} 
		catch (SQLException e) 
		{
			System.out.println("System Error : AdminManager/validateAdmin : " + e);
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
	
	public int getHomePageCount()
	{
		ResultSet resultSet = null;
		int count = 0;
		try 
		{
			connection = dataSource.getConnection();
			statement = connection.createStatement();
			String query = "SELECT value FROM web_data where name = 'homepagecount';";
			resultSet = statement.executeQuery(query);
			if(resultSet.next()) 
			{
				count = resultSet.getInt(1);
			}
		} 
		catch (SQLException e) 
		{
			System.out.println("System Error : AdminManager/validateAdmin : " + e);
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
		return count;
	}
	
	public void homePageCountIncrement()
	{
		try 
		{
			connection = dataSource.getConnection();
			statement = connection.createStatement();
			statement.execute("update web_data set value = value + 1 where name = 'homepagecount';");
		} 
		catch (SQLException e) 
		{
			System.out.println("System Error : AdminManager/homePageCountIncrement : " + e);
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
