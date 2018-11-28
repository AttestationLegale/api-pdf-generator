package com.onceforall.pdfgenerator.web.rest.errors;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * View Model for transferring error message with a list of field errors.
 */
public class ErrorVM implements Serializable {

    private static final long serialVersionUID = 1L;

    private final String message;
    private final String description;

    private List<FieldErrorVM> fieldErrors = new ArrayList<>();

    private List<StackTraceElement> stackTraceElements = new ArrayList<>();

    public ErrorVM(String message) {
        this(message, null);
    }

    public ErrorVM(String message, String description) {
        this.message = message;
        this.description = description;
    }

    public ErrorVM(String message, String description, List<FieldErrorVM> fieldErrors, List<StackTraceElement> stackTraceElements) {
        this.message = message;
        this.description = description;
        this.fieldErrors = fieldErrors;
        this.stackTraceElements = stackTraceElements;
    }

    public void add(String objectName, String field, String message) {
        fieldErrors.add(new FieldErrorVM(objectName, field, message));
    }

    public String getMessage() {
        return message;
    }

    public String getDescription() {
        return description;
    }

    public List<FieldErrorVM> getFieldErrors() {
        return fieldErrors;
    }

    public List<StackTraceElement> getStackTraceElements() {
        return stackTraceElements;
    }
    
    public void setStackTraceElements(List<StackTraceElement> stackTraceElements) {
        this.stackTraceElements = stackTraceElements;
    }
}