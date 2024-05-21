package dao;

import connection.DatabaseConnection;
import model.Task;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TaskDAO {
    private Connection connection;

    public TaskDAO() {
        this.connection = DatabaseConnection.getConnection();
        if (this.connection == null) {
            throw new RuntimeException("Failed to connect to the database");
        }
    }

    public void addTask(Task task) {
        try {
            String query = "INSERT INTO tasks (description, start_date, end_date, status, project_id) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, task.getDescription());
            preparedStatement.setDate(2, new java.sql.Date(task.getStartDate().getTime()));
            preparedStatement.setDate(3, new java.sql.Date(task.getEndDate().getTime()));
            preparedStatement.setString(4, task.getStatus());
            preparedStatement.setInt(5, task.getProjectId());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateTask(Task task) {
        try {
            String query = "UPDATE tasks SET description = ?, start_date = ?, end_date = ?, status = ? WHERE id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, task.getDescription());
            preparedStatement.setDate(2, new java.sql.Date(task.getStartDate().getTime()));
            preparedStatement.setDate(3, new java.sql.Date(task.getEndDate().getTime()));
            preparedStatement.setString(4, task.getStatus());
            preparedStatement.setInt(5, task.getId());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteTask(int id) {
        try {
            String query = "DELETE FROM tasks WHERE id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Task getTaskById(int id) {
        Task task = null;
        try {
            String query = "SELECT * FROM tasks WHERE id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                task = new Task();
                task.setId(resultSet.getInt("id"));
                task.setDescription(resultSet.getString("description"));
                task.setStartDate(resultSet.getDate("start_date"));
                task.setEndDate(resultSet.getDate("end_date"));
                task.setStatus(resultSet.getString("status"));
                task.setProjectId(resultSet.getInt("project_id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return task;
    }

    public List<Task> getAllTasksByProject(int projectId) {
        List<Task> tasks = new ArrayList<>();
        try {
            String query = "SELECT * FROM tasks WHERE project_id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, projectId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Task task = new Task();
                task.setId(resultSet.getInt("id"));
                task.setDescription(resultSet.getString("description"));
                task.setStartDate(resultSet.getDate("start_date"));
                task.setEndDate(resultSet.getDate("end_date"));
                task.setStatus(resultSet.getString("status"));
                task.setProjectId(resultSet.getInt("project_id"));
                tasks.add(task);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tasks;
    }
}
