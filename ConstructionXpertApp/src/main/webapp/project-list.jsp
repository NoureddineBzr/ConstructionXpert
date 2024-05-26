<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f8f9fa;
            display: flex;
        }
        .sidebar {
            background-color: #fff;
            width: 200px;
            height: 100vh;
            padding-top: 20px;
            position: fixed;
            border-right: 1px solid #ddd;
        }
        .sidebar img {
            width: 80px;
            border-radius: 50%;
            display: block;
            margin: 0 auto;
        }
        .sidebar p {
            text-align: center;
            font-weight: bold;
            color: #333;
        }
        .sidebar .nav-item {
            list-style: none;
            padding: 10px;
        }
        .sidebar .nav-link {
            color: #333;
            text-decoration: none;
            display: block;
            padding: 10px;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .sidebar .nav-link.active, .sidebar .nav-link:hover {
            background-color: #007bff;
            color: #fff;
        }
        .main-content {
            margin-left: 220px;
            padding: 20px;
            width: calc(100% - 220px);
        }
        .header {
            background-color: #007bff;
            color: #fff;
            padding: 10px 20px;
            border-radius: 5px;
            margin-bottom: 20px;
            font-size: 24px;
        }
        .btn-create {
            display: block;
            margin: 20px 0;
            background-color: #007bff;
            border: none;
            color: #fff;
            padding: 10px 20px;
            border-radius: 5px;
            text-align: left;
            transition: background-color 0.3s;
        }
        .btn-create:hover {
            background-color: #0056b3;
        }
        .card {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 12px rgba(0, 0, 0, 0.1);
        }
        .card-body {
            padding: 20px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        .card-title {
            font-weight: 700;
            font-size: 1.5rem;
            margin-bottom: 10px;
        }
        .card-text {
            font-size: 1rem;
            color: #666;
            margin-bottom: 20px;
        }
        .card-buttons {
            display: flex;
            justify-content: center;
            gap: 10px;
        }
        .btn-warning {
            background-color: #ffc107;
            border-color: #ffc107;
            color: #000;
            transition: background-color 0.3s;
        }
        .btn-warning:hover {
            background-color: #e0a800;
            border-color: #e0a800;
        }
        .btn-danger {
            background-color: #dc3545;
            border-color: #dc3545;
            color: #fff;
            transition: background-color 0.3s;
        }
        .btn-danger:hover {
            background-color: #c82333;
            border-color: #c82333;
        }
        .btn-info {
            background-color: #17a2b8;
            border-color: #17a2b8;
            color: #fff;
            transition: background-color 0.3s;
        }
        .btn-info:hover {
            background-color: #138496;
            border-color: #138496;
        }
    </style>
</head>
<body>
<div class="sidebar">
    <img src="https://i.ibb.co/QNyXFY5/images.png" alt="Admin Image">
    <p>ADMIN</p>
    <ul>
        <li class="nav-item">
            <a class="nav-link active" href="projects.jsp"><i class="fas fa-project-diagram"></i> Projects</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="tasks.jsp"><i class="fas fa-tasks"></i> Tasks</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="resources.jsp"><i class="fas fa-tools"></i> Resources</a>
        </li>
    </ul>
</div>

<div class="main-content">
    <div class="header">
        <i class="fas fa-tachometer-alt"></i> Projects Management
    </div>
    <button class="btn-create" data-toggle="modal" data-target="#projectModal" onclick="resetForm()">
        <i class="fas fa-plus-circle"></i> Create new Project
    </button>
    <div class="row">
        <c:forEach var="project" items="${projectList}">
            <div class="col-md-4 mb-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">${project.name}</h5>
                        <p class="card-text">
                            <strong>Description:</strong> ${project.description}<br>
                            <strong>Start Date:</strong> ${project.startDate}<br>
                            <strong>End Date:</strong> ${project.endDate}<br>
                            <strong>Budget:</strong> ${project.budget}
                        </p>
                        <div class="card-buttons">
                            <button class="btn btn-warning" data-toggle="modal" data-target="#projectModal" onclick="populateForm(${project.id}, '${project.name}', '${project.description}', '${project.startDate}', '${project.endDate}', ${project.budget})">
                                <i class="fas fa-edit"></i> Edit
                            </button>
                            <a href="ProjectServlet?action=delete&id=${project.id}" class="btn btn-danger">
                                <i class="fas fa-trash-alt"></i> Delete
                            </a>
                            <a href="TaskServlet?action=list&projectId=${project.id}" class="btn btn-info">
                                <i class="fas fa-tasks"></i> Manage Tasks
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<!-- Project Modal -->
<div class="modal fade" id="projectModal" tabindex="-1" role="dialog" aria-labelledby="projectModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="projectModalLabel">Project Form</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="ProjectServlet" method="post" id="projectForm">
                    <input type="hidden" name="id" id="projectId">
                    <div class="form-group">
                        <label for="name">Name</label>
                        <input type="text" class="form-control" id="name" name="name" required>
                    </div>
                    <div class="form-group">
                        <label for="description">Description</label>
                        <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
                    </div>
                    <div class="form-group">
                        <label for="startDate">Start Date</label>
                        <input type="date" class="form-control" id="startDate" name="startDate" required>
                    </div>
                    <div class="form-group">
                        <label for="endDate">End Date</label>
                        <input type="date" class="form-control" id="endDate" name="endDate" required>
                    </div>
                    <div class="form-group">
                        <label for="budget">Budget</label>
                        <input type="number" class="form-control" id="budget" name="budget" required>
                    </div>
                    <button type="submit" class="btn btn-primary" id="formSubmitButton" name="action" value="create">Create</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    function resetForm() {
        document.getElementById('projectForm').reset();
        document.getElementById('projectId').value = '';
        document.getElementById('formSubmitButton').innerText = 'Create';
        document.getElementById('formSubmitButton').value = 'create';
        document.getElementById('projectModalLabel').innerText = 'Create Project';
    }

    function populateForm(id, name, description, startDate, endDate, budget) {
        document.getElementById('projectId').value = id;
        document.getElementById('name').value = name;
        document.getElementById('description').value = description;
        document.getElementById('startDate').value = startDate;
        document.getElementById('endDate').value = endDate;
        document.getElementById('budget').value = budget;
        document.getElementById('formSubmitButton').innerText = 'Update';
        document.getElementById('formSubmitButton').value = 'update';
        document.getElementById('projectModalLabel').innerText = 'Edit Project';
    }
</script>
</body>
</html>
