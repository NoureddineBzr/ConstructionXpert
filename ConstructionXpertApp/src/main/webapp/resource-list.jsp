<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Liste des Ressources</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
    <h1 class="mt-5">Liste des Ressources</h1>
    <a href="ResourceServlet?action=new&taskId=${taskId}" class="btn btn-primary mb-3">Créer une Nouvelle Ressource</a>
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
                        <a href="ResourceServlet?action=edit&id=${resource.id}&taskId=${taskId}" class="btn btn-warning">Modifier</a>
                        <a href="ResourceServlet?action=delete&id=${resource.id}&taskId=${taskId}" class="btn btn-danger">Supprimer</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
</body>
</html>
