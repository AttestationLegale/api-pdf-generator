package com.onceforall.pdfgenerator.web.rest.errors;

import java.util.HashMap;
import java.util.Map;

public class ErrorVM {

    private final String message;
    
    private final String description;

    private Map<String, Object> additionalData = new HashMap<>();

    public ErrorVM(String message) {
        this(message, null);
    }

    public ErrorVM(String message, String description) {
        this.message = message;
        this.description = description;
    }

    public void addAdditionalData(String key, Object object) {
    	additionalData.put(key, object);
    }
    
    public void addAdditionalData(Map<String, Object> additionalData) {
    	this.additionalData.putAll(additionalData);
    }
    
    public String getMessage() {
        return message;
    }

    public String getDescription() {
        return description;
    }

    public Map<String, Object> getAdditionalData() {
        return additionalData;
    }
}