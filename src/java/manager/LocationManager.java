package manager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import model.Location;

public class LocationManager 
{
	private DataSource dataSource;
	private Connection connection;
	private Statement statement;
	
	public LocationManager()
	{
		try 
		{
			Context initContext  = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			dataSource = (DataSource)envContext.lookup("hsolutionsDB");
		} 
		catch (Exception e) 
		{
			System.out.println("System Error : LocationManager : " + e);
		}
	}
	
	public Location getLocationByID(int id)
	{
		ResultSet resultSet = null;
		Location location = null;
		try 
		{
			connection = dataSource.getConnection();
			statement = connection.createStatement();
			String query = "SELECT * FROM location_master where id="+id+" ;";
			resultSet = statement.executeQuery(query);
			resultSet.next();
			location = new Location();
			location.setID(id);
			location.setCity(resultSet.getString("city"));
			location.setArea(resultSet.getString("area"));
		} 
		catch (SQLException e) 
		{
			System.out.println("System Error : LocationManager/getLocationByID : " + e);
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
		return location;
	}
	
	public Location getLocationByArea(String area)
	{
		ResultSet resultSet = null;
		Location location = null;
		try 
		{
			connection = dataSource.getConnection();
			statement = connection.createStatement();
			String query = "SELECT * FROM location_master where area='"+area+"' ;";
			resultSet = statement.executeQuery(query);
			resultSet.next();
			location = new Location();
			location.setID(resultSet.getInt("id"));
			location.setCity(resultSet.getString("city"));
			location.setArea(resultSet.getString("area"));
		} 
		catch (SQLException e) 
		{
			System.out.println("System Error : LocationManager/getLocationByArea : " + e);
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
		return location;
	}
	
	public ArrayList<Location> getLocationsByCity(String city)
	{
		ResultSet resultSet = null;
		ArrayList<Location> locations = new ArrayList<Location>();
		Location location;
		
		try 
		{
			connection = dataSource.getConnection();
			statement = connection.createStatement();
			String query = "SELECT * FROM location_master where city='"+city+"' order by area asc ;";
			resultSet = statement.executeQuery(query);
			while(resultSet.next())
			{
				location = new Location();
				location.setID(resultSet.getInt("id"));
				location.setCity(city);
				location.setArea(resultSet.getString("area"));
				locations.add(location);
			}
		} 
		catch (SQLException e) 
		{
			System.out.println("System Error : LocationManager/getLocationByCity : " + e);
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
		return locations;
	}
}
