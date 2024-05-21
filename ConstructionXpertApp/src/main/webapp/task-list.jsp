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
    <a href="TaskServlet?action=new&projectId=${projectId}" class="btn btn-primary mb-3">Créer une Nouvelle Tâche</a>
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
                        <a href="TaskServlet?action=edit&id=${task.id}&projectId=${projectId}" class="btn btn-warning">Modifier</a>
                        <a href="TaskServlet?action=delete&id=${task.id}&projectId=${projectId}" class="btn btn-danger">Supprimer</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
</body>
</html>
