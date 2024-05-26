<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Liste des Ressources</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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
        .card-subtitle {
            font-size: 1rem;
            color: #666;
            margin-bottom: 10px;
        }
        .card-text {
            font-size: 1rem;
            color: #666;
            margin-bottom: 20px;
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
    </style>
</head>
<body>
<div class="sidebar">
    <img src="https://i.ibb.co/QNyXFY5/images.png" alt="Admin Image">
    <p>ADMIN</p>
    <ul>
        <li class="nav-item">
            <a class="nav-link" href="projects.jsp"><i class="fas fa-project-diagram"></i> Projects</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="tasks.jsp"><i class="fas fa-tasks"></i> Tasks</a>
        </li>
        <li class="nav-item">
            <a class="nav-link active" href="resources.jsp"><i class="fas fa-tools"></i> Resources</a>
        </li>
    </ul>
</div>

<div class="main-content">
    <div class="header">
        <i class="fas fa-tools"></i> Liste des Ressources
    </div>
    <button class="btn btn-primary mb-3" data-toggle="modal" data-target="#resourceModal" onclick="resetForm()">Créer une Nouvelle Ressource</button>
    <div class="row">
        <c:forEach var="resource" items="${resourceList}">
            <div class="col-md-4 mb-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">${resource.name}</h5>
                        <h6 class="card-subtitle mb-2 text-muted">ID: ${resource.id}</h6>
                        <p class="card-text">
                            <strong>Type:</strong> ${resource.type}<br>
                            <strong>Quantité:</strong> ${resource.quantity}
                        </p>
                        <button class="btn btn-warning mr-2" data-toggle="modal" data-target="#resourceModal" onclick="populateForm(${resource.id}, '${resource.name}', '${resource.type}', ${resource.quantity})">Modifier</button>
                        <a href="ResourceServlet?action=delete&id=${resource.id}&taskId=${taskId}" class="btn btn-danger mr-2">Supprimer</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<!-- Resource Modal -->
<div class="modal fade" id="resourceModal" tabindex="-1" role="dialog" aria-labelledby="resourceModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="resourceModalLabel">Formulaire Ressource</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="ResourceServlet" method="post" id="resourceForm">
                    <input type="hidden" name="id" id="resourceId">
                    <input type="hidden" name="taskId" value="${taskId}">
                    <input type="hidden" name="action" id="resourceAction" value="create">
                    <div class="form-group">
                        <label for="name">Nom</label>
                        <input type="text" class="form-control" id="name" name="name" required>
                    </div>
                    <div class="form-group">
                        <label for="type">Type</label>
                        <input type="text" class="form-control" id="type" name="type">
                    </div>
                    <div class="form-group">
                        <label for="quantity">Quantité</label>
                        <input type="number" class="form-control" id="quantity" name="quantity" required>
                    </div>
                    <button type="submit" class="btn btn-primary" id="formSubmitButton">Créer</button>
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
        document.getElementById('resourceForm').reset();
        document.getElementById('resourceId').value = '';
        document.getElementById('resourceAction').value = 'create';
        document.getElementById('formSubmitButton').innerText = 'Créer';
        document.getElementById('resourceModalLabel').innerText = 'Créer une Nouvelle Ressource';
    }

    function populateForm(id, name, type, quantity) {
        document.getElementById('resourceId').value = id;
        document.getElementById('name').value = name;
        document.getElementById('type').value = type;
        document.getElementById('quantity').value = quantity;
        document.getElementById('resourceAction').value = 'update';
        document.getElementById('formSubmitButton').innerText = 'Mettre à Jour';
        document.getElementById('resourceModalLabel').innerText = 'Modifier Ressource';
    }
</script>
</body>
</html>

