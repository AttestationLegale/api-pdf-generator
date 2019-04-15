package com.onceforall.pdfgenerator.web.rest.errors;

import java.util.HashMap;
import java.util.Map;

public class ErrorVM {

    private final String message;
    
    private final String description;

    private Map<String, Object> additionnalData = new HashMap<>();

    public ErrorVM(String message) {
        this(message, null);
    }

    public ErrorVM(String message, String description) {
        this.message = message;
        this.description = description;
    }

    public void addAdditionnalData(String key, Object object) {
    	additionnalData.put(key, object);
    }
    
    public void addAdditionnalData(Map<String, Object> additionnalData) {
    	this.additionnalData.putAll(additionnalData);
    }
    
    public String getMessage() {
        return message;
    }

    public String getDescription() {
        return description;
    }

    public Map<String, Object> getAdditionnalData() {
        return additionnalData;
    }
}