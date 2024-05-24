<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Project Form</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f0f2f5;
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background-color: #fff;
            border-radius: 8px;
            padding: 40px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .form-title {
            font-size: 1.5rem;
            font-weight: bold;
            color: #1877f2;
            margin-bottom: 20px;
            text-align: center;
        }
        .form-group label {
            font-weight: bold;
            color: #555;
        }
        .form-control {
            border-radius: 5px;
            border: 1px solid #ccc;
            padding: 10px;
            margin-bottom: 20px;
        }
        .btn-primary {
            background-color: #1877f2;
            border-color: #1877f2;
            border-radius: 5px;
            padding: 10px 30px;
            font-weight: bold;
            width: 100%;
        }
        .btn-primary:hover {
            background-color: #0e5a8a;
            border-color: #0e5a8a;
        }
    </style>
</head>
<body>
<div class="container">
    <h1 class="form-title">${project == null ? 'Create a New Project' : 'Edit Project'}</h1>
    <form action="ProjectServlet" method="post">
        <input type="hidden" name="id" value="${project.id}">
        <div class="form-group">
            <label for="name">Name</label>
            <input type="text" class="form-control" id="name" name="name" value="${project.name}" required>
        </div>
        <div class="form-group">
            <label for="description">Description</label>
            <textarea class="form-control" id="description" name="description" rows="3" required>${project.description}</textarea>
        </div>
        <div class="form-group">
            <label for="startDate">Start Date</label>
            <input type="date" class="form-control" id="startDate" name="startDate" value="${project.startDate}" required>
        </div>
        <div class="form-group">
            <label for="endDate">End Date</label>
            <input type="date" class="form-control" id="endDate" name="endDate" value="${project.endDate}" required>
        </div>
        <div class="form-group">
            <label for="budget">Budget</label>
            <input type="number" class="form-control" id="budget" name="budget" value="${project.budget}" required>
        </div>
        <button type="submit" class="btn btn-primary" name="action" value="${project == null ? 'create' : 'update'}">
            ${project == null ? 'Create' : 'Update'}
        </button>
    </form>
</div>
</body>
</html>
