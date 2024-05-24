<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Liste des Tâches</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
    <h1 class="mt-5">Liste des Tâches</h1>
    <button class="btn btn-primary mb-3" data-toggle="modal" data-target="#taskModal" onclick="resetForm()">Créer une Nouvelle Tâche</button>
    <div class="row">
        <c:forEach var="task" items="${taskList}">
            <div class="col-md-4 mb-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">${task.description}</h5>
                        <h6 class="card-subtitle mb-2 text-muted">ID: ${task.id}</h6>
                        <p class="card-text">
                            <strong>Date de Début:</strong> ${task.startDate}<br>
                            <strong>Date de Fin:</strong> ${task.endDate}<br>
                            <strong>Statut:</strong> ${task.status}
                        </p>
                        <button class="btn btn-warning mr-2" data-toggle="modal" data-target="#taskModal" onclick="populateForm(${task.id}, '${task.description}', '${task.startDate}', '${task.endDate}', '${task.status}')">Modifier</button>
                        <a href="TaskServlet?action=delete&id=${task.id}&projectId=${projectId}" class="btn btn-danger mr-2">Supprimer</a>
                        <a href="ResourceServlet?action=list&taskId=${task.id}" class="btn btn-info">Gérer les Ressources</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<!-- Task Modal -->
<div class="modal fade" id="taskModal" tabindex="-1" role="dialog" aria-labelledby="taskModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="taskModalLabel">Formulaire de Tâche</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="TaskServlet" method="post" id="taskForm">
                    <input type="hidden" name="id" id="taskId">
                    <input type="hidden" name="projectId" value="${projectId}">
                    <input type="hidden" name="action" id="taskAction" value="create">
                    <div class="form-group">
                        <label for="description">Description</label>
                        <input type="text" class="form-control" id="description" name="description" required>
                    </div>
                    <div class="form-group">
                        <label for="startDate">Date de Début</label>
                        <input type="date" class="form-control" id="startDate" name="startDate" required>
                    </div>
                    <div class="form-group">
                        <label for="endDate">Date de Fin</label>
                        <input type="date" class="form-control" id="endDate" name="endDate" required>
                    </div>
                    <div class="form-group">
                        <label for="status">Statut</label>
                        <select class="form-control" id="status" name="status">
                            <option value="a faire">À faire</option>
                            <option value="en cours">En cours</option>
                            <option value="terminee">Terminée</option>
                        </select>
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
        document.getElementById('taskForm').reset();
        document.getElementById('taskId').value = '';
        document.getElementById('taskAction').value = 'create';
        document.getElementById('formSubmitButton').innerText = 'Créer';
        document.getElementById('taskModalLabel').innerText = 'Créer une Nouvelle Tâche';
    }

    function populateForm(id, description, startDate, endDate, status) {
        document.getElementById('taskId').value = id;
        document.getElementById('description').value = description;
        document.getElementById('startDate').value = startDate;
        document.getElementById('endDate').value = endDate;
        document.getElementById('status').value = status;
        document.getElementById('taskAction').value = 'update';
        document.getElementById('formSubmitButton').innerText = 'Mettre à Jour';
        document.getElementById('taskModalLabel').innerText = 'Modifier la Tâche';
    }
</script>
</body>
</html>
