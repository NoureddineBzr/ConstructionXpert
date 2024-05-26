package servlets;

import dao.ResourceDAO;
import model.Resource;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/ResourceServlet")
public class ResourceServlet extends HttpServlet {
    private ResourceDAO resourceDAO;

    @Override
    public void init() throws ServletException {
        resourceDAO = new ResourceDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("create".equals(action)) {
            createResource(request, response);
        } else if ("update".equals(action)) {
            updateResource(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                listResources(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteResource(request, response);
                break;
            case "new":
                showNewForm(request, response);
                break;
            default:
                listResources(request, response);
                break;
        }
    }

    private void listResources(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String taskIdStr = request.getParameter("taskId");
        if (taskIdStr == null || taskIdStr.isEmpty()) {
            throw new ServletException("Task ID is missing for list resources.");
        }
        int taskId = Integer.parseInt(taskIdStr);
        List<Resource> resourceList = resourceDAO.getAllResourcesByTask(taskId);
        request.setAttribute("resourceList", resourceList);
        request.setAttribute("taskId", taskId);
        request.getRequestDispatcher("resource-list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String taskIdStr = request.getParameter("taskId");
        if (taskIdStr == null || taskIdStr.isEmpty()) {
            throw new ServletException("Task ID is missing for new resource form.");
        }
        int taskId = Integer.parseInt(taskIdStr);
        request.setAttribute("taskId", taskId);
        request.getRequestDispatcher("resource-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            throw new ServletException("Resource ID is missing for edit resource form.");
        }
        int id = Integer.parseInt(idStr);
        Resource existingResource = resourceDAO.getResourceById(id);
        request.setAttribute("resource", existingResource);
        request.setAttribute("taskId", existingResource.getTaskId());
        request.getRequestDispatcher("resource-form.jsp").forward(request, response);
    }

    private void createResource(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String name = request.getParameter("name");
        String type = request.getParameter("type");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        int taskId = Integer.parseInt(request.getParameter("taskId"));
        String suppName = request.getParameter("suppName");
        String suppContact = request.getParameter("suppContact");

        Resource newResource = new Resource();
        newResource.setName(name);
        newResource.setType(type);
        newResource.setQuantity(quantity);
        newResource.setTaskId(taskId);
        newResource.setSuppName(suppName);
        newResource.setSuppContact(suppContact);

        resourceDAO.addResource(newResource);
        response.sendRedirect("ResourceServlet?action=list&taskId=" + taskId);
    }

    private void updateResource(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String type = request.getParameter("type");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        int taskId = Integer.parseInt(request.getParameter("taskId"));
        String suppName = request.getParameter("suppName");
        String suppContact = request.getParameter("suppContact");

        Resource resource = new Resource();
        resource.setId(id);
        resource.setName(name);
        resource.setType(type);
        resource.setQuantity(quantity);
        resource.setTaskId(taskId);
        resource.setSuppName(suppName);
        resource.setSuppContact(suppContact);

        resourceDAO.updateResource(resource);
        response.sendRedirect("ResourceServlet?action=list&taskId=" + taskId);
    }

    private void deleteResource(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        resourceDAO.deleteResource(id);
        String taskId = request.getParameter("taskId");
        response.sendRedirect("ResourceServlet?action=list&taskId=" + taskId);
    }
}
