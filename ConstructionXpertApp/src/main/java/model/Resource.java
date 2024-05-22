package model;

public class Resource {
    private int id;
    private String name;
    private String type;
    private int quantity;
    private int taskId;
    private String suppName;  // Add this field
    private String suppContact;  // Add this field

    // Getters and Setters for all fields, including the new ones
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getTaskId() {
        return taskId;
    }

    public void setTaskId(int taskId) {
        this.taskId = taskId;
    }

    public String getSuppName() {
        return suppName;
    }

    public void setSuppName(String suppName) {
        this.suppName = suppName;
    }

    public String getSuppContact() {
        return suppContact;
    }

    public void setSuppContact(String suppContact) {
        this.suppContact = suppContact;
    }
}
