package com.onceforall.pdfgenerator.exception;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.onceforall.pdfgenerator.web.rest.errors.ErrorConstants;

@SuppressWarnings("serial")
public abstract class InternalException extends RuntimeException {

	private static final String DEFAULT_CODE = ErrorConstants.ERR_INTERNAL_SERVER_ERROR;
	
	private static final String DEFAULT_MESSAGE = "Internal server error";
			
	public InternalException(String message) {
		super(message != null ? message : DEFAULT_MESSAGE);
	}
	
	public Map<String, Object> getAdditionalData() {
		return new HashMap<>();
	}

	public String getCode() {
		return DEFAULT_CODE;
	}
	
	public int getStatusCode() {
		if (this.getClass().isAnnotationPresent(ResponseStatus.class)) {
			ResponseStatus annotation = this.getClass().getAnnotation(ResponseStatus.class);
			return annotation.value().value();
		}
		
		return HttpStatus.INTERNAL_SERVER_ERROR.value();
	}
}
