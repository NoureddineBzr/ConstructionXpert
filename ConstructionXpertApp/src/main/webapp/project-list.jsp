<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f8f9fa;
        }
        .container {
            padding-top: 50px;
        }
        .card {
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 12px rgba(0, 0, 0, 0.1);
        }
        .btn {
            border-radius: 5px;
            transition: all 0.3s ease;
        }
        .btn-primary {
            background-color: #4caf50;
            border-color: #4caf50;
        }
        .btn-primary:hover {
            background-color: #66bb6a;
            border-color: #66bb6a;
        }
        .btn-warning {
            background-color: #ffb74d;
            border-color: #ffb74d;
        }
        .btn-warning:hover {
            background-color: #ffa726;
            border-color: #ffa726;
        }
        .btn-danger {
            background-color: #ef5350;
            border-color: #ef5350;
        }
        .btn-danger:hover {
            background-color: #e57373;
            border-color: #e57373;
        }
        .btn-info {
            background-color: #64b5f6;
            border-color: #64b5f6;
        }
        .btn-info:hover {
            background-color: #42a5f5;
            border-color: #42a5f5;
        }
        .btn-outline-light {
            color: #000;
            border-color: #4caf50;
        }
        .btn-outline-light:hover {
            background-color: #4caf50;
            border-color: #4caf50;
            color: #fff;
        }
        .btn-outline-light:focus {
            box-shadow: none;
        }
        .header {
            background-color: #4caf50;
            color: #fff;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
        }
        .header h1 {
            margin: 0;
            font-weight: 700;
            text-transform: uppercase;
        }
        .btn-create {
            margin-bottom: 20px;
        }
        .card-body {
            padding: 20px;
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
            margin-top: 10px;
        }
        .navbar-brand img {
            height: 50px;
        }
        .nav-item .nav-link.active {
            font-weight: bold;
            color: #4caf50 !important;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="#">
        <img src="https://i.ibb.co/QNyXFY5/images.png">
        Admin Name
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item">
                <a class="nav-link active" href="projects.jsp">Projects</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="tasks.jsp">Tasks</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="resources.jsp">Resources</a>
            </li>
        </ul>
    </div>
</nav>
<div class="container">
    <div class="header">
        <h1>Admin Dashboard</h1>
    </div>
    <button class="btn btn-primary btn-create" data-toggle="modal" data-target="#projectModal" onclick="resetForm()">Create New Project</button>
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
                            <button class="btn btn-warning mr-2" data-toggle="modal" data-target="#projectModal" onclick="populateForm(${project.id}, '${project.name}', '${project.description}', '${project.startDate}', '${project.endDate}', ${project.budget})">Edit</button>
                            <a href="ProjectServlet?action=delete&id=${project.id}" class="btn btn-danger mr-2">Delete</a>
                            <a href="TaskServlet?action=list&projectId=${project.id}" class="btn btn-info">Manage Tasks</a>
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
