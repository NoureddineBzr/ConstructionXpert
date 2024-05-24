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
