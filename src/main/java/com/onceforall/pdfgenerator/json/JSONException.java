package com.onceforall.pdfgenerator.json;

/**
 * The JSONException is thrown by the JSON classes when things are amiss.
 * @version 2
 */
public class JSONException extends RuntimeException {
    private static final long serialVersionUID = 1L;
    private Throwable cause;

    /**
     * Constructs a JSONException with an explanatory message.
     * @param message Detail about the reason for the exception.
     */
    public JSONException(String message) {
        super(message);
    }

    public JSONException(Throwable t) {
        super(t.getMessage());
        this.cause = t;
    }

    public Throwable getCause() {
        return this.cause;
    }
}
