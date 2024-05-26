package dao;

import connection.DatabaseConnection;
import model.Resource;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ResourceDAO {
    private Connection connection;

    public ResourceDAO() {
        this.connection = DatabaseConnection.getConnection();
        if (this.connection == null) {
            throw new RuntimeException("Failed to connect to the database");
        }
    }

    public void addResource(Resource resource) {
        try {
            String query = "INSERT INTO resources (name, type, quantity, task_id, supp_name, supp_contact) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, resource.getName());
            preparedStatement.setString(2, resource.getType());
            preparedStatement.setInt(3, resource.getQuantity());
            preparedStatement.setInt(4, resource.getTaskId());
            preparedStatement.setString(5, resource.getSuppName());
            preparedStatement.setString(6, resource.getSuppContact());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateResource(Resource resource) {
        try {
            String query = "UPDATE resources SET name = ?, type = ?, quantity = ?, supp_name = ?, supp_contact = ? WHERE id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, resource.getName());
            preparedStatement.setString(2, resource.getType());
            preparedStatement.setInt(3, resource.getQuantity());
            preparedStatement.setString(4, resource.getSuppName());
            preparedStatement.setString(5, resource.getSuppContact());
            preparedStatement.setInt(6, resource.getId());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteResource(int id) {
        try {
            String query = "DELETE FROM resources WHERE id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Resource getResourceById(int id) {
        Resource resource = null;
        try {
            String query = "SELECT * FROM resources WHERE id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                resource = new Resource();
                resource.setId(resultSet.getInt("id"));
                resource.setName(resultSet.getString("name"));
                resource.setType(resultSet.getString("type"));
                resource.setQuantity(resultSet.getInt("quantity"));
                resource.setTaskId(resultSet.getInt("task_id"));
                resource.setSuppName(resultSet.getString("supp_name"));
                resource.setSuppContact(resultSet.getString("supp_contact"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return resource;
    }

    public List<Resource> getAllResourcesByTask(int taskId) {
        List<Resource> resources = new ArrayList<>();
        try {
            String query = "SELECT * FROM resources WHERE task_id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, taskId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Resource resource = new Resource();
                resource.setId(resultSet.getInt("id"));
                resource.setName(resultSet.getString("name"));
                resource.setType(resultSet.getString("type"));
                resource.setQuantity(resultSet.getInt("quantity"));
                resource.setTaskId(resultSet.getInt("task_id"));
                resource.setSuppName(resultSet.getString("supp_name"));
                resource.setSuppContact(resultSet.getString("supp_contact"));
                resources.add(resource);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return resources;
    }
}
